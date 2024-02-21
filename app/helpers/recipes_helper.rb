module RecipesHelper
end

def total_time(recipe)
  preparation_time = recipe.preparationtime ? recipe.preparationtime.min : 0
  cooking_time = recipe.cookingtime ? recipe.cookingtime.min : 0
  resting_time = recipe.restingtime ? recipe.restingtime.min : 0

  preparation_time + cooking_time + resting_time
end


