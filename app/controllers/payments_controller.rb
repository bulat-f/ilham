class PaymentsController < ApplicationController

  before_action :authenticate_user!, only: [:index, :show, :new, :create, :edit, :update, :destroy]

  def index
  end

  def create
    @payment = current_user.payments.create(sum: params[:sum])
    redirect_to "https://unitpay.ru/pay/6493-da044?sum=#{ @payment.sum }&account=#{ @payment.id }&desc=Оплата+тестового+заказа"
  end

  def confirm
    @payment = Payment.find_by_id(params[:params][:account])
    if @payment
      if @payment.update_attributes(operator:    params[:params][:operator],
                                    paymentType: params[:params][:paymentType],
                                    phone:       params[:params][:phone],
                                    sign:        params[:params][:sign],
                                    profit:      params[:params][:profit],
                                    unitpayId:   params[:params][:unitpayId],
                                   )
        success("Success")
      end

    else
      error("Payment not found")
    end
  end

  private

  def error(msg)
    render json: { error: { code: -32000, message: msg } }
  end

  def success(msg)
    render json: { result: { message: msg } }
  end
end
