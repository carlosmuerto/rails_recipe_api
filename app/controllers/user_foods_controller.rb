class UserFoodsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user_food, only: %i[show destroy]

  # GET /user_foods
  def index
    @user_foods = UserFood.all

    render json: @user_foods
  end

  # POST /user_foods
  def create
    @user_food = UserFood.new(user_food_params)
    @user_food.user = current_user

    if @user_food.save
      render json: @user_food, status: :created, location: @user_food
    else
      render json: @user_food.errors, status: :unprocessable_entity
    end
  end

  # DELETE /user_foods/1
  def destroy
    @user_food.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user_food
    @user_food = UserFood.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def user_food_params
    params.require(:user_food).permit(:quantity, :food_id)
  end
end
