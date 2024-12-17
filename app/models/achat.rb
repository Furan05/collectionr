class Achat < ApplicationRecord
  belongs_to :user
  belongs_to :offer

  monetize :amount_cents

  before_create :set_purchase_date

  private

  def set_purchase_date
    self.purchase_date = Time.current
  end
end
