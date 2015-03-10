class Comment < ActiveRecord:: Base
	#this adds the class to the database
	belongs_to :user
	belongs_to :post
end