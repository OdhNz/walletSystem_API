class Deposit < Transaction
  validate :target_wallet_present

  private

  def target_wallet_present
    errors.add(:target_wallet, "must be present for deposits") if target_wallet.nil?
  end
end