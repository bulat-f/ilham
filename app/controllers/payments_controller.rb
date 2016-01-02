class PaymentsController < ApplicationController
  before_action :authenticate_user!, only: [:index, :show, :new, :create, :edit, :update, :destroy]

  def index
  end

  def new
    @payment = Payment.new(payment_params)
    respond_to do |format|
      format.html
    end
  end

  def create
    @payment = Payment.new(payment_params)
    payable = @payment.payable
    if payable && payable.pay_available_for?(current_user) && @payment.save!
      @payment.update_attribute(:sum, payable.price)
      redirect_to "https://unitpay.ru/pay/9133-38f19?sum=#{@payment.sum}&
                   account=#{@payment.id}&
                   desc=Purchase+of+a+literary+work&hideDesc=true&"
    else
      redirect_to root_path
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
      params.require(:payment).permit(:payable_id, :payable_type)
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
    @payment.payable.pay! if @payment.paid?
  end

  def error_message(msg)
    { json: { error: { code: -32_000, message: msg } } }
  end

  def success_message(msg)
    { json: { result: { message: msg } } }
  end
end
