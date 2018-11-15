# frozen_string_literal: true

class UsersController < ApplicationController
  helper_method :admin?
  helper_method :logged_in_user
  before_action :logged_in_user, only: %i[index edit update destroy
                                          following followers]
  before_action :correct_user,   only: %i[edit update destroy]

  def show
    @user = User.find(params[:id])
    @coments = Coment.all
  end

  def index
    @users = User.paginate(page: params[:page])
  end

  def ranking
    @users = User.paginate(page: params[:page])
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = 'User deleted'
    redirect_to users_url
  end

  def setup
    @user       = users(:michael)
    @other_user = users(:archer)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user[:role] = 'regular'
    if @user.save
      MailConfirmationMailer.new_user_email(@user).deliver_later
      flash[:success] = 'Please check your email inbox for a confirmation mail.'

      @user.email_confirmed = true
      @user.confirm_token = nil
      @user.save!(validate: false)
      redirect_to root_url
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = 'Profile updated'
      redirect_to @user
    else
      render 'edit'
    end
  end

  def following
    @title = 'Following'
    @user  = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = 'Followers'
    @user  = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

  def confirm_email
    user = User.find_by(confirm_token: params[:id])
    if user
      email_activate(user)
      flash[:success] = "Welcome to the Sample App! Your email has been confirmed.
      Please sign in to continue."
      redirect_to login_url
    else
      flash[:error] = 'Sorry. User does not exist'
      redirect_to root_url
    end
  end

  def email_activate(user)
    user.email_confirmed = true
    user.confirm_token = nil
    user.save!(validate: false)
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :avatar,
                                 :password_confirmation)
  end

  # Before filters
  # Confirms the correct user.
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user) || admin?
  end

  def admin?
    current_user.role == 'admin'
  end
end
