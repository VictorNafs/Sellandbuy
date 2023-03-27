module Admin
class UsersController < ApplicationController
  before_action :set_user, only: [:index, :show, :edit, :update, :destroy]

  def index
  end

  def show
    User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    if @user.update(user_params)
      redirect_to admin_user_path(@user), notice: 'Utilisateur mis à jour avec succès.'
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to admin_users_path, notice: 'Utilisateur supprimé avec succès.'
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end
end
end