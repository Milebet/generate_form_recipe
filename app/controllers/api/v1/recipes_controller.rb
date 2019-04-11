class Api::V1::RecipesController < Api::V1::BaseController
	before_action :load_resource
  before_action :authenticate_doctor

  def show
    render plain: (Api::V1::RecipeSerializer.new(@recipe)).to_json
  end

  def create
  end


  def destroy
  end

  private
    def load_resource
      @doctor = Doctor.find(params[:doctor_id])
      @recipe = Recipe.find(params[:id])
    end
end