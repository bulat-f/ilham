class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string  :title,       null: false
      t.string  :description

      t.string  :picture

      t.text    :body,        null: false

      t.integer :user_id,     null: false
      t.integer :category_id

      t.boolean :published,   null: false, default: false

      t.timestamps null: false
    end

    add_index :articles, :user_id
  end
end
