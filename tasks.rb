require 'json'
require 'HTTParty'

module Tasks
	BASE_URL = 'https://crudcrud.com/api/c5233a18cce2415bbc95d1874ea12095'

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