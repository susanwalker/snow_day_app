class LocationsController < ApplicationController
  def index
    @locations = Location.order(max_inches_of_snow: :desc)
  end

  def new
  end

  def create
    @location = Location.new(params.permit(:zip_code))

    if @location.save
      redirect_to "/", notice: "Location successfully added"
    else
      redirect_to "/locations/new", notice: "Zip code needs to be unique and the correct format"
    end
  end

  def edit_report
    @location = Location.find(params[:id])

    if @location
      render :edit_report
    else
      redirect_to "/", notice: "Location doesn't exist"
    end
  end

  def update_report
    p = params.permit(:max_inches_of_snow, :id)

    location = Location.find(p[:id])

    if location && location.maybe_update_max_report(p[:max_inches_of_snow].to_i)
      redirect_to "/", notice: "Snow report successfully added"
    else
      redirect_to "/", notice: "Snow report could not be added"
    end
  end
end
