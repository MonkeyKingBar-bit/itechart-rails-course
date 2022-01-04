# frozen_string_literal: true

class MoneyTransactionsController < ApplicationController
  before_action :set_transaction, only: %i[show edit update destroy]
  before_action :set_person_category, only: [:destroy]
  before_action :set_person_created_for, only: %i[create update]

  # GET /money_transactions or /money_transactions.json
  def index
    @transactions = MoneyTransaction.all
  end

  # GET /money_transactions/1 or /money_transactions/1.json
  def show; end

  # GET /money_transactions/new
  def new
    @people = current_user.people
    @transaction = MoneyTransaction.new
  end

  # GET /money_transactions/1/edit
  def edit; end

  # POST /money_transactions or /money_transactions.json
  def create
    @transaction = MoneyTransaction.new(transaction_params)

    respond_to do |format|
      if @transaction.save
        format.html { redirect_to @transaction, notice: 'Transaction was successfully created.' }
        format.json { render :show, status: :created, location: @transaction }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /money_transactions/1 or /money_transactions/1.json
  def update
    respond_to do |format|
      if @transaction.update(transaction_params)
        format.html { redirect_to @transaction, notice: 'Transaction was successfully updated.' }
        format.json { render :show, status: :ok, location: @transaction }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /money_transactions/1 or /money_transactions/1.json
  def destroy
    @transaction.destroy
    respond_to do |format|
      format.html do
        redirect_to transactions_url, notice: 'Transaction was successfully destroyed.'
      end
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_transaction
    @transaction = MoneyTransaction.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def transaction_params
    params.require(:money_transaction).permit(:count, :person_category_id)
  end

  def set_person_category
    @person = current_user.people.find(@transaction.person_category.person_id)
  end

  def set_person_created_for
    @person = Person.find(PersonCategory.find(transaction_params[:person_category_id]).person_id)
  end
end
