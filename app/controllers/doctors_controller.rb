class DoctorsController < ApplicationController
	include Pundit
  before_action :set_doctor, only: [:show, :new_recipe, :create_recipe, :my_recipes]
  #https://www.kollegorna.se/en/2015/04/build-an-api-now/
  def my_recipes
    @recipes = @doctor.search(params[:term], params[:page])
    authorize @recipes
  end

  def show
  	authorize @doctor
  end

  private

  	def set_doctor
  		@doctor = Doctor.find(params[:id])
  	end
end
