class PostsController < ApplicationController

  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :admin_user,         only: [:new, :create, :edit, :update, :destroy]

  before_action :find_post,          only: [:show, :edit, :update, :destroy]

  def index
    @posts = Post.paginate(page: params[:page])
  end

  def show
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      flash[:success] = 'Post a created'
      redirect_to @post
    else
      flash[:warning] = 'Post did not create'
      render 'new'
    end
  end

  def edit
  end

  def update
    if @post.update_attributes(post_params)
      flash[:success] = "Post's atribute are updated"
      redirect_to @post
    else
      flash.now[:warning] = "post's atributes are not correct"
      render 'edit'
    end
  end

  def destroy
  end

  private

  def post_params
    params.require(:post).permit(:title, :description, :body, :cover)
  end

  def find_post
    @post = Post.find_by_id(params[:id])
  end
end
