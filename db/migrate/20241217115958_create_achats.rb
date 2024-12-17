class CreateAchats < ActiveRecord::Migration[7.1]
  def change
    create_table :achats do |t|
      t.references :user, null: false, foreign_key: true
      t.references :offer, null: false, foreign_key: true
      t.datetime :purchase_date

      t.timestamps
    end
  end
end
