class HomeController < ApplicationController
    def index
        @items = Item.all 
     @categories = Category.all 
    end

    def contact
    end

    def about
    end
end