class AddFieldsToAchats < ActiveRecord::Migration[7.1]
  def change
    add_column :achats, :state, :string
    add_column :achats, :checkout_session_id, :string
    add_monetize :achats, :amount, currency: { present: false }
  end
end
