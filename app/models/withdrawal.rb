class Withdrawal < Transaction
  validate :source_wallet_present

  private

  def source_wallet_present
    errors.add(:source_wallet, "must be present for withdrawals") if source_wallet.nil?
  end
end