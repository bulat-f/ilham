class CreateFictions < ActiveRecord::Migration
  def change
    create_table :fictions do |t|
      t.string  :title
      t.text    :body
      t.string  :genre

      t.integer :author_id

      t.timestamps
    end
  end
end
