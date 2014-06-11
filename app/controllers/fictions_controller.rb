class FictionsController < ApplicationController

  before_action :admin_user, only: [:new, :create, :edit, :update, :destroy]

  def index
    @fictions = Fiction.all
  end

  def new
    @fiction = Fiction.new
  end

  def create
    @fiction = current_user.written_fictions.build(fiction_params)
    if @fiction.save
      flash[:success] = 'Fiction save!!!'
      redirect_to @fiction
    else
      flash.now[:warning] = 'Error'
      render 'new'
    end
  end

  def edit
    @fiction = Fiction.find(params[:id])
  end

  def update
    @fiction = Fiction.find(params[:id])
    if @fiction.update_attributes(fiction_params)
      flash[:success] = "Fiction's atribute are updated"
      redirect_to @fiction
    else
      flash.now[:warning] = "Fiction's atributes are not correct"
      render 'edit'
    end
  end

  def destroy

  end

  private

  def fiction_params
    params.require(:fiction).permit(:title, :body, :genre_id, :author_id)
  end
end
