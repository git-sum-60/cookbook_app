class RecipesController < ApplicationController
  def index
    @recipes = Recipe.all
    render 'index.html.erb'
  end

  def show
    @recipe = Recipe.find_by(id: params[:id])
    render 'show.html.erb'
  end

  def new
    @users = User.all
    render 'new.html.erb'
  end

  def create
    @recipe = Recipe.new(
      title: params[:title],
      ingredients: params[:ingredients],
      chef: params[:chef],
      directions: params[:directions],
      prep_time: params[:prep_time],
      image_url: params[:image_url],
      user_id: params[:user_id]
    )
    @recipe.save
    # render 'show.html.erb'
    redirect_to "/recipes/#{@recipe.id}"
  end

end
