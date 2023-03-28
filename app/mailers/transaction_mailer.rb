class TransactionMailer < ApplicationMailer
    default from: 'sellandbuythp@gmail.com'
    
    def confirmation_email
        mail(to: @transaction.user.email, subject: 'Confirmation de commande')
      end
end
