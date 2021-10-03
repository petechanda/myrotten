class MoviesController < ApplicationController

	before_action :require_login, :except => [:index, :show, :search_tmdb]

	def require_login
		unless @current_user
			flash[:warning] = "You have to login first!!!"
			redirect_to movies_path
		end
	end

	########## HOME PAGE ##########
	def index
		@all_movies = Movie.all
		@movies = @all_movies.order('title')
	end

	########## SHOW DETAILS PAGE ##########
	def show
		begin
			# find movie by id
			id = params[:id]
			@movie = Movie.find(id)
			# show up app/views/movies/show.html.haml
			@review = Review.find_by_movie_id(id)
		rescue ActiveRecord::RecordNotFound
			flash[:warning] = "Movie is not found."
			redirect_to movies_path
		end
	end

	# information for creating and updating movie's details
	def movie_info
		params.require(:movie).permit(:title, :rating, :release_date, :description)
	end

	########## CREATE PAGE ##########
	def new
		@movie = Movie.new
	end

	def create 
		# create movie by movie's info
		@movie = Movie.new(movie_info)
		if @movie.save
			# if creation is successful, show up 'successful' message
			flash[:notice] = "#{@movie.title} was successfully created."
			# if creation is successful, redirect to home page
			redirect_to new_movie_review_path(@movie)
		else
			# if user doesn't type anything
			render 'new'
		end
	end

	########## EDIT (UPDATE) PAGE ##########
	def edit
		# find movie by id
		id = params[:id]
		@movie = Movie.find(id)
	end

	def update
		# find movie by id
		id = params[:id]
		@movie = Movie.find(id)
		# update movie's details
		if @movie.update_attributes(movie_info)
			# if updation is successful, show up successful message
			flash[:notice] = "#{@movie.title} was successfully updated."
			# if updation is successful, redirect to show up movie's details
			redirect_to @movie
		else
			# if user doesn't type anthing
			render 'edit'
		end
	end

	########## DELETE MENU ##########
	def destroy 
		# find movie by id
		id = params[:id]
		@movie = Movie.find(id)
		# delete movie
		@movie.destroy
		# if movie is deleted, show up successful message
		flash[:notice] = "#{@movie.title} deleted."
		# if movie is deleted, redirect to all lists of movies
		redirect_to movies_path
	end

	def search_tmdb
		@search_tmdb = params[:search_tmdb]
		if @search_tmdb == ""
			flash[:warning] = "You cannot blank"
			redirect_to movies_path
		else 
			@movies = Movie.find_in_tmdb(@search_tmdb)
			if @movies != []
				render 'tmdb'
			else
				flash[:warning] = "Sorry, No match for '#{params[:search_tmdb]}'"
				redirect_to movies_path
			end 
		end
	end

	def create_from_tmdb
		movie_id = params[:tmdb_id]
		m = Movie.get_from_tmdb(movie_id)
		@movie = Movie.new({
						:title => m["title"], 
						:rating => "",    
						:release_date => m["release_date"], 
						:description => m["overview"]
		})
		if @movie.save
			flash[:notice] = "'#{@movie.title}' was successfully created."
			redirect_to new_movie_review_path(@movie)
		end
	end

end



