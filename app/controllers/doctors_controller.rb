class DoctorsController < ApplicationController
  before_action :set_doctor, only: [:show, :new_recipe, :create_recipe]
  #https://www.kollegorna.se/en/2015/04/build-an-api-now/
  def show
  end

  def new_recipe
 	  @recipe = @doctor.recipes.new
 	  @recipe_detail = @recipe.recipe_details.new
  end

  def create_recipe
    respond_to do |format|
      if @doctor.update_attributes(recipe_params)
        format.html { redirect_to(doctor_session_url, :notice => 'Recipe was successfully generated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "new_recipe" }
        format.xml  { render :xml => @recipe.errors, :status => :unprocessable_entity }
      end
    end
  end

  private

	def recipe_params
	   params.require(:doctor).permit(:id, recipes_attributes: [:document_type, :document, :full_name, :cell_phone, 
      :local_phone, :email, recipe_details_attributes: [:id, :medicine_name, :quantity, :indications, :_destroy]])
	end

  	def set_doctor
  		@doctor = Doctor.find(params[:id])
  	end
end
