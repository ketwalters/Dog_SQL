require "mysql2"

class Dog
	attr_accessor :name, :color, :id
	@@dbase = Mysql2::Client.new(:host => "127.0.0.1", :username => "root", 
	:database => "dogs")

	def initialize(name, color)
		 @name = name
		 @color = color
	end

	def self.db
		@@dbase
	end

	def db
		@@dbase
	end

	def self.find(id)
		results = db.query("
			SELECT *
			FROM dogs
			WHERE id = #{id}")
		if results.first.nil?
			"Not Here"
		else 
			dog = Dog.new(results.first["name"], results.first["color"])
			dog.id = id
			dog
		end
	end

	def self.find_by_name(name)
		results = db.query("
			SELECT *
			FROM dogs
			WHERE name = '#{name}'")
		if results.first.nil?
			"Not here"
		else
			dog = Dog.new(results.first["id"], results.first["color"])
			dog.name = name
			dog
		end
	end

	def self.insert(name, color)
			db.query("INSERT INTO dogs(name, color) 
			VALUES('#{name}', '#{color}')")
	end

	def self.update(name, color, id)
		db.query("UPDATE dogs
      SET name = '#{name}', color = '#{color}'
      WHERE id = #{id}")
	end

	def self.delete(name, color, id)
		db.query("DELETE FROM dogs
			WHERE name = '#{name}' AND
			color = '#{color}' AND
			id = #{id}")
	end










end

#dog = Dog.find(1)
#puts dog.name
#puts Dog.find(1)
#puts Dog.find_by_name("Spot")
#dog = Dog.find_by_name("Spot")
#Dog.insert("Jet","black")
#Dog.update("Lucky", "brown", 2)
Dog.delete("Jet", "black", 3)
