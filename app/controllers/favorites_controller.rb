# frozen_string_literal: true

class FavoritesController < ApplicationController
  before_action :set_favorite, only: %i[show edit update destroy]

  # GET /favorites
  # GET /favorites.json
  def index
    @favorites = Favorite.all
  end

  # GET /favorites/1
  # GET /favorites/1.json
  def show; end

  # GET /favorites/new
  def new
    @favorite = Favorite.new
  end

  # GET /favorites/1/edit
  def edit; end

  # POST /favorites
  # POST /favorites.json
  def create
    @post = Post.find(params[:post_id])
    favorite_re = @post.favorites.build(user_id: current_user.id)
    if favorite_re.save
      answer3(current_user, @post)
    else
      redirect_back(fallback_location: root_path, alert: 'Favorite could not be sent.')
    end
  end

  # PATCH/PUT /favorites/1
  # PATCH/PUT /favorites/1.json
  def update
    respond_to do |format|
      if @favorite.update(favorite_params)
        format.html { redirect_to @favorite, notice: 'Favorite was successfully updated.' }
        format.json { render :show, status: :ok, location: @favorite }
      else
        format.html { render :edit }
        format.json { render json: @favorite.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /favorites/1
  # DELETE /favorites/1.json
  def destroy
    post = @favorite.post
    @favorite.destroy
    message = 'Favorite was successfully cancelled.'
    respond_to do |format|
      format.html { redirect_back(fallback_location: post_path(post), notice: message) }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_favorite
    @favorite = Favorite.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def favorite_params
    params.require(:favorite).permit(:user_id, :post_id)
  end

  def answer3(user, post)
    message = "Favorite send for #{post.title}."
    respond_to do |format|
      format.html { redirect_back(fallback_location: post_path(post), notice: message) }
      format.json do
        render json: {
          friendship: {
            name: user.name,
            id: user.id
          },
          message: "#{post.title} have a new subscription from #{user.name}!"
        }
      end
    end
  end
end
