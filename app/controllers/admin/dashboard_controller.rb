module Admin

    class DashboardController < ApplicationController

        def index
            @users = User.all
            @items = Item.all
        end

    end     
    
    
end