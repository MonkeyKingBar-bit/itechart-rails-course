# frozen_string_literal: true

class TransactionsController < ApplicationController
  before_action :set_transaction, only: %i[show edit update destroy]
  before_action :set_person_category, only: [:destroy]
  before_action :set_person_created_for, only: %i[create update]

  # GET /transactions or /transactions.json
  def index
    @transactions = Transaction.all
  end

  # GET /transactions/1 or /transactions/1.json
  def show; end

  # GET /transactions/new
  def new
    @people = current_user.people
    @transaction = Transaction.new
  end

  # GET /transactions/1/edit
  def edit; end

  # POST /transactions or /transactions.json
  def create
    @transaction = Transaction.new(transaction_params)
    create_note(@transaction, params.values[1][:body])
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

  # PATCH/PUT /transactions/1 or /transactions/1.json
  def update
    create_note(@transaction, params.values[2][:body]) unless @transaction.note
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

  # DELETE /transactions/1 or /transactions/1.json
  def destroy
    @transaction.destroy
    respond_to do |format|
      format.html do
        redirect_to person_path(@person), notice: 'Transaction was successfully destroyed.'
      end
      format.json { head :no_content }
    end
  end

  private

  # Create note
  def create_note(transaction, body)
    note = Note.new(body: body)
    if note.valid?
      transaction.note = note
    else
      flash[:alert] = 'Note was not saved, maybe it was invalid'
    end
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_transaction
    @transaction = Transaction.find(params[:id])
    return if current_user == @transaction.person_category.person.user
  end

  # Only allow a list of trusted parameters through.
  def transaction_params
    params.require(:transaction).permit(:count, :person_category_id)
  end

  def set_person_category
    @person = current_user.people.find(@transaction.person_category.person_id)
  end

  def set_person_created_for
    @person = Person.find(PersonCategory.find(transaction_params[:person_category_id]).person_id)
  end
end
