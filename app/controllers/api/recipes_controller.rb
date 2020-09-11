class Api::RecipesController < ApplicationController

  def index
    @recipes = Recipe.all
    render "index.json.jb"
  end

  def show
    # @recipe = Recipe.find_by(id: params[:id])
    @recipe = Recipe.find(params[:id])
    render "show.json.jb"
  end

  def create
    @recipe = Recipe.new(
      title: params[:title],
      ingredients: params[:ingredients],
      directions: params[:directions],
      prep_time: params[:prep_time],
      chef: params[:chef]
    )
    @recipe.save
    render "show.json.jb"
  end

  def update
    @recipe = Recipe.find(params[:id])

    @recipe.title = params[:title]
    @recipe.ingredients = params[:ingredients]
    @recipe.directions = params[:directions]
    @recipe.prep_time = params[:prep_time]
    @recipe.chef = params[:chef]

    @recipe.save
    render "show.json.jb"
  end

end