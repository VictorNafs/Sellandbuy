class Transaction < ApplicationRecord
    belongs_to :user
  belongs_to :item

  validates :street, presence: true
  validates :zip_code, presence: true
  validates :city, presence: true

  after_create :order_email

         
  def order_email
    UserMailer.confirmation_email(@transaction).deliver_now
  end
end
