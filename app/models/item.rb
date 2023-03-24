class Item < ApplicationRecord
   has_one_attached :photo
  belongs_to :user
    has_one :Transaction
    has_many :users, through: :transactions
    validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }

  end
  