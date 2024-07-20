class PokemonsController < ApplicationController
  before_action :set_pokemon, only: %i[ show update destroy ]

  # GET /pokemons
  def index
    @pokemons = Pokemon.all

    render json: @pokemons
  end

  # GET /pokemons/1
  def show
    render json: @pokemon
  end

  # POST /pokemons
  def create
    @pokemon = Pokemon.new(pokemon_params)

    if @pokemon.save
      render json: @pokemon, status: :created, location: @pokemon
    else
      render json: @pokemon.errors, status: :unprocessable_entity
    end
  end

  # GET /pokemon/:id/checkout
  def checkout
    pokemon = Pokemon.find(params[:id])
    if current_user.balance >= pokemon.price
      render json: { can_buy: true, pokemon: pokemon }
    else
      render json: { can_buy: false, message: 'Insufficient balance' }
    end
  end

  # POST /pokemon/:id/buy
  def buy
    seller_id = 2
    seller = User.find(seller_id)
    pokemon = Pokemon.find(params[:id])
    if current_user.balance >= pokemon.price
      ActiveRecord::Base.transaction do
        current_user.update!(balance: current_user.balance - pokemon.price)
        seller.update!(balance: current_user.balance + pokemon.price)
        pokemon.update!(user: current_user, last_sell_price: pokemon.price)
        Transaction.create!(user: current_user, pokemon: pokemon, action: 'buy')
      end
      render json: { message: 'Purchase successful', pokemon: pokemon }
    else
      render json: { message: 'Insufficient balance', status: :unprocessable_entity }
    end
  end

  # POST /pokemon/:id/sell
  def sell
    buyer_id = 2
    buyer = User.find(buyer_id)
    pokemon = Pokemon.find(params[:id])
    if pokemon.user == current_user
      ActiveRecord::Base.transaction do
        current_user.update!(balance: current_user.balance + pokemon.price)
        buyer.update!(balance: current_user.balance - pokemon.price)
        pokemon.update!(user_id: buyer_id, last_sell_price: pokemon.price)
        Transaction.create!(user: current_user, pokemon: pokemon, action: 'sell')
      end
      render json: { message: 'Sale successful', pokemon: pokemon }
    else
      render json: { message: 'You do not own this Pokemon' }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /pokemons/1
  def update
    if @pokemon.update(pokemon_params)
      render json: @pokemon
    else
      render json: @pokemon.errors, status: :unprocessable_entity
    end
  end

  # DELETE /pokemons/1
  def destroy
    @pokemon.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pokemon
      @pokemon = Pokemon.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def pokemon_params
      params.require(:pokemon).permit(:name, :image_path, :weight, :height, :price, :last_sell_price, :user_id)
    end
end
