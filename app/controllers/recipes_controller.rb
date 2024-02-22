class RecipesController < ApplicationController
  before_action :set_recipe, only: %i[ show edit update destroy ]

  # GET /recipes or /recipes.json
  def index
    @recipes = Recipe.all
  end

  # GET /recipes/1 or /recipes/1.json
  def show
    @recipe = Recipe.find(params[:id])
  end

  # GET /recipes/new
  def new
    @recipe = Recipe.new
  end

  # GET /recipes/1/edit
  def edit
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
    respond_to do |format|
      if @recipe.update(recipe_params)
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
      params.require(:recipe).permit(:title, :preparationtime, :cookingtime, :restingtime, :description, :price, :difficulty, :step1, :step2, :step3, :image, category_ids: [], ingredient_ids: [], ingredient_quantities: [])
    end


    # Méthode pour sauvegarder les ingrédients avec les quantités
    def save_recipe_ingredients(recipe)
      ingredient_ids_with_quantities = params[:recipe][:ingredient_ids].map(&:to_i).zip(params[:recipe][:ingredient_quantities].values)

      ingredient_ids_with_quantities.each do |ingredient_id, quantity|
        next if quantity.blank?

        ingredient = Ingredient.find(ingredient_id)
        recipe.recipe_ingredients.create(ingredient_id: ingredient_id, quantity: quantity, title: ingredient.title, image: ingredient.image)
      end
    end



    def delete_associated_entries(recipe)
      recipe.recipe_ingredients.destroy_all
      recipe.recipe_categories.destroy_all
    end

end
