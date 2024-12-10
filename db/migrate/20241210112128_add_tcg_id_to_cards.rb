class AddTcgIdToCards < ActiveRecord::Migration[7.1]
  def change
    add_column :cards, :tcg_id, :string
  end
end
