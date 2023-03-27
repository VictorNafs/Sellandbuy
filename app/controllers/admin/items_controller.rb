
class Admin::ItemsController < ApplicationController
  before_action :set_item, only: %i[show edit update destroy]

 

  # GET /items/1 or /items/1.json
  def show
    @item = Item.find(params[:id])
  end

  # GET /items/new
  def new
    @item = Item.new
  end

  # GET /items/1/edit
  def edit
    @item = Item.find(params[:id])
  end


  # PATCH/PUT /items/1 
  def update
    @item = Item.find(params[:id])
  
    if @item.update(item_params)
      redirect_to @item, notice: 'L\'item a été mis à jour avec succès.'
    else
      flash[:error] = @item.errors.full_messages.to_sentence
      render :edit
    end
end
  # DELETE /items/1 or /items/1.json
  def destroy
    @item.destroy
    redirect_to items_path, notice: 'Article supprimé avec succès.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = Item.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def item_params

      params.require(:item).permit(:title, :description, :price, :photo)

    end
  end
