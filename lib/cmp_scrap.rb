# frozen_string_literal: true

require 'nokogiri'
require 'open-uri'

def open_departement_first_page
	departement_first_page = Nokogiri::HTML(open('http://www.santeenfrance.fr/annuaire/13-centres-medico-psychologiques-cmp-cattp/dep:75'))
	return departement_first_page
end

def find_departement_last_page_number(dpt_page_1)
	departement_last_page = dpt_page_1.xpath("//*[@id='page']/div[3]/div/div[1]/div/div/ul/li/span/a[@rel='last']").to_s.split(':').last.split('"').first
	return departement_last_page.to_i
end

def put_departement_all_urls_in_array(dpt_page_1, dpt_nb_of_pages)
	url = 'http://www.santeenfrance.fr/annuaire/13-centres-medico-psychologiques-cmp-cattp/dep:75/page:'
	departement_all_url_array = []
	departement_all_url_array << dpt_page_1
	for i in 2..dpt_nb_of_pages
		html_content = open(url+i.to_s).read
		page = Nokogiri::HTML(html_content)
		departement_all_url_array << page
	end
	return departement_all_url_array
end

def get_departement_all_pages_cmp_names(dpt_all_pages)
	departement_all_pages_cmp_names_array = []
	dpt_all_pages.each do |dpt_each_page|
		departement_all_pages_cmp_names = dpt_each_page.xpath("//*[@id='page']/div[3]/div/div[1]/ul/li/div[2]/h3/a")
		departement_all_pages_cmp_names.each do |each_dpt_cmp_name|
			departement_all_pages_cmp_names_array << (each_dpt_cmp_name.text)
		end
	end
	return departement_all_pages_cmp_names_array
end

def get_departement_all_pages_cmp_addresses(dpt_all_pages)
	departement_all_pages_cmp_addresses_array = []
	dpt_all_pages.each do |dpt_each_page|
		departement_all_pages_cmp_addresses = dpt_each_page.xpath("//*[@id='page']/div[3]/div/div[1]/ul/li/div[2]/div/p")
		departement_all_pages_cmp_addresses.each do |each_dpt_cmp_address|
			departement_all_pages_cmp_addresses_array << (each_dpt_cmp_address.text)
		end
	end
	return departement_all_pages_cmp_addresses_array
end

def create_final_array(names, addresses)
  names.zip(addresses).map { |k, v| { k => v } }
end

def perform
	dpt_first_page = open_departement_first_page
	dpt_last_page = find_departement_last_page_number(dpt_first_page)
	dpt_all_urls_array = put_departement_all_urls_in_array(dpt_first_page, dpt_last_page)
	dpt_all_pages_cmp_names = get_departement_all_pages_cmp_names(dpt_all_urls_array)
	dpt_all_pages_cmp_addresses = get_departement_all_pages_cmp_addresses(dpt_all_urls_array)
	dpt_all_data = create_final_array(dpt_all_pages_cmp_names, dpt_all_pages_cmp_addresses)


	puts '*' * 50
	puts "Nombre de pages : #{dpt_last_page} (#{dpt_all_urls_array.size})"
	puts '-' * 50
	puts "Nombre de centres : #{dpt_all_pages_cmp_names.size}"
	puts '-' * 50
	puts dpt_all_pages_cmp_names
	puts '-' * 50
	puts dpt_all_pages_cmp_addresses
	puts '*' * 50
	puts dpt_all_data
	puts dpt_all_data.size
	puts '*' * 50
end

perform
