class Admin::DashboardController < Admin::AdminController
  def index
    @published_articles_count = Article.published.count
    @unpublished_articles_count = Article.unpublished.count
    @users_count = User.count
  end
end
