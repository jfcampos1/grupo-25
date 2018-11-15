# frozen_string_literal: true

class ComentsController < ApplicationController
  before_action :set_coment, only: %i[show edit update destroy]

  # GET /coments
  # GET /coments.json
  def index
    @coments = Coment.all
  end

  # GET /coments/1
  # GET /coments/1.json
  def show; end

  # GET /coments/new
  def new
    @coment = Coment.new
  end

  # GET /coments/1/edit
  def edit; end

  # POST /coments
  # POST /coments.json
  def create
    @post = Post.find(params[:post_id])
    @coment = @post.coments.create(coment_params)
    @coment.user_id = current_user.id
    @coment.date = Time.zone.now
    redirect_to post_path(@coment.post) if @coment.save
  end

  # PATCH/PUT /coments/1
  # PATCH/PUT /coments/1.json
  def update
    respond_to do |format|
      if @coment.update(coment_params)
        format.html { redirect_to post_path(@coment.post), notice: 'Coment was successfully updated.' }
        format.json { render :show, status: :ok, location: @coment }
      else
        format.html { render :edit }
        format.json { render json: @coment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /coments/1
  # DELETE /coments/1.json
  def destroy
    post = @coment.post
    @coment.destroy
    respond_to do |format|
      format.html { redirect_to post_path(post), notice: 'Coment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_coment
    @coment = Coment.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def coment_params
    params.require(:coment).permit(:date, :content)
  end
end
