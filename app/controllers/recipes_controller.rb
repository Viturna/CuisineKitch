class RecipesController < ApplicationController
  before_action :set_recipe, only: %i[ show edit update destroy ]

  # GET /recipes or /recipes.json
  def index
     @categories = Category.all
    @recipes = Recipe.all
  end

  # GET /recipes/1 or /recipes/1.json
  def show
    @recipe = Recipe.find(params[:id])
  end

  # GET /recipes/new
  def new
    @recipe = Recipe.new
    @quantities = {}
    @unities = {}
  end


# GET /recipes/1/edit
def edit
  @recipe = Recipe.find(params[:id])
  @quantities = {}
  @unities = {}

  # Pour chaque ingrédient de la recette, récupérez la quantité et l'unité
  @recipe.recipe_ingredients.each do |recipe_ingredient|
    @quantities[recipe_ingredient.ingredient_id] = recipe_ingredient.quantity
    @unities[recipe_ingredient.ingredient_id] = recipe_ingredient.unity
  end
end


  # POST /recipes or /recipes.json
  def create
    @recipe = Recipe.new(recipe_params)

    respond_to do |format|
      if @recipe.save
        save_recipe_ingredients(@recipe) # Ajout pour sauvegarder les ingrédients avec les quantités
        format.html { redirect_to recipe_url(@recipe), notice: "Recipe was successfully created." }
        format.json { render :show, status: :created, location: @recipe }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /recipes/1 or /recipes/1.json
  def update
    @recipe = Recipe.find(params[:id])

    respond_to do |format|
      if @recipe.update(recipe_params)
        # Supprime d'abord tous les ingrédients de la recette
        @recipe.recipe_ingredients.destroy_all

        # Enregistre ensuite les nouveaux ingrédients avec les nouvelles valeurs
        save_recipe_ingredients(@recipe)

        format.html { redirect_to recipe_url(@recipe), notice: "Recipe was successfully updated." }
        format.json { render :show, status: :ok, location: @recipe }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end


  # DELETE /recipes/1 or /recipes/1.json
  def destroy
    delete_associated_entries(@recipe)
    @recipe.destroy!

    respond_to do |format|
      format.html { redirect_to recipes_url, notice: "Recipe was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_recipe
      @recipe = Recipe.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def recipe_params
      params.require(:recipe).permit(:title, :preparationtime, :cookingtime, :restingtime, :description, :price, :difficulty, :step1, :step2, :step3, :step4, :step5, :step6, :step7, :step8, :step9, :step10, :image, category_ids: [], ingredient_ids: [], ingredient_quantities: [], ingredient_unitys: [])
    end

    def save_recipe_ingredients(recipe)
      ingredient_ids = params.dig(:recipe, :ingredient_ids)
      ingredient_quantities = params.dig(:recipe, :ingredient_quantities)
      ingredient_unitys = params.dig(:recipe, :ingredient_unitys)

      return if ingredient_ids.nil? || ingredient_quantities.nil? || ingredient_unitys.nil?

      ingredient_ids.each do |ingredient_id|
        quantity = ingredient_quantities[ingredient_id.to_sym]
        unity = ingredient_unitys[ingredient_id.to_sym]

        next if quantity.blank? || unity.blank?

        # Récupération de l'ingrédient depuis la base de données
        ingredient = Ingredient.find(ingredient_id)

        # Création de la recette avec les informations de l'ingrédient
        recipe.recipe_ingredients.create(
          ingredient_id: ingredient_id,
          quantity: quantity,
          unity: unity,
          title: ingredient.title,
          image: ingredient.image
        )
      end
    end



    def delete_associated_entries(recipe)
      recipe.recipe_ingredients.destroy_all
      recipe.recipe_categories.destroy_all
    end

end
