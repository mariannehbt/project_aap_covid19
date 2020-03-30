class User < ApplicationRecord
	has_many :surveys

	validates :username,
	presence: true
end
