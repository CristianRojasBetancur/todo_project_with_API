require 'sinatra'
require 'make_todo'
require 'httparty'
require 'json'
# require 'sinatra/reloader' if development?

base_url = 'https://crudcrud.com/api/1db94272cf77411982b8cb399ccb7852/tasks'
# tasks = HTTParty.get(base_url).parsed_response

get '/' do
	response = HTTParty.get(base_url)
	@tasks = JSON.parse(response.body)

	erb :index
end

get '/new-task' do
	erb :add_task
end

post '/add-task' do
	params[:status].eql?('true') ? params[:status] = true : params[:status] = false
	new_task = {
		name: params[:name],
		status: params[:status]
	}

	response = HTTParty.post(
		base_url, 
		body: new_task.to_json, 
		headers: {'Content-Type' => 'application/json; charset=utf-8'})

	redirect '/'
end

# put

put '/update-task/' do
	id = params[:id]

	response = HTTParty.put("#{base_url}/#{id}",
		body: {
			name: params[:name],
			status: true
		}.to_json,
		headers: {'Content-Type' => 'application/json'})

	redirect '/'
end

# delete

delete '/delete-task/' do
	id = params[:id]
	response = HTTParty.delete("#{base_url}/#{id}")

	redirect '/'
end
