
class Admin::DashboardController < ApplicationController

        def index
            @users = User.where.not(id: current_user.id).where.not(admin: true)
            @items = Item.all
        end

end     