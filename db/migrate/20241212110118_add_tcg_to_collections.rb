class AddTcgToCollections < ActiveRecord::Migration[7.1]
  def change
    add_column :collections, :tcg, :string
  end
end
