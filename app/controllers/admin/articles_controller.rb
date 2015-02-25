class Admin::ArticlesController < Admin::AdminController

  before_action :find_article, only: [:show, :edit, :update, :destroy, :publish]

  def index
    @articles = Article.unpublished.paginate(page: params[:page])
  end

  def show
  end

  def new
    @article = Article.new
  end

  def create
    @article = current_user.articles.build(article_params)
    if @article.save
      flash[:success] = 'Article a created'
      @article.publish
      redirect_to @article
    else
      flash[:warning] = 'Article did not create'
      render 'new'
    end
  end

  def edit
  end

  def update
    if @article.update_attributes(article_params)
      flash[:success] = "Article's atributes are updated"
      redirect_to @article
    else
      flash.now[:warning] = "Article's atributes are not correct"
      render 'edit'
    end
  end

  def destroy
  end

  def publish
    @article.publish
    redirect_to articles_path
  end

  private

  def article_params
    params.require(:article).permit(:title, :description, :body, :picture, :author, :source, :category_id)
  end

  def find_article
    @article = Article.find_by_id(params[:id])
  end
end
