class Pokemon < ApplicationRecord
  belongs_to :user
  has_many :transactions

  validates :name, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }
  validates :last_sell_price, numericality: { greater_than_or_equal_to: 0 }
end
