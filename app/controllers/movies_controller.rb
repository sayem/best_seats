class MoviesController < ApplicationController

  def index
    @movies = Movie.all
  end

  def new
    @movie = Movie.new
  end

  def create
    
  end

  def edit
    
  end

  def destroy
    
  end
end
