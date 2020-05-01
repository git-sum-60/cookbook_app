require 'rails_helper'

RSpec.describe "Recipes", type: :request do
  describe "GET /api/recipes" do
    it "returns all the recipes in the database" do
      # response = get "/api/recipes"
      user = User.create!(email: "kerry@keryy.com", password: "password", name: "kary")

      Recipe.create!(title: "thai curry", ingredients: "bottle of curry", directions: "pour the sauce on whatever", prep_time: 3, user_id: user.id)
      
      get "/api/recipes"

      p JSON.parse(response.body)
      
      recipes = JSON.parse(response.body)
      
      expect(response).to have_http_status(200)
      expect(recipes.length).to eq(1)
    end
  end
  describe "GET /api/recipes/:id" do
    it 'should return one recipe based on its id' do
      user = User.create!(email: "kerry@keryy.com", password: "password", name: "kary")

      recipe_db = Recipe.create!(title: "pineapple", ingredients: "pine + apples", directions: "slice the pineapple", prep_time: 5, user_id: user.id)


      get "/api/recipes/#{recipe_db.id}"

      recipe = JSON.parse(response.body)

      expect(response).to have_http_status(200)
      expect(recipe['title']).to eq('pineapple')
    end
  end
end
