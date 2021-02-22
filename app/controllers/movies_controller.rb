class MoviesController < ApplicationController
  before_action :set_movie, only: [:show, :edit, :update, :destroy]
  
  def index
    @movies = Movie.all
  end

  def show
  end
  
  def new
    @movie = Movie.new
  end

  def edit
  end

  def create
    @movie = Movie.new(movie_params)

    if @movie.save
      flash[:notice] = 'Movie was successfully created.'
      redirect_to @movie
    else
      flash[:notice] = 'There was a problem creating the movie.'
      render :new
    end
  end

  def update
    if @movie.update(movie_params)
      flash[:notice] = 'Movie was successfully updated.'
      redirect_to @movie
    else
      flash[:notice] = 'There was a problem updating the movie.'
      render :edit
    end
  end
  
  def destroy
    @movie.destroy
    
    flash[:notice] = 'Movie was successfully deleted.'
    redirect_to movies_url
  end

  private

  def set_movie
    @movie = Movie.find(params[:id])
  end
  
  def movie_params
    params.require(:movie).permit(:title, :summary, :year, :genre, :imdb_link)
  end
end
