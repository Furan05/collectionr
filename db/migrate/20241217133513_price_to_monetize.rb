class PriceToMonetize < ActiveRecord::Migration[7.1]
  def change
    remove_column :offers, :price, :decimal
    add_monetize :offers, :price, currency: { present: false }
  end
end
