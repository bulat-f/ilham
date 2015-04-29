class PurchasesController < ApplicationController

  def create
    @purchase = current_user.purchases.build(purchase_params)
    if @purchase.save!
      redirect_to new_payment_path purchase_params
    else
      flash[:error] = I18n.t('.flash.error')
      render :new
    end
  end

  private
  def purchase_params
    params.require(:purchase).permit(:fiction_id)
  end
end
