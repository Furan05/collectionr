class AddImageUrlAndReleaseDateToCollections < ActiveRecord::Migration[7.1]
  def change
    add_column :collections, :image_url, :string
    add_column :collections, :release_date, :date
  end
end
