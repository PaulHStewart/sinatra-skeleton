class User < ActiveRecord::Base
	#this adds the class to the database
	has_many :posts
	has_many :comments
end