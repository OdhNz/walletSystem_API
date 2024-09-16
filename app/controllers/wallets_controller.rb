class WalletsController < ApplicationController
  def create
    # Membuat wallet baru berdasarkan parameter yang dikirimkan
    wallet = Wallet.new(wallet_params)

    if wallet.save
      render json: wallet, status: :created
    else
      render json: { error: wallet.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def show
    wallet = Wallet.find(params[:id])
    render json: { balance: wallet.balance }
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Wallet not found' }, status: :not_found
  end

  private

  # Strong parameters untuk wallet
  def wallet_params
    params.require(:wallet).permit(:walletable_type, :walletable_id, :balance)
  end
end
