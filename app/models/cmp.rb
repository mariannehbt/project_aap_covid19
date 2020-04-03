class Cmp < ApplicationRecord
	geocoded_by :adress
	after_validation :geocode, if: :adress_changed?
end
