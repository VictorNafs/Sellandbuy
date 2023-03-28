class ItemsController < ApplicationController
  before_action :set_item, only: %i[show edit update destroy]

  def checkout
    @transaction = Transaction.new
    @item = Item.find(params[:id])
  end

  def charge
    @item = Item.find(params[:id])

  # Vérifier si les champs sont remplis
  if transaction_params.values.any?(&:blank?)
    flash[:error] = "Veuillez remplir tous les champs"
    redirect_to show_item_path(@item)
    return
  end

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

  transaction = Transaction.new(transaction_params)
  transaction.item = @item
  transaction.user = current_user

  if transaction.save
    flash[:notice] = "Paiement effectué avec succès"
    redirect_to checkout_item_path(@item)
  else
    flash[:error] = "Erreur lors de la sauvegarde de la transaction"
    redirect_to show_item_path(@item)
  end
rescue Stripe::CardError => e
  flash[:error] = e.message
  redirect_to show_item_path(@item)
  end

  # GET /items or /items.json
  def index
    @items = Item.all
  end

  # GET /items/1 or /items/1.json
  def show
    @transaction = Transaction.new
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
    @item.user = current_user

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

  def set_item
    @item = Item.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def item_params
    params.require(:item).permit(:title, :description, :price, :photo)
  end

  # Only allow a list of trusted parameters through.
  def transaction_params
    params.require(:transaction).permit(:street, :zip_code, :city)
  end

  def validate_form
    @street_value = params.dig(:transaction, :street).to_s.strip
    @zip_code_value = params.dig(:transaction, :zip_code).to_s.strip
    @city_value = params.dig(:transaction, :city).to_s.strip

    if @street_value.empty? || @zip_code_value.empty? || @city_value.empty?
      @error_message = "Veuillez remplir tous les champs"
      @disable_submit = true
    else
      @error_message = nil
      @disable_submit = false
    end
  end
end