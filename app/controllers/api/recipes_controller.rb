class Api::RecipesController < ApplicationController

  def index
    @recipes = Recipe.all

    if params[:search]
      @recipes = @recipes.where("title iLIKE ?", "%#{params[:search]}%")
    end

    @recipes.order(:id)

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
    if @recipe.save
      render "show.json.jb"
    else
      render json: { errors: @recipe.errors.full_messages}, status: :unprocessable_entity
    end
  end

  def update
    @recipe = Recipe.find(params[:id])

    @recipe.title = params[:title] || @recipe.title
    @recipe.ingredients = params[:ingredients] || @recipe.ingredients
    @recipe.directions = params[:directions] || @recipe.directions
    @recipe.prep_time = params[:prep_time] || @recipe.prep_time
    @recipe.chef = params[:chef] || @recipe.chef

    if @recipe.save
      render "show.json.jb"
    else
      render json: { errors: @recipe.errors.full_messages}, status: :unprocessable_entity
    end
    render "show.json.jb"
  end

  def destroy
    recipe = Recipe.find(params[:id])
    recipe.destroy
    render json: {message: "Recipe successfully destroyed!"}
  end

end