class Transaction < ApplicationRecord
    belongs_to :user
  belongs_to :item

  validates :street, presence: true
  validates :zip_code, presence: true
  validates :city, presence: true

end
