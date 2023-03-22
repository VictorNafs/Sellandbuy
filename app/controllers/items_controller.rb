class ItemsController < ApplicationController
  before_action :set_item, only: %i[ show edit update destroy ]

  def checkout
    @item = Item.find(params[:id])
  end
  
  def charge
    @item = Item.find(params[:id])
  
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
  
    transaction = Transaction.new(user: current_user, item: @item)
    transaction.save
  
    flash[:notice] = "Paiement effectué avec succès"
    redirect_to items_path
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to checkout_item_path(@item)
  end
  

  # GET /items or /items.json
  def index
    @items = Item.all
  end

  # GET /items/1 or /items/1.json
  def show
  end

  # GET /items/new
  def new
    @item = Item.new
  end

  # GET /items/1/edit
  def edit
  end

  # POST /items or /items.json
  def create
    @item = Item.new(item_params)
    @item.user_id = current_user.id
    respond_to do |format|
      if @item.save
        format.html { redirect_to item_url(@item), notice: "Item was successfully created." }
        format.json { render :show, status: :created, location: @item }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /items/1 or /items/1.json
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

  # DELETE /items/1 or /items/1.json
  def destroy
    @item.destroy

    respond_to do |format|
      format.html { redirect_to items_url, notice: "Item was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = Item.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def item_params
      params.require(:item).permit(:title, :description)
      params.require(:item).permit(:title, :description, :price)
    end
end
