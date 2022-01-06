# frozen_string_literal: true

class PeopleController < ApplicationController
  before_action :set_person, only: %i[show edit update destroy]
  before_action :authenticate_user!, except: %i[index show]
  before_action :correct_user, only: %i[edit update destroy]

  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found

  def render_not_found
    render 'public/404,html.erb'
  end

  # GET /people or /people.json
  def index
    @people = Person.all
  end

  # GET /people/1 or /people/1.json
  def show
    @categories = @person.categories
    @person_categories = @person.person_categories.where(created_at: Time.zone.today.all_month)
  end

  # GET /people/new
  def new
    @person = current_user.people.build
  end

  # GET /people/1/edit
  def edit; end

  # POST /people or /people.json
  def create
    @person = current_user.people.build(person_params)

    respond_to do |format|
      if @person.save
        format.html { redirect_to @person, notice: 'Person was successfully created.' }
        format.json { render :show, status: :created, location: @person }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /people/1 or /people/1.json
  def update
    respond_to do |format|
      if @person.update(person_params)
        format.html { redirect_to @person, notice: 'Person was successfully updated.' }
        format.json { render :show, status: :ok, location: @person }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /people/1 or /people/1.json
  def destroy
    @person.destroy
    respond_to do |format|
      format.html { redirect_to people_url }
      format.json { head :no_content }
    end
  end

  def correct_user
    @person = current_user.people.find_by(id: params[:id])
    redirect_to people_path, notice: 'Not Authorized To Edit This Person' if @person.nil?
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_person
    @person = Person.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def person_params
    params.fetch(:person, {})
    params.require(:person).permit(:first_name, :last_name, :description, :user_id)
  end
end
