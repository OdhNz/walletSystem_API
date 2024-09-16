class TransactionsController < ApplicationController
  def create
    source_wallet = Wallet.find_by(id: transaction_params[:source_wallet_id]) if transaction_params[:source_wallet_id].present?
    target_wallet = Wallet.find_by(id: transaction_params[:target_wallet_id])

    if target_wallet.nil?
      render json: { error: 'Target wallet not found' }, status: :not_found and return
    end

    # Pastikan source_wallet ada jika ini adalah debit
    if transaction_params[:transaction_type] == 'debit' && source_wallet.nil?
      render json: { error: 'Source wallet not found for debit transaction' }, status: :not_found and return
    end

    # Buat transaksi
    transaction = Transaction.new(transaction_params)

    if transaction.save
      # Update balance jika transaksi berhasil
      target_wallet.update(balance: target_wallet.balance + transaction.amount) if transaction.transaction_type == 'credit'
      source_wallet.update(balance: source_wallet.balance - transaction.amount) if transaction.transaction_type == 'debit'
      
      render json: transaction, status: :created
    else
      render json: { error: transaction.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def transaction_params
    params.require(:transaction).permit(:source_wallet_id, :target_wallet_id, :amount, :transaction_type)
  end
end
