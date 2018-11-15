# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :set_post, only: %i[show edit update destroy]

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all
    @posts = if params[:search]
               Post.search(params[:search])
             else
               Post.all
             end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @post = Post.find(params[:id])
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit; end

  # POST /posts
  # POST /posts.json
  # POST /coments
  # POST /coments.json

  def create
    @tema = Tema.find(params[:tema_id])
    @post = @tema.posts.create(post_params)
    @post.user_id = current_user.id
    @post.date = Time.zone.now
    message
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    @post = Post.find(params[:id])
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    tema = @post.tema
    @post.destroy
    respond_to do |format|
      format.html { redirect_to tema_path(tema), notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def post_params
    params.require(:post).permit(:title, :date, :section, :content)
  end

  def message
    respond_to do |format|
      if @post.save
        format.html { redirect_to tema_path(@post.tema), notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { redirect_to tema_path(@post.tema), notice: 'Post was not created, content is not long enough' }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end
end
