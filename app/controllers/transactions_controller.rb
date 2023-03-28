class TransactionsController < ApplicationController
  before_action :set_item, only: [:new, :create]
  require 'user_mailer'


  def new
    @transaction = Transaction.new
  end

  def stripe_checkout
    payload = request.body.read
    sig_header = request.env['HTTP_STRIPE_SIGNATURE']
    event = nil

    begin
      event = Stripe::Webhook.construct_event(
        payload, sig_header, ENV['STRIPE_WEBHOOK_SECRET']
      )
    rescue JSON::ParserError => e
      # Invalid payload
      render json: { error: e.message }, status: :bad_request
      return
    rescue Stripe::SignatureVerificationError => e
      # Invalid signature
      render json: { error: e.message }, status: :bad_request
      return
    end

    case event.type
    when 'charge.succeeded'
      transaction = Transaction.find_by(item_id: event.data.object.metadata.item_id, user_id: event.data.object.metadata.user_id)
      transaction.update(paid: true)
    end

    render json: { message: 'success' }
  end

  def create
    @transaction = Transaction.new(transaction_params)
    @transaction.user = current_user
    @transaction.item = @item
  
    if @transaction.save
      UserMailer.checkout_email(@transaction).deliver_now # envoi de l'email de confirmation
      redirect_to checkout_item_path(@transaction.item), notice: 'Transaction was successfully created.'
    else
      redirect_to root_path
    end
  end

  private

  def set_item
    @item = Item.find(params[:item_id])
  end

  def transaction_params
    params.require(:transaction).permit(:item_id, :user_id, :street, :zip_code, :city)
  end
end
