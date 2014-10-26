class FictionsController < ApplicationController

  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :admin_user,         only: [:new, :create, :edit, :update, :destroy]

  before_action :find_fiction,       only: [:show, :edit, :update, :destroy]

  def index
    unless params[:genre_id].blank?
      @fictions = Fiction.where('genre_id = ?', params[:genre_id])
    else
      @fictions = Fiction.all
    end
  end

  def show
  end

  def new
    @fiction = Fiction.new
  end

  def create
    @fiction = Fiction.new(fiction_params)
    if @fiction.save
      flash[:success] = 'Fiction save!!!'
      redirect_to @fiction
    else
      flash.now[:warning] = 'Error'
      render 'new'
    end
  end

  def edit
  end

  def update
    if @fiction.update_attributes(fiction_params)
      flash[:success] = "Fiction's atribute are updated"
      redirect_to @fiction
    else
      flash.now[:warning] = "Fiction's atributes are not correct"
      render 'edit'
    end
  end

  def destroy
    @fiction.destroy
    flash[:success] = "Fiction destroyed"
    redirect_to fictions_path
  end

  private

  def fiction_params
    params.require(:fiction).permit(:title, :body, :genre_id, :author_id, :price, :cover)
  end

  def find_fiction
    @fiction = Fiction.find(params[:id])
  end
end
