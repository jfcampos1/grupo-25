# frozen_string_literal: true

class SearchController < ApplicationController
  def index
    @foros = Foro.all
    @posts = Post.all
    @temas = Tema.all
    @coments = Coment.all
    if params[:search]
      @forosf = Foro.search(params[:search])
      @postsf = Post.search(params[:search])
      @temasf = Tema.search(params[:search])
      @comentsf = Coment.all
    else
      @foros = Foro.all
      @posts = Post.all
      @temas = Tema.all
      @coments = Coment.all
    end
  end
end
