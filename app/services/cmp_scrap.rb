# frozen_string_literal: true
require 'nokogiri'
require 'open-uri'

# class CmpScrap

	def all_departements_list_url
		url = 'http://www.santeenfrance.fr/annuaire/13-centres-medico-psychologiques-cmp-cattp'
		return url
	end

	def open_all_departements_list_url(url)
		html_content = open(url)
		page = Nokogiri::HTML(html_content)
		return page
	end

	def get_all_departements_zip_codes(page)
		departements = page.xpath("//*[@id='page']/div[3]/div/div[1]/div/ul/li/a")
		departements_array = []
		departements.each do |each_departement|
			departements_array << (each_departement.text).split('(').last.split(')').first
		end
	  return departements_array
	end

	def get_cmp_urls(url, zip_codes)
		departement_url = (url+'/dep:')
		website_url = 'http://www.santeenfrance.fr/'
		urls_array = []
		zip_codes.each do |zip_code|
			html_content = open(departement_url+zip_code.to_s)
			page = Nokogiri::HTML(html_content)
			x = page.xpath("//*[@id='page']/div[3]/div/div[1]/div/div/ul/li/span/a[@rel='last']")
			case x.size
			when 0
				cmp_urls = page.xpath("//*[@id='page']/div[3]/div/div[1]/ul/li/div[2]/h3/a")
				cmp_urls.each do |cmp_url|
					case (cmp_url.text).start_with?("CMP ", "C.M.P. ")
					when true
						urls_array << website_url+(cmp_url.first)[1]
					end
				end
			else
				cmp_urls = page.xpath("//*[@id='page']/div[3]/div/div[1]/ul/li/div[2]/h3/a")
				cmp_urls.each do |cmp_url|
					case (cmp_url.text).start_with?("CMP ", "C.M.P. ")
					when true
						urls_array << website_url+(cmp_url.first)[1]
					end
				end
				departement_last_page = page.xpath("//*[@id='page']/div[3]/div/div[1]/div/div/ul/li/span/a[@rel='last']").to_s.split(':').last.split('"').first
				departement_url_n = (departement_url+zip_code.to_s+'/page:')
				for i in 2..departement_last_page.to_i
					html_content_n = open(departement_url_n+i.to_s)
					page_n = Nokogiri::HTML(html_content_n)
					cmp_urls_n = page_n.xpath("//*[@id='page']/div[3]/div/div[1]/ul/li/div[2]/h3/a")
					cmp_urls_n.each do |cmp_url_n|
						case (cmp_url_n.text).start_with?("CMP ", "C.M.P. ")
						when true
							urls_array << website_url+(cmp_url_n.first)[1]
						end
					end
				end
			end
		end
		return urls_array
	end

	def get_cmp_names(cmp_urls_list)
		names_array = []
		cmp_urls_list.each do |cmp_url|
			html_content = open(cmp_url)
			page = Nokogiri::HTML(html_content)
			cmp_name = page.xpath("//*[@id='view_etablissement']/div[1]/div[2]/h1/span/text()")
			names_array << (cmp_name).to_s.split(',').first
		end
		return names_array
	end

	def get_cmp_addresses(cmp_urls_list)
		addresses_array = []
		cmp_urls_list.each do |cmp_url|
			html_content = open(cmp_url)
			page = Nokogiri::HTML(html_content)
			cmp_address = page.xpath("//*[@id='left-col']/div[2]/div[1]/span")
			cmp_address_text = cmp_address.at("//span[@itemprop = 'streetAddress']").children.text
			addresses_array << (cmp_address_text)
		end
		return addresses_array
	end

	def get_cmp_locations(cmp_urls_list)
		locations_array = []
		cmp_urls_list.each do |cmp_url|
			html_content = open(cmp_url)
			page = Nokogiri::HTML(html_content)
			cmp_location = page.xpath("//*[@id='left-col']/div[2]/div[1]/span")
			cmp_location_text = cmp_location.at("//span[@itemprop = 'addressLocality']").children.text
			locations_array << (cmp_location_text)
		end
		return locations_array
	end

	def get_cmp_phone_numbers(cmp_urls_list)
		phone_numbers_array = []
		cmp_urls_list.each do |cmp_url|
			html_content = open(cmp_url)
			page = Nokogiri::HTML(html_content)
			cmp_phone_number = page.xpath("//*[@id='left-col']/div[2]/div[1]/div[1]/a")
			cmp_phone_number_text = cmp_phone_number.at("//span[@itemprop = 'telephone']").children.text
			phone_numbers_array << (cmp_phone_number_text)
		end
		return phone_numbers_array
	end

	def perform
		dpt_list_url = all_departements_list_url
		sleep 1
		dpt_list_page = open_all_departements_list_url(dpt_list_url)
		sleep 1
		dpt_zip_list = get_all_departements_zip_codes(dpt_list_page)
		sleep 1
		cmp_urls = get_cmp_urls(dpt_list_url, dpt_zip_list)
		sleep 1
		cmp_names = get_cmp_names(cmp_urls)
		sleep 1
		cmp_addresses = get_cmp_addresses(cmp_urls)
		sleep 1
		cmp_locations = get_cmp_locations(cmp_urls)
		sleep 1
		cmp_phone_number = get_cmp_phone_numbers(cmp_urls)

		puts '*' * 50
		puts "URL : #{dpt_list_url}"
		puts '.' * 50
		puts "Nombre de départements récupérés : #{dpt_zip_list.size}"
		puts '.' * 50
		puts "Nombre de CMP récupérés : #{cmp_urls.size}"
		puts cmp_urls.first
		puts '.' * 50
		puts "Nombre de noms récupérés : #{cmp_names.size}"
		puts cmp_names.first
		puts '.' * 50
		puts "Nombre d'adresses récupérées : #{cmp_addresses.size}"
		puts cmp_addresses.first
		puts '.' * 50
		puts "Nombre de lieux récupérés : #{cmp_locations.size}"
		puts cmp_locations.first
		puts '.' * 50
		puts "Nombre de téléphones récupérés : #{cmp_phone_number.size}"
		puts cmp_phone_number.first
		puts '*' * 50
	end

	perform

# end
