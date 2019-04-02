class RecipesController < ApplicationController
  before_action :set_recipe, only: [:show]
  def new
  	@recipe = Recipe.new
  	@recipe_details = @recipe.recipe_details.build
  end

  def create
  	@recipe = Recipe.new(strong_params)
  	respond_to do |format|
      if @recipe.save(strong_params)
        format.html { redirect_to(recipes_show_url, :notice => 'Recipe was successfully generated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "new_recipe" }
        format.xml  { render :xml => @recipe.errors, :status => :unprocessable_entity }
      end
    end
  end

  def show
  end

  private

   def set_recipe
   	@recipe = Recipe.find(param[:id])
   end
end
