class Item < ApplicationRecord

  belongs_to :user
  has_one :Transaction
  has_many :users, through: :Transactions
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :title, presence: true
  validate :validation_length
  has_one_attached :photo

  private
  
  def validation_length 
    if description.length > 50
      errors.add(:description, 'Pas plus de 50 caractères svp')
    end
    if title.length > 27
      errors.add(:description, 'Titre trop long. Pas plus de 27 caractères svp')
    end

  end
end

