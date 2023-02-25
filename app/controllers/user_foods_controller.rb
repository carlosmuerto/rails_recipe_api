class UserFoodsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  # GET /user_foods
  def index
    # @user_foods = UserFood.all

    render json: @user_foods.map { |item|
      UserFoodSerializer.new(item).serializable_hash[:data][:attributes]
    }, status: :ok
  end

  # POST /user_foods
  def create
    @user_food = UserFood.new(user_food_params)
    @user_food.user = current_user

    if @user_food.save
      render json: UserFoodSerializer.new(@user_food).serializable_hash[:data][:attributes], status: :created
    else
      render json: @user_food.errors, status: :unprocessable_entity
    end
  end

  # DELETE /user_foods/1
  def destroy
    @user_food.destroy
    render json: { message: 'user food deleted!' }, status: :no_content
  end

  private

  # Only allow a list of trusted parameters through.
  def user_food_params
    params.require(:user_food).permit(:quantity, :food_id)
  end
end
