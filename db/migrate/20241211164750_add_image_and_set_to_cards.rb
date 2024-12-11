class AddImageAndSetToCards < ActiveRecord::Migration[7.1]
  def change
    add_column :cards, :image, :string
    add_column :cards, :set, :string
  end
end
