class UserMailer < ApplicationMailer
  default from: 'sellandbuythp@gmail.com'

  def welcome_email(user)
    @user = user
    @url  = 'http://monsite.fr/login'
    mail(to: @user.email, subject: 'Bienvenue chez nous !')
  end

  def checkout_email(transaction)
    @transaction = transaction
    mail(to: @transaction.user.email, subject: 'Confirmation de votre achat')
  end
end
