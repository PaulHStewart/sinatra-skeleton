class CreateTables <ActiveRecord::Migration


def change 
	create_table :users do |t|
		t.string :first_name
		t.string :last_name
		t.string :email
		t.string :password
		t.string :gender
		t.timestamps
	end

	create_table :posts do |t|
		t.string :category
		t.string :url
		t.string :title
		t.string :description
		t.timestamps
	end

	create_table :comments do |t|
		t.string :commenter
		t.string :comment
		t.timestamps
	end
end
end


