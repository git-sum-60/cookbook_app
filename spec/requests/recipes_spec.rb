require 'rails_helper'

RSpec.describe "Recipes", type: :request do
  describe "GET /api/recipes" do
    it "returns all the recipes in the database" do
      # response = get "/api/recipes"
      user = User.create!(email: "kerry@keryy.com", password: "password", name: "kary")

      Recipe.create!(title: "thai curry", ingredients: "bottle of curry", directions: "pour the sauce on whatever", prep_time: 3, user_id: user.id)
      
      get "/api/recipes"

      
      
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
  describe "POST /api/recipes" do
    it 'should create a new recipe in the db' do
      user = User.create!(email: "kerry@keryy.com", password: "password", name: "kary")

      jwt = JWT.encode(
        {
          user_id: user.id, # the data to encode
          exp: 24.hours.from_now.to_i # the expiration time
        },
        Rails.application.credentials.fetch(:secret_key_base), # the secret key
        "HS256" # the encryption algorithm
      )

     
      
      post "/api/recipes", params: {
        title: "asparagus",  
        ingredients: "di", 
        directions: "wait", 
        prep_time: 99999
      }, headers: {
        "Authorization" => "Bearer #{jwt}"
      }

      recipe = JSON.parse(response.body)

      expect(response).to have_http_status(200)
      expect(recipe['title']).to eq('asparagus')
    end
    it 'should prevent someone who is not logged in from creating a recipe' do
      post "/api/recipes", params: {
        title: "brussels sprouts",  
        ingredients: "bruss+ sproout", 
        directions: "don't wait", 
        prep_time: 23432
      }

      recipe = JSON.parse(response.body)

      expect(response).to have_http_status(401)      
    end
  end
end
