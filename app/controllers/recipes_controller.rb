class RecipesController < ApplicationController
  before_action :set_recipe, only: [:show]
  after_action :verify_authorized

  def new
  	@recipe = Recipe.new
  	@recipe_details = @recipe.recipe_details.build
    authorize @recipe
  end

  def create
  	@recipe = Recipe.new(recipe_params)
    @recipe.doctor = current_doctor
    authorize @recipe
  	respond_to do |format|
      if @recipe.save(recipe_params)
        RecipeMailer.new_recipe(@recipe).deliver_now
        format.html { redirect_to(recipe_url(@recipe), :notice => 'Recipe was successfully generated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @recipe.errors, :status => :unprocessable_entity }
      end
    end
  end

  def show
  end

  private
   def recipe_params
     params.require(:recipe).permit(:id, :full_name, :email, :cell_phone, :local_phone, :document_type, :document, :doctor_id, :observation, 
      recipe_details_attributes: [:id, :medicine_name, :quantity, :indications, :_destroy])
   end

   def set_recipe
   	@recipe = Recipe.find(params[:id])
    authorize @recipe
   end
end
