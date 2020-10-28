require 'rails_helper'

RSpec.describe "Recipes", type: :request do
  describe "GET /recipes" do
    it "returns an array of recipe hashes" do
      user = User.create(name: "Cheddar", email: "cheddar@gmail.com", password: "password")
      Recipe.create(title: "Example 1", prep_time: 10, user_id: user.id)
      Recipe.create(title: "Example 2", prep_time: 15, user_id: user.id)
      Recipe.create(title: "Example 3", prep_time: 18, user_id: user.id)
      get "/api/recipes"
      recipes = JSON.parse(response.body)
      expect(response).to have_http_status(200)
      expect(recipes.length).to eq(3)
    end
  end
end
