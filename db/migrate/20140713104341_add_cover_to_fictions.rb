class AddCoverToFictions < ActiveRecord::Migration
  def change
    add_column :fictions, :cover, :string
  end
end
