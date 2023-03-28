class ItemsController < ApplicationController
  before_action :set_item, only: %i[show edit update destroy]
  before_action :verif_buyer, only: %i[edit update destroy]
<<<<<<< HEAD
  before_action :set_categories, 
 
  def checkout
    @transaction = Transaction.new
  end

  def charge
    customer = Stripe::Customer.create(
      email: current_user.email,
      source: params[:stripeToken]
    )
  
    charge = Stripe::Charge.create(
      customer: customer.id,
      amount: @item.price * 100,
      description: "Achat #{@item.title}",
      currency: 'eur'
    )
  
    transaction = @item.transactions.build(transaction_params)
    transaction.user = current_user
  
    if transaction.save
      flash[:notice] = "Paiement effectué avec succès"
      redirect_to items_path
    else
      flash[:error] = "Erreur lors de la sauvegarde de la transaction"
      redirect_to checkout_item_path(@item)
    end
  
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to checkout_item_path(@item)
  end
=======
>>>>>>> main

  def index
    @items = Item.with_attached_photo.order(created_at: :desc)

    if params[:category_id].present?
      @items = @items.where(category_id: params[:category_id])
    end
    
    if params[:min_price].present?
      @items = @items.where("price >= ?", params[:min_price])
    end
    
    if params[:max_price].present?
      @items = @items.where("price <= ?", params[:max_price])
    end
    
    if params[:query_text].present?
      @items = @items.search_full_text(params[:query_text])
    end
    
    if params[:sort_by_price] == 'asc'
      @items = @items.order(price: :asc)
    elsif params[:sort_by_price] == 'desc'
      @items = @items.order(price: :desc)
    end
    
    @items = @items.order(created_at: :desc)

    @items = Item.all
    flash.now[:notice] = "Actuellement : #{@items.count} produits proposés!"   
  end

  def show
    @transaction = Transaction.new
  end

  def new
    @item = Item.new
    @categories = Category.all
  end

  def edit
  end

  def create
    if current_user
      @item = current_user.items.build(item_params)
  
      respond_to do |format|
        if @item.save
          format.html { redirect_to item_url(@item), notice: "Item was successfully created." }
          format.json { render :show, status: :created, location: @item }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @item.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to new_user_session_path, alert: "Vous devez être connecté pour créer un article."
    end
  end

  def update
    respond_to do |format|
      if @item.update(item_params)
        format.html { redirect_to item_url(@item), notice: "Item was successfully updated." }
        format.json { render :show, status: :ok, location: @item }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @item.destroy

    respond_to do |format|
      format.html { redirect_to items_url, notice: "Item was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def checkout
    @transaction = Transaction.new
    @item = Item.find(params[:id])
  end
  

  def create
    @item = Item.find(params[:item_id])
    @transaction = @item.transactions.build(transaction_params)
    @transaction.user = current_user

    if @transaction.save
      # Mark item as sold
      @item.update(sold: true)
  
      # Send email to seller
      UserMailer.with(user: @item.user, item: @item).sold_email.deliver_later
  
      flash[:notice] = "Paiement effectué avec succès"
      redirect_to checkout_items_path
    else
      flash[:error] = "Erreur lors de la sauvegarde de la transaction"
      redirect_to checkout_item_path(@item)
    end

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to checkout_item_path(@item)
  rescue Stripe::InvalidRequestError, Stripe::AuthenticationError, Stripe::APIConnectionError, Stripe::StripeError => e
    flash[:error] = "Erreur lors du paiement"
    redirect_to checkout_item_path(@item)
  end

<<<<<<< HEAD
  def set_categories
@categories = Category.all.order(:name)
  end
=======
  private
>>>>>>> main

  def set_item
    @item = Item.find(params[:id])
  end

  def transaction_params
    params.require(:transaction).permit(:item_id, :user_id, :street, :zip_code, :city)
  end
end
