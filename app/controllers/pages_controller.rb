class PagesController < ApplicationController
  def index
    unless user_signed_in?
      render layout: "index"
    else
      @fictions = current_user.fictions.take(3)
      @posts = Post.order(:created_at => :desc).first(3)
    end
  end

  def about
  end

  def for_readers
  end

  def for_writers
  end

  def help
  end

  def about_rus
  end
end
