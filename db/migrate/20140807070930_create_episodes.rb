class CreateEpisodes < ActiveRecord::Migration
  def change
    create_table :episodes do |t|
      t.string  :title
      t.text    :body
      t.integer :fiction_id

      t.timestamps
    end
    add_index :episodes, :fiction_id
  end
end
