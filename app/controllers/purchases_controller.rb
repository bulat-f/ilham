class PurchasesController < ApplicationController
  def create
    @purchase = Purchase.find_by(purchase_params.merge(reader_id: current_user.id)) || current_user.purchases.build(purchase_params)
    if @purchase.save!
      redirect_to new_payment_path(payment: { payable_id: @purchase.id, payable_type: 'Purchase' })
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
