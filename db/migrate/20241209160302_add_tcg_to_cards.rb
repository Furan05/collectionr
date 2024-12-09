class AddTcgToCards < ActiveRecord::Migration[7.1]
  def change
    add_column :cards, :tcg, :string
  end
end
