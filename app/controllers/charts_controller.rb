# frozen_string_literal: true

class ChartsController < ApplicationController
  before_action :set_user_people, only: %i[index]

  # GET /charts or /charts.json
  def index
    if params_date_validator(params)
      @start_date = Time.zone.today.beginning_of_month
      @end_date = date_to_datetime(Time.zone.today)
    else
      @start_date = Date.parse(params[:money_transaction][:start_date])
      @end_date = date_to_datetime(Date.parse(params[:money_transaction][:end_date]))
    end
    @categories = current_user.people.collect(&:categories).flatten.uniq
    @chart_debit_data = get_debit_transactions(@categories, @start_date, @end_date)
    @chart_credit_data = get_credit_transactions(@categories, @start_date, @end_date)
  end

  # PATCH/PUT /charts/1 or /charts/1.json
  def update
    respond_to do |format|
      if @chart.update(chart_params)
        format.html { redirect_to @chart, notice: 'Chart was successfully updated.' }
        format.json { render :show, status: :ok, location: @chart }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @chart.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /charts/1 or /charts/1.json
  def destroy
    @chart.destroy
    respond_to do |format|
      format.html { redirect_to charts_url, notice: 'Chart was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def get_debit_transactions(categories, start_d, end_d)
    debit_transactions = []
    categories.select(&:transaction_type).each do |category|
      debit_transactions += [[category.title, MoneyTransaction.where(person_category_id: category.person_categories,
                                                                     created_at: start_d..end_d)
                                                              .sum(:count)]]
    end
    debit_transactions
  end

  def get_credit_transactions(categories, start_d, end_d)
    credit_transactions = []
    categories.reject(&:transaction_type).each do |category|
      credit_transactions += [
        [category.title, MoneyTransaction.where(person_category_id: category.person_categories,
                                                created_at: start_d..end_d)
                                         .sum(:count)]
      ]
    end
    credit_transactions
  end

  def params_date_validator(params)
    params[:money_transaction].nil? ||
      params[:money_transaction][:start_date].nil? ||
      params[:money_transaction][:end_date].nil? ||
      !date?(params[:money_transaction][:start_date]) ||
      !date?(params[:money_transaction][:end_date])
  end

  def date_to_datetime(date)
    date.to_datetime.end_of_day
  end

  def set_user_people
    @people = current_user.people
  end

  def date?(date)
    date =~ /\d{4}-\d{2}-\d{2}/
  end
end
