class Api::RecipesController < ApplicationController
  def my_recipe
    @recipe = Recipe.second
    render 'show_recipe.json.jb'
  end
end
