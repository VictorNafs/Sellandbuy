class CategoriesController < ApplicationController
  before_action :set_category, only: %i[ show edit update destroy ]

  # GET /categories or /categories.json
  def index
    @categories = Category.all
  end

  # GET /categories/1 or /categories/1.json
  def show
    @category = Category.find(params[:id])
    if @category.items.empty?
      flash[:notice] = "Il n'y a pas encore d'objet dans cette catégorie."
      redirect_to items_path
    end
  end

  # GET /categories/new
  def new
    if current_user.admin?
      @category = Category.new
    else
      redirect_to items_path, alert: "Vous n'êtes pas autorisé à effectuer cette action."
    end
  end

  # GET /categories/1/edit
  def edit
  end

  # POST /categories or /categories.json
  def create
    if current_user.admin?
      @category = Category.new(category_params)
      if @category.save
        redirect_to category_path(@category), notice: "Category was successfully created."
      else
        render :new, status: :unprocessable_entity
      end
    else
      redirect_to items_path, alert: "Vous n'êtes pas autorisé à effectuer cette action."
    end
  end

  # PATCH/PUT /categories/1 or /categories/1.json
  def update
    if current_user.admin?
      @category = Category.find(params[:id])
      if @category.update(category_params)
        redirect_to category_path(@category), notice: "Category was successfully updated."
      else
        render :edit, status: :unprocessable_entity
      end
    else
      redirect_to items_path, alert: "Vous n'êtes pas autorisé à effectuer cette action."
    end
  end
  # DELETE /categories/1 or /categories/1.json
  def destroy
    if current_user.admin?
      @category = Category.find(params[:id])
      @category.destroy
      redirect_to categories_path, notice: "Category was successfully destroyed."
    else
      redirect_to items_path, alert: "Vous n'êtes pas autorisé à effectuer cette action."
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def category_params
      params.require(:category).permit(:name)
    end
end
