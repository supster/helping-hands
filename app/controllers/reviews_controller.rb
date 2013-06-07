class ReviewsController < ApplicationController
  def new
  	@program = Program.find(params[:prog])
  	@location = Location.find(params[:loc])
  	@review = Review.new
  	#@encouragement = Encouragement.new
  end

  def create
    @review = Review.new(params[:review])
    @review.program_id = params[:prog]
    @review.location_id = params[:loc]

    if @review.save
      flash[:success] = "Review posted!  Thank you!"
      redirect_to alldone_path(prog: params[:prog])
    else
  	  @program = Program.find(params[:prog])
  	  @location = Location.find(params[:loc])
      render "new"
    end  	
  end

  def index
  	@program = Program.find(params[:prog])
  	if params[:loc].nil? 
  		@reviews = @program.reviews 		
  	else
  		@location = Location.find(params[:loc]) 
  		@reviews = @program.agency.locations.find_by_id(params[:loc]).reviews
  	end
  end

  def all_done  
  	@program = Program.find(params[:prog])    	
  end
end
