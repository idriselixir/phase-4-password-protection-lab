class UsersController < ApplicationController
    def create
      user = User.new(user_params)
      if user.save
        session[:user_id] = user.id
        render json: user
      else
        render json: { error: user.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    def show
      if authenticated?
        user = User.find(session[:user_id])
        render json: user
      else
        render json: { error: 'Unauthorized' }, status: :unauthorized
      end
    end
  
    private
  
    def user_params
      params.permit(:username, :password)
    end
  
    def authenticated?
      session[:user_id].present?
    end
  end
  