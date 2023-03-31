class HomeController < ApplicationController
    def index
        @items = Item.all 
     @categories = Category.all 
    end
<<<<<<< HEAD
    
    
    def apropos 
    end


=======

    def contact
    end
>>>>>>> 61352d41fd8da605e7b300ddff2c6d6f6d72dabd
end