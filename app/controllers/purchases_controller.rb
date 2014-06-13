class PurchasesController < ApplicationController

  def create
    @fiction = Fiction.find(params[:purchase][:fiction_id])
    current_user.buy!(@fiction)
    respond_to do |format|
      format.html { redirect_to @fiction }
      format.js
    end
  end
end
