class Transaction < ApplicationRecord
 belongs_to :source_wallet, class_name: 'Wallet', optional: true
  belongs_to :target_wallet, class_name: 'Wallet', optional: true

  validates :amount, numericality: { greater_than: 0 }
  validate :valid_wallets

  after_create :update_wallets

  private

  def valid_wallets
    if source_wallet.nil? && target_wallet.nil?
      errors.add(:base, "Source or target wallet must be present")
    end
  end

  def update_wallets
    source_wallet.update(balance: source_wallet.balance - amount) if source_wallet
    target_wallet.update(balance: target_wallet.balance + amount) if target_wallet
  end
end
