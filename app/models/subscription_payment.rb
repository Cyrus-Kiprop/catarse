class SubscriptionPayment < ActiveRecord::Base
  self.table_name = 'common_schema.catalog_payments'
  belongs_to :subscription
  has_many :balance_transactions

  def already_in_balance?
    balance_transactions.where(event_name: %i[subscription_fee subscription_payment]).present?
  end
end
