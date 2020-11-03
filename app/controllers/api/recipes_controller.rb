class Api::RecipesController < ApplicationController

  before_action :authenticate_user, except: [:index, :show]

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
    response = Cloudinary::Uploader.upload(params[:image])

    @recipe = Recipe.new(
      title: params[:title],
      ingredients: params[:ingredients],
      directions: params[:directions],
      prep_time: params[:prep_time],
      image_url: response["secure_url"],
      user_id: current_user.id
    )
    if @recipe.save
      render "show.json.jb"
    else
      render json: { errors: @recipe.errors.full_messages}, status: 422
    end
  end

  def update
    @recipe = Recipe.find(params[:id])

    @recipe.title = params[:title] || @recipe.title
    @recipe.ingredients = params[:ingredients] || @recipe.ingredients
    @recipe.directions = params[:directions] || @recipe.directions
    @recipe.prep_time = params[:prep_time] || @recipe.prep_time
    @recipe.image_url = params[:image_url] || @recipe.image_url

    if @recipe.save
      render "show.json.jb"
    else
      render json: { errors: @recipe.errors.full_messages}, status: :unprocessable_entity
    end
  end

  def destroy
    recipe = Recipe.find(params[:id])
    recipe.destroy
    render json: {message: "Recipe successfully destroyed!"}
  end

end