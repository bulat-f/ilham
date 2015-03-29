class PaymentsController < ApplicationController

  before_action :authenticate_user!, only: [:index, :show, :new, :create, :edit, :update, :destroy]

  def index
  end

  def create
    fiction = Fiction.find_by_id payment_params[:fiction_id]
    if fiction
      sum = fiction.price
      @payment = current_user.payments.create(payment_params.merge(sum: sum))
      redirect_to "https://unitpay.ru/pay/9133-38f19?sum=#{ @payment.sum }&
                   account=#{ @payment.id }&
                   desc=Purchase+of+a+literary+work&hideDesc=true&"
    end
  end

  def confirm
    @payment = Payment.find_by_id(params[:params][:account])
    if @payment
      if @payment.update_attributes(payment_params)
        render success_message('Success')
      end

      confirm_purchase
    else
      render error_error('Payment not found')
    end
  end

  private

  def payment_params
    if params[:payment]
      params.require(:payment).permit(:fiction_id)
    else
      { operator:    params[:params][:operator],
        paymentType: params[:params][:paymentType],
        phone:       params[:params][:phone],
        sign:        params[:params][:sign],
        profit:      params[:params][:profit],
        unitpayId:   params[:params][:unitpayId],
        status:      params[:method] }
    end
  end

  def confirm_purchase
    if @payment.paid?
      gift = Gift.find_by(payment_id: @payment.id)
      if gift
        gift.pay!
      else
        user = User.find_by_id(@payment.user_id)
        user.buy!(@payment.fiction_id)
      end
    end
  end

  def error_message(msg)
    { json: { error: { code: -32000, message: msg } } }
  end

  def success_message(msg)
    { json: { result: { message: msg } } }
  end
end
