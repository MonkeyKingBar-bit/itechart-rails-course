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
  def show
    @person = Person.find(PersonCategory.find(@transaction.person_category_id).id)
    @category = Category.find(PersonCategory.find(@transaction.person_category_id).category_id)
    @note = @transaction.note
  end

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
    create_note(@transaction, params)
    if @transaction.save
      flash[:notice] = 'Transaction was successfully created.'
      redirect_to person_path(@person)
    else
      render :new
    end
  end

  # PATCH/PUT /money_transactions/1 or /money_transactions/1.json
  def update
    # create_note(@transaction, params.values[2][:body]) unless @transaction.note
    if @transaction.update(transaction_params)
      flash[:notice] = 'Transaction was successfully updated.'
      redirect_to money_transaction_path(@transaction)
    else
      render :edit
    end
  end

  # DELETE /money_transactions/1 or /money_transactions/1.json
  def destroy
    @transaction.destroy
    respond_to do |format|
      format.html do
        redirect_to money_transactions_url, notice: 'Transaction was successfully destroyed.'
      end
      format.json { head :no_content }
    end
  end

  private

  # create note
  def create_note(transaction, params)
    return if params[:note_required].nil?

    note = Note.new(body: params[:note_body].values[0])
    if note.valid?
      transaction.note = note
    else
      flash[:alert] = 'Note was not saved, maybe it was invalid'
    end
  end

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
