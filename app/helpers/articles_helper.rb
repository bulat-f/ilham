module ArticlesHelper
  def link_to_source(article)
    link_to article.host, article.source if article.host
  end

  def article_footer(article)
    capture_haml do
      haml_tag :ul, class: 'media-footer' do
        haml_tag :li, article.category, class: 'category' unless article.category.nil?
        haml_tag :li, l(article.published_at, format: :long), class: 'date'
        haml_tag :li, link_to(article.host, article.source), class: 'source' unless article.source.blank?
        haml_tag :li, article.author, class: 'author'
      end
    end
  end
end
