# frozen_string_literal: true

class StaticPagesController < ApplicationController
  def home
    @foros = Foro.all
  end

  def help; end
end
