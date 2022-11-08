require 'json'
require 'httparty'

module Tasks
	BASE_URL = 'https://crudcrud.com/api/b2c5936682d246ed8bc1c53fa903849d'

	def all
		response = HTTParty.get("#{BASE_URL}/tasks")
		JSON.parse(response.body)
	end

	def create(new_task)
		response = HTTParty.post(
		"#{BASE_URL}/tasks", 
		body: new_task.to_json, 
		headers: {'Content-Type' => 'application/json; charset=utf-8'})
	end

	def update(updated_task, id)
		response = HTTParty.put("#{BASE_URL}/tasks/#{id}",
		body: updated_task.to_json,
		headers: {'Content-Type' => 'application/json'})
	end

	def destroy(id)
		HTTParty.delete("#{BASE_URL}/tasks/#{id}")
	end
end