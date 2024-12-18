class AddEstimatedPriceToCards < ActiveRecord::Migration[7.1]
  def change
    add_monetize :cards, :estimated_price, currency: { present: false }
    add_column :cards, :price_updated_at, :datetime
    add_index :cards, :price_updated_at
  end
end
