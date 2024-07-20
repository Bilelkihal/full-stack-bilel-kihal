class User < ApplicationRecord
  has_secure_password
  has_many :pokemons
  has_many :transactions

  validates :email, presence: true, uniqueness: true
  validates :balance, numericality: { greater_than_or_equal_to: 0 }
end
