require 'gossip'


class ApplicationController < Sinatra::Base

  get '/' do
    erb :index, locals: {gossips: Gossip.all}
  end

  get '/gossips/new/' do
    erb :new_gossips
  end

  post '/gossips/new/' do
  	Gossip.new(params["gossip_author"], params["gossip_content"]).save
  	redirect '/'
  end


  get '/gossips/:x/' do
  	result = Gossip.find(params["x"].to_i)
  	coms = Gossip.coms(params["x"].to_i)

  	if result != nil && coms != nil
    	erb :page_gossip, locals: {gossips: result, id: params["x"], coms: coms}
    elsif result != nil && coms == nil
    	erb :page_gossip, locals: {gossips: result, id: params["x"], coms: 'No comment'}
    else 
    	erb :page_vide, locals: {id: params["x"]}
    end
  end

  get '/edit/:x/' do
  	erb :edit_potin
  end

  post '/edit/:x/' do
  	Gossip.update([params["gossip_author"], params["gossip_content"]], params["x"].to_i)
	redirect '/'
  end
end