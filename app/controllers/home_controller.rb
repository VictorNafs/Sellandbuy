class HomeController < ApplicationController
    def index
        @items = Item.all 
     @categories = Category.all 
    end
    
    
    def apropos 
    end


end