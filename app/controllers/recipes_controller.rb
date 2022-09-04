class RecipesController < ApplicationController
  before_action :authorize

  def index
    recipes = Recipe.all
    render json: recipes, include: :user
  end

  def create
    current_user = User.find(session[:user_id])
    recipe = current_user.recipes.create!(recipe_params)
    render json: recipe, include: :user, status: :created
  end

  private

  def recipe_params
    params.permit(:id, :title, :instructions, :minutes_to_complete)
  end
end
