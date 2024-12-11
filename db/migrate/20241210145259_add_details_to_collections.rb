class AddDetailsToCollections < ActiveRecord::Migration[7.1]
  def change
    add_column :collections, :name, :string
    add_column :collections, :image_url, :string
    add_column :collections, :release_date, :date
    add_column :collections, :description, :text
  end
end
