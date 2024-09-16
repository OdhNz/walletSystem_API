class User < ApplicationRecord
  has_one :wallet, as: :walletable, dependent: :destroy
  after_create :create_wallet
  has_secure_password

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true

  has_many :sessions
  
  private

  def create_wallet
    Wallet.create(walletable: self, balance: 0)
  end
end
