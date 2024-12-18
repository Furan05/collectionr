class AddEtatToOffer < ActiveRecord::Migration[7.1]
  def change
    add_column :offers, :etat, :boolean, default: true
  end
end
