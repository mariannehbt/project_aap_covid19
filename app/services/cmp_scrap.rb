require 'nokogiri'
require 'open-uri'
require 'pry'
require 'watir'
require 'webdrivers'

class CmpScrap
	attr_accessor :dpts_urls_array, :dpts_sub_urls_array, :cmps_urls_array, :cmps_names_array, :cmps_addresses_array, :cmps_locations_array, :cmps_phone_numbers_array, :all_data_array

	def initialize
		@browser = Watir::Browser.new :chrome, headless: true
		@domain = 'http://www.santeenfrance.fr/'
		@directory = '/annuaire/13-centres-medico-psychologiques-cmp-cattp'
		@dpt_path = '/dep:'
		@page_path = '/page:'
		@dpts_urls_array = []
		@dpts_sub_urls_array = []
		@cmps_urls_array = []
		@cmps_names_array = []
		@cmps_addresses_array = []
		@cmps_locations_array = []
		@cmps_phone_numbers_array = []
		@all_data_array = []
	end

	def get_departments_urls
		@browser.goto @domain + @directory
		Nokogiri::HTML(@browser.html).xpath("//*[@id='page']/div[3]/div/div[1]/div/ul/li/a").each do |dpt|
			@dpts_urls_array << @domain + @directory + @dpt_path + dpt.text.split('(').last.split(')').first
		end
		return @dpts_urls_array
	end

	def get_departments_sub_urls(dpts_urls)
		dpts_urls.each do |dpt|
			@browser.goto dpt
			page = Nokogiri::HTML(@browser.html)
			x = page.xpath("//*[@id='page']/div[3]/div/div[1]/div/div/ul/li/span/a[@rel='last']")
			case x.size
			when 0
				@dpts_sub_urls_array << dpt
			else
				@dpts_sub_urls_array << dpt
				dpt_last_page = page.xpath("//*[@id='page']/div[3]/div/div[1]/div/div/ul/li/span/a[@rel='last']").to_s.split(':').last.split('"').first
				for i in 2..dpt_last_page.to_i
					@dpts_sub_urls_array << dpt + @page_path + i.to_s
				end
			end
		end
		return @dpts_sub_urls_array
	end

	def get_cmps_urls(dpts_sub_urls)
		dpts_sub_urls.each do |dpt_sub_url|
			@browser.goto dpt_sub_url
			Nokogiri::HTML(@browser.html).xpath("//*[@id='page']/div[3]/div/div[1]/ul/li/div[2]/h3/a").each do |medical_center|
				case medical_center.text.start_with?("CMP ", "C.M.P. ")
				when true
					@cmps_urls_array << @domain + medical_center.first[1]
				end
			end
		end
		return @cmps_urls_array
	end

	def get_cmps_names(cmps_urls)
		cmps_urls.each do |cmp_url|
			@browser.goto cmp_url
			@cmps_names_array << Nokogiri::HTML(@browser.html).xpath("//*[@id='view_etablissement']/div[1]/div[2]/h1/span/text()").to_s.split(',').first
		end
		return @cmps_names_array
	end

	def get_cmps_addresses(cmps_urls)
		cmps_urls.each do |cmp_url|
			@browser.goto cmp_url
			@cmps_addresses_array << Nokogiri::HTML(@browser.html).xpath("//*[@id='left-col']/div[2]/div[1]/span").at("//span[@itemprop = 'streetAddress']").children.text
		end
		return @cmps_addresses_array
	end

	def get_cmps_locations(cmps_urls)
		cmps_urls.each do |cmp_url|
			@browser.goto cmp_url
			@cmps_locations_array << Nokogiri::HTML(@browser.html).xpath("//*[@id='left-col']/div[2]/div[1]/span").at("//span[@itemprop = 'addressLocality']").children.text
		end
		return @cmps_locations_array
	end

	def get_cmps_phone_numbers(cmps_urls)
		cmps_urls.each do |cmp_url|
			@browser.goto cmp_url
			@cmps_phone_numbers_array << Nokogiri::HTML(@browser.html).xpath("//*[@id='left-col']/div[2]/div[1]/div[1]/a").at("//span[@itemprop = 'telephone']").children.text
		end
		return @cmps_phone_numbers_array
	end

	def all_data
		@all_data_array = @cmps_names_array.zip([@cmps_addresses_array, @cmps_locations_array, @cmps_phone_numbers_array].transpose).to_h
	end

	def perform
		dpts_urls = get_departments_urls
		dpts_sub_urls = get_departments_sub_urls(dpts_urls)
		cmps_urls = get_cmps_urls(dpts_sub_urls)
		cmps_names = get_cmps_names(cmps_urls)
		cmps_addresses = get_cmps_addresses(cmps_urls)
		cmps_locations = get_cmps_locations(cmps_urls)
		cmps_phone_numbers = get_cmps_phone_numbers(cmps_urls)
		all_data = all_data
	end

end

binding.pry
puts "end of file"
