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

  def contact_email(email, message, name)
    @name = name
    @email = email
    @message = message

    mail(to: 'sellandbuythp@gmail.com', subject: 'Nouveau message de contact')
  end

end
