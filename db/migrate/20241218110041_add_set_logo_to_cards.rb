class AddSetLogoToCards < ActiveRecord::Migration[7.1]
  def change
    add_column :cards, :set_logo, :string
  end
end
