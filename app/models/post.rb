class Post < ActiveRecord:: Base
	#this adds the class to the database
	belongs_to :user
	has_many :comments
end
