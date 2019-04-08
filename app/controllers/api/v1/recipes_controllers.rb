class Api::V1::RecipeController < Api::V1::BaseController
	before_action :load_resource
  before_action :authenticate_doctor

  def index
    @recipes = @doctor.recipes

    render plain: ({recipes: @recipes
      }).to_json
  end

  def show
    auth_doctor = @doctor

    render plain: ({ doctor: @doctor, serializer: Api::V1::DoctorSerializer}).to_json
  end

  def create
  end


  def destroy
  end

  private
    def load_resource
      @doctor = Doctor.find(params[:doctor_id])
    end
end