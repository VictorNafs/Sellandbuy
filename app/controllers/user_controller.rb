class UserController < ApplicationController
  def sold
    @user_items = Item.where(user_id: current_user.id)
  end

  def paid
    
    @transactions = Transaction.where(user_id: current_user.id)
    @transactions.each do |transaction|
      item = Item.find(transaction.item_id)
      item_title = item.title
      # Faites quelque chose avec item_title, par exemple l'ajouter à une liste pour l'afficher dans la vue
    end
  end

  def order
end
end
