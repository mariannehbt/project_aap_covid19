require 'pry'

class TestScrap
	attr_accessor :dpts_urls_array, :dpts_sub_urls_array, :cmps_urls_array, :cmps_names_array, :cmps_addresses_array, :cmps_locations_array, :cmps_phone_numbers_array, :all_data_array

	def initialize
		@cmps_names_array = []
		@cmps_addresses_array = []
		@cmps_locations_array = []
		@cmps_phone_numbers_array = []
		@all_data_array = []
	end

	def get_cmps_names
		for i in 1..10
			@cmps_names_array << ('CPM n°' + i.to_s)
		end
		return @cmps_names_array
	end

	def get_cmps_addresses
		for i in 1..10
			@cmps_addresses_array << ('Adresse n°' + i.to_s)
		end
		return @cmps_addresses_array
	end

	def get_cmps_locations
		for i in 1..10
			@cmps_locations_array << ('Ville + CP n°' + i.to_s)
		end
		return @cmps_locations_array
	end

	def get_cmps_phone_numbers
		for i in 1..10
			@cmps_phone_numbers_array << ('Téléphone n°' + i.to_s)
		end
		return @cmps_phone_numbers_array
	end

	def all_data
		@all_data_array = @cmps_names_array.zip([@cmps_addresses_array, @cmps_locations_array, @cmps_phone_numbers_array].transpose).to_h
	end

	def perform
		cmps_names = get_cmps_names
		cmps_addresses = get_cmps_addresses
		cmps_locations = get_cmps_locations
		cmps_phone_numbers = get_cmps_phone_numbers
		all_data = all_data
	end

end

# binding.pry
puts "end of file"
