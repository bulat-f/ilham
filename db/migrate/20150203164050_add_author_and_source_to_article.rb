class AddAuthorAndSourceToArticle < ActiveRecord::Migration
  def change
    add_column :articles, :author, :string, default: nil
    add_column :articles, :source, :string, default: nil
  end
end
