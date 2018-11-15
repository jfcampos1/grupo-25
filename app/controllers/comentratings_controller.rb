# frozen_string_literal: true

class ComentratingsController < ApplicationController
  before_action :set_comentrating, only: %i[show edit update destroy]

  # GET /comentratings
  # GET /comentratings.json
  def index
    @comentratings = Comentrating.all
  end

  # GET /comentratings/1
  # GET /comentratings/1.json
  def show; end

  # GET /comentratings/new
  def new
    @comentrating = Comentrating.new
  end

  # GET /comentratings/1/edit
  def edit; end

  # POST /comentratings
  # POST /comentratings.json
  def create
    @coment = Coment.find(params[:coment_id])
    return update if Comentrating.find_by(user_id: current_user.id, coment_id: params[:coment_id])
    vote_re = @coment.comentratings.build(user_id: current_user.id, star: params[:star])
    if vote_re.save
      answer3(current_user, @coment)
    else
      redirect_back(fallback_location: root_path, alert: 'Comentrating could not be sent.')
    end
  end

  # PATCH/PUT /comentratings/1
  # PATCH/PUT /comentratings/1.json
  def update
    rating = @coment.comentratings.find_by(user_id: current_user.id)
    respond_to do |format|
      if rating.update(star: params[:star])
        message = "You updated to  #{params[:star]} stars."
        format.html { redirect_back(fallback_location: coment_path(@coment), notice: message) }
        format.json { render :show, status: :ok, location: coment_path(coment) }
      else
        format.html { render :edit }
        format.json { render json: @coment.comentrating.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comentratings/1
  # DELETE /comentratings/1.json
  def destroy
    @comentrating.destroy
    respond_to do |format|
      format.html { redirect_to comentratings_url, notice: 'Comentrating was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_comentrating
    @comentrating = Comentrating.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def comentrating_params
    params.require(:comentrating).permit(:star)
  end

  def answer3(user, coment)
    message = "You give #{params[:star]} stars."
    respond_to do |format|
      format.html { redirect_back(fallback_location: coment_path(coment), notice: message) }
      format.json do
        render json: {
          friendship: {
            name: user.name,
            id: user.id
          },
          message: "New rating from #{user.name}!"
        }
      end
    end
  end
end
