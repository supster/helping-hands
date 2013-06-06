class ReviewsController < ApplicationController
  def new
  	@program = Program.find(params[:prog])
  	@location = Location.find(params[:loc])
  	@review = Review.new
  	#@encouragement = Encouragement.new
  end

  def create
    @review = Review.new(params[:review])
    @review.program_id = params[:program_id]
    @review.location_id = params[:location_id]
    if @review.save
      flash[:success] = "Review posted!  Thank you!"
      redirect_to root_path
    else
      render "new"
    end  	
  end
end
