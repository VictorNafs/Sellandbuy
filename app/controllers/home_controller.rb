class HomeController < ApplicationController
    def index
        @items = Item.all 
     @categories = Category.all 
    end

    def contact
    end

    def about
    end

    def send_contact_email
        name = params[:name]
        email = params[:email]
        message = params[:message]

        UserMailer.contact_email(name, email, message).deliver_now
    
        redirect_to root_path, notice: "Votre message a été envoyé avec succès"
    end
end