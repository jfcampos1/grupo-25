# frozen_string_literal: true

class ModeratorRequestsController < ApplicationController
  before_action :set_moderator_request, only: %i[show edit update destroy]

  # GET /moderator_requests
  # GET /moderator_requests.json
  def index
    @moderator_requests = ModeratorRequest.all
  end

  # GET /moderator_requests/1
  # GET /moderator_requests/1.json
  def show; end

  # GET /moderator_requests/new
  def new
    @moderator_request = ModeratorRequest.new
  end

  # GET /moderator_requests/1/edit
  def edit; end

  # POST /moderator_requests
  # POST /moderator_requests.json
  def create
    @tema = Tema.find(params[:tema_id])
    moderator_re = @tema.moderator_requests.build(user_id: current_user.id)
    if moderator_re.save
      answer2(current_user, @tema)
    else
      redirect_back(fallback_location: root_path, alert: 'Moderator request could not be sent.')
    end
  end

  # PATCH/PUT /moderator_requests/1
  # PATCH/PUT /moderator_requests/1.json
  def update
    respond_to do |format|
      if @moderator_request.update(moderator_request_params)
        format.html { redirect_to @moderator_request, notice: 'Moderator request was successfully updated.' }
        format.json { render :show, status: :ok, location: @moderator_request }
      else
        format.html { render :edit }
        format.json { render json: @moderator_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /moderator_requests/1
  # DELETE /moderator_requests/1.json
  def destroy
    request = ModeratorRequest.find(params[:id])
    tema = request.tema
    @moderator_request.destroy
    respond_to do |format|
      format.html { redirect_to tema_path(tema), notice: 'Moderator request was successfully cancelled.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_moderator_request
    @moderator_request = ModeratorRequest.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def moderator_request_params
    params.require(:moderator_request).permit(:user_id, :tema_id)
  end

  def answer2(user, tema)
    message = "Moderator_request send for #{user.name}."
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
