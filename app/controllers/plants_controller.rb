class PlantsController < ApplicationController
  def index
    json = PlantService.new.get_all_plants
    plants = json.map do |plant|
      ApiPlant.new(plant)
    end
    render locals: {plants: plants.paginate(:page => params[:page], :per_page => 24)}
  end
end
