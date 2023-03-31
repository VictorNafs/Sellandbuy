class Home < ApplicationRecord
    def contact_email(name, email, message)
        HomeController.new.create_mail(name, email, message)
      end
end
