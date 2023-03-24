class TransactionsController < ApplicationController
  def create
    @transaction = Transaction.new(transaction_params)
    @transaction.item_id = params[:item_id]
    @transaction.user_id = current_user.id

    if @transaction.save
      redirect_to root_path, notice: "L'article a été ajouté au panier."
    else
      redirect_to root_path, alert: "Une erreur est survenue lors de l'ajout de l'article au panier."
    end
  end

  private

  def transaction_params
    params.require(:transaction).permit(:item_id, :user_id, :street, :zip_code, :city)
  end
end
