class TransactionsController < ApplicationController
  before_action :set_item, only: [:new, :create]

  def new
    @transaction = Transaction.new
  end

  def create
    @transaction = Transaction.new(transaction_params)
    @transaction.user = current_user
    @transaction.item = @item

    if @transaction.save
      redirect_to checkout_item_path(@transaction.item), notice: 'Transaction was successfully created.'
    else
<<<<<<< HEAD
      redirect_to root_path
=======
puts "Veuillez renseigner une adresse"
>>>>>>> cb032a85e75604c24f9c5ed60b45e1942bfdeb7f
    end
  end

  private

  def set_item
    @item = Item.find(params[:item_id])
  end

  def transaction_params
    params.require(:transaction).permit(:item_id, :user_id, :street, :zip_code, :city)
  end
end
