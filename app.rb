require 'sinatra'
require 'sinatra/reloader' if development?
require './tasks'
require "sinatra/base"

class MyApp < Sinatra::Base
	include Tasks

	get '/' do
		@tasks = all
		@type_tasks = params[:type_tasks]
		@complete_tasks = @tasks.select { |task| task['status'] }
		@incomplete_tasks = @tasks.select { |task| !task['status'] }

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

		create(new_task)
		redirect '/'
	end

	# put

	post '/update-task/' do
		id = params[:id]
		updated_task = {
			name: params[:name],
			status: true
		}
		
		update(updated_task, id)
		redirect '/'
	end

	# delete

	post '/delete-task/' do
		id = params[:id]

		destroy(id)
		redirect '/'
	end

  run!
end