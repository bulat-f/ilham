module ArticlesHelper
  def link_to_source(article)
    link_to article.host, article.source if article.host
  end
end
