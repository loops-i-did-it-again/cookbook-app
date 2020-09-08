class Api::RecipesController < ApplicationController

  def single_recipe_action
    @recipe = Recipe.first
    render "single_recipe.json.jb"
  end

end