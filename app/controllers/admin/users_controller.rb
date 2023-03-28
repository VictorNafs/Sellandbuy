
class Admin::UsersController < ApplicationController
  before_action :set_user, only: [:index, :show, :edit, :update]

  def index
   
  end

  def show
  
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
  if @user != current_user # Vérifie si l'utilisateur à supprimer n'est pas l'utilisateur actuel
    @user.destroy
    redirect_to admin_users_path, notice: 'User was successfully destroyed.'
  else
    redirect_to admin_users_path, alert: 'You cannot delete yourself.'
  end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end
end
