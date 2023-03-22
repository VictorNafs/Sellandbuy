class Item < ApplicationRecord
    belongs_to :user
    has_one :Transaction
    has_many :users, through: :transactions
    validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  end
  