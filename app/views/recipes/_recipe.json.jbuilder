json.extract! recipe, :id, :title, :preparationtime, :cookingtime, :restingtime, :description, :step1, :step2, :step3, :image, :created_at, :updated_at
json.url recipe_url(recipe, format: :json)
