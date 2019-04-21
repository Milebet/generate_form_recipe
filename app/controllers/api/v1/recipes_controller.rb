class Api::V1::RecipesController < Api::V1::BaseController
	before_action :load_resource
  before_action :authenticate_recipe!

  def show
    @recipe = Recipe.find(params[:id])
    render json: (Api::V1::RecipeSerializer.new(@recipe))
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.doctor = @doctor
    if @recipe.save(recipe_params)
      RecipeMailer.new_recipe(@recipe).deliver_now
      render json: (Api::V1::RecipeSerializer.new(@recipe))
    else
      invalid_resource!(@recipe.errors)
    end
  end

  def recipes_doctor
    @recipes = @doctor.recipes
    render json: (@recipes.all.each{|recipe| Api::V1::RecipeSerializer.new(recipe) })
  end

  private
    def load_resource
      @doctor = Doctor.find(params[:doctor_id])
    end

    def recipe_params
     params.require(:recipe).permit(:id, :full_name, :email, :cell_phone, :local_phone, :document_type, :document, :doctor_id, :observation, 
      recipe_details_attributes: [:id, :medicine_name, :quantity, :indications, :_destroy])
   end
end