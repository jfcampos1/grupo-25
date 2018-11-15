# frozen_string_literal: true

class ModeratorsController < ApplicationController
  before_action :set_moderator, only: %i[show edit update destroy]

  # GET /moderators
  # GET /moderators.json
  def index
    @moderators = Moderator.all
  end

  # GET /moderators/1
  # GET /moderators/1.json
  def show; end

  # GET /moderators/new
  def new
    @moderator = Moderator.new
  end

  # GET /moderators/1/edit
  def edit; end

  # POST /moderators
  # POST /moderators.json
  def create
    user = User.find(params[:usu_id])
    tema = Tema.find(params[:tema_id])
    moderator = tema.moderators.build(user_id: user.id)
    if moderator.save
      request1 = ModeratorRequest.find_by(user_id: user.id, tema_id: tema.id)
      request1&.destroy
      answer(user, tema)
    else
      redirect_back(fallback_location: root_path, notice: 'There was an error creating the moderator')
    end
  end

  # PATCH/PUT /moderators/1
  # PATCH/PUT /moderators/1.json
  def update
    respond_to do |format|
      if @moderator.update(moderator_params)
        format.html { redirect_to @moderator, notice: 'Moderator was successfully updated.' }
        format.json { render :show, status: :ok, location: @moderator }
      else
        format.html { render :edit }
        format.json { render json: @moderator.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /moderators/1
  # DELETE /moderators/1.json
  def destroy
    request = Moderator.find(params[:id])
    tema = request.tema
    @moderator.destroy
    respond_to do |format|
      format.html { redirect_to tema_path(tema), notice: 'Moderator was successfully delete.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_moderator
    @moderator = Moderator.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def moderator_params
    params.require(:moderator).permit(:user_id, :tema_id, :usu_id)
  end

  def answer(user, tema)
    message = "New Moderator #{user.name}."
    respond_to do |format|
      format.html { redirect_back(fallback_location: tema_path(tema), notice: message) }
      format.json do
        render json: {
          friendship: {
            name: user.name,
            id: user.id
          },
          message: "#{tema.name} have a new moderator request #{user.name}!"
        }
      end
    end
  end
end
