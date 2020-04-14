class Api::RecipesController < ApplicationController
  def index

    p "THIS IS RIGHT BEFORE CURRENT USER"
    p current_user
    p "THIS IS RIGHT AFTER CURRENT USER"
    
    # if params[:search]
    #   @recipes = Recipe.where("ingredients LIKE ?", "%#{params[:search]}%")
    # else
      # @recipes = Recipe.all
    # end

    # if current_user
    @recipes = Recipe.all
    # else
    #   @recipes = []
    # end
    render 'index.json.jb'
  end

  def show
    the_id = params[:id]
    @recipe = Recipe.find_by(id: the_id)
    render 'show.html.erb'
  end

  def create
    # make a new Recipe
    @recipe = Recipe.new(
      chef: params[:input_chef],
      ingredients: params[:input_ingredients], 
      directions: params[:input_directions], 
      prep_time: params[:input_prep_time], 
      image_url: params[:input_image_url], 
      title: params[:input_title],
      user_id: current_user.id
    )
    @recipe.save
    p "*" * 88
    p @recipe.errors.full_messages
    p "*" * 88

    render 'show.json.jb'
  end

  def update
    # find the correct recipe (show)
    the_id = params[:id]
    @recipe = Recipe.find_by(id: the_id)
    # update the recipe (create)

    @recipe.title = params[:title] || @recipe.title
    @recipe.chef = params[:chef] || @recipe.chef
    @recipe.ingredients = params[:ingredients] || @recipe.ingredients
    @recipe.prep_time = params[:prep_time] || @recipe.prep_time
    @recipe.directions = params[:directions] || @recipe.directions

    @recipe.save

    render 'show.json.jb'
  end

  def destroy
    # find the recipe
    @recipe = Recipe.find_by(id: params[:id])
    # destroy the recipe
    @recipe.destroy
    render 'destroy.json.jb'
  end
end
