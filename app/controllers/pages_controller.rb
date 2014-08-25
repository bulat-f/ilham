class PagesController < ApplicationController
  def index
    render layout: "index" unless user_signed_in?
  end

  def about
  end

  def for_readers
  end

  def for_writers
  end

  def help
  end

  def unitpay
  end
end
