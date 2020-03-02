require 'json'

class Gossip
	def initialize(author,content)
		@author = author
		@content = content
	end

	def save
		file = File.read("./db/gossip.json")
		hash = JSON.parse(file)
		hash[@author] = @content
		File.write("./db/gossip.json", hash.to_json)

	end

	def self.all
		file = File.read("./db/gossip.json")
		hash = JSON.parse(file)
		return hash
	end

	def self.find(id)
		index_gossip = 1
  		file = File.read("./db/gossip.json")
		hash = JSON.parse(file)
		hash.each do |author,content|
			if index_gossip == id
				return [author, content]
			end
			index_gossip += 1
		end
		return nil
  	end

  	def self.update(array ,id)
		file = File.read("./db/gossip.json")
		hash = JSON.parse(file)
		tab = hash.to_a
		tab[id] = array
		hash = tab.to_h
		File.write("./db/gossip.json", hash.to_json)
	end

	def self.coms(id)
		file = File.read("./db/comment.json")
		hash = JSON.parse(file)
		hash.each do |i,comment|
			if i.to_i == id
				return comment
			end
		end
		return nil

	end
end