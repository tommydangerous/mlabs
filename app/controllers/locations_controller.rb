class LocationsController < ApplicationController
	def index
		@title = "Work Locations"
		lab_employees = []
		office_employees =[]
		Employee.find_each do |e|
			if e.current_location == 1
				lab_employees.push(e)
			elsif e.current_location == 2
				office_employees.push(e)
			end
		end
		@lab = lab_employees.sort_by { |e| e.last_name }
		@office = office_employees.sort_by { |e| e.last_name }
	end

	def new
		@title = "New Location"
		@location = Location.new
	end

	def create
		@location = Location.new(params[:location])
		if @location.save
			redirect_to locations_path
		else
			@title = "New Location"
			render 'new'
		end
	end

	def set_locations
		set
		redirect_to locations_path
	end

	def switch_locations
		switch
		redirect_to locations_path
	end

	def delete_directions
		Direction.destroy_all
		redirect_to locations_path
	end
end