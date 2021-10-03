class ReviewsController < ApplicationController
  before_action :has_moviegoer_and_movie, :only => [:new, :create, :show]

  protected

  def has_moviegoer_and_movie
    unless @current_user
      @movie = Movie.find_by_id(params[:movie_id])
      flash[:warning] = 'You must be logged in to create a review.'
      redirect_to movie_path(@movie)
    end
    unless (@movie = Movie.find_by_id(params[:movie_id]))
      flash[:warning] = 'Review must be for an existing movie.'
      redirect_to movies_path
    end
  end

  public

  def review_info
    params.require(:review).permit(:potatoes, :comments, :user_id, :movie_id)
  end

  def index
    id_movie = params[:movie_id]
    @movie = Movie.find(id_movie)
    @all_reviews_movie = Review.where(movie_id: id_movie)
  end

  ########## CREATE NEW REVIEW ##########

  def new
    @review = @movie.reviews.build
  end

  def create
    id_movie = params[:movie_id]
    @movie = Movie.find(id_movie)
    @all_reviews_movie = Review.where(movie_id: id_movie)
    @current_user.reviews << @movie.reviews.build(review_info)
    redirect_to movie_review_path(@movie, @all_reviews_movie)
  end

  ########## SHOW REVIEW ##########
  def show
    begin
      id_movie = params[:movie_id]
      #id_review = params[:id]
      @movie = Movie.find(id_movie)
      @all_reviews_movie = Review.where(movie_id: id_movie)
      @review_current_user = @all_reviews_movie.find_by_user_id(@current_user[:id])
      if @review_current_user == nil
        @status = false
      else
        @status =true
      end
    rescue ActionController::UrlGenerationError
      flash[:warning] = "You do not have review."
    end
  end

  ########## UPDATE REVIEW ##########
  def edit
    id_movie = params[:movie_id]
    @movie = Movie.find(id_movie)
    @all_reviews_movie = Review.where(movie_id: id_movie)
    @review = @all_reviews_movie.find_by_user_id(@current_user[:id])
  end

  def update
    id_movie = params[:movie_id]
    @movie = Movie.find(id_movie)
    @all_reviews_movie = Review.where(movie_id: id_movie)
    @review_current_user = @all_reviews_movie.find_by_user_id(@current_user[:id])
    if @review_current_user.update_attributes(review_info)
      flash[:notice] = "#{@movie.title}'s review was successfully updated."
      redirect_to movie_review_path(@movie, @review_current_user)
    else
      render 'edit'
    end
  end

end
