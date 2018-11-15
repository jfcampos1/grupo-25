# frozen_string_literal: true

class PostratingsController < ApplicationController
  before_action :set_postrating, only: %i[show edit update destroy]

  # GET /postratings
  # GET /postratings.json
  def index
    @postratings = Postrating.all
  end

  # GET /postratings/1
  # GET /postratings/1.json
  def show; end

  # GET /postratings/new
  def new
    @postrating = Postrating.new
  end

  # GET /postratings/1/edit
  def edit; end

  # POST /postratings
  # POST /postratings.json
  def create
    @post = Post.find(params[:post_id])
    return update if Postrating.find_by(user_id: current_user.id, post_id: params[:post_id])
    vote_re = @post.postratings.build(user_id: current_user.id, star: params[:star])
    if vote_re.save
      answer3(current_user, @post)
    else
      redirect_back(fallback_location: root_path, alert: 'Postrating could not be sent.')
    end
  end

  # PATCH/PUT /postratings/1
  # PATCH/PUT /postratings/1.json
  def update
    rating = @post.postratings.find_by(user_id: current_user.id)
    respond_to do |format|
      if rating.update(star: params[:star])
        message = "You updated #{params[:star]} stars to #{@post.title}."
        format.html { redirect_back(fallback_location: post_path(@post), notice: message) }
        format.json { render :show, status: :ok, location: post_path(post) }
      else
        format.html { render :edit }
        format.json { render json: @post.postrating.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /postratings/1
  # DELETE /postratings/1.json
  def destroy
    @postrating.destroy
    respond_to do |format|
      format.html { redirect_to postratings_url, notice: 'Postrating was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_postrating
    @postrating = Postrating.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def postrating_params
    params.require(:postrating).permit(:star)
  end

  def answer3(user, post)
    message = "You give #{params[:star]} stars to #{post.title}."
    respond_to do |format|
      format.html { redirect_back(fallback_location: post_path(post), notice: message) }
      format.json do
        render json: {
          friendship: {
            name: user.name,
            id: user.id
          },
          message: "#{post.title} have a new rating from #{user.name}!"
        }
      end
    end
  end
end
