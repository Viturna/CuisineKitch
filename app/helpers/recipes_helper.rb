module RecipesHelper
end

def total_time(recipe)
  (recipe.preparationtime.min + recipe.cookingtime.min + recipe.restingtime.min)
end
