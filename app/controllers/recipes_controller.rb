class RecipesController < ApplicationController
  before_action :set_recipe, only: %i[show edit update destroy]

  # GET /recipes or /recipes.json
  def index
    @categories = Category.all
    @recipes = Recipe.all
  end

  # GET /recipes/apropos
  def apropos
    @recipes = Recipe.all
  end

  # GET /recipes/1 or /recipes/1.json
  def show
    if params[:id] == "apropos"
      render 'apropos'
    else
      @recipe = Recipe.find(params[:id])
      @ingredients = @recipe.ingredients
    end
  end

  # GET /recipes/new
  def new
    @recipe = Recipe.new
    @quantities = {}
    @unities = {}
  end

  # GET /recipes/1/edit
  def edit
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
        save_recipe_ingredients(@recipe)  # Appel de la méthode pour sauvegarder les ingrédients
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
        @recipe.recipe_ingredients.destroy_all
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
    # Utilisez des callbacks pour partager la configuration commune ou les contraintes entre actions.
    def set_recipe
      if params[:id] != "apropos"
        @recipe = Recipe.find(params[:id])
      end
    end

    # Seuls les paramètres autorisés sont autorisés.
    def recipe_params
      params.require(:recipe).permit(:title, :preparationtime, :cookingtime, :restingtime, :description, :price, :difficulty, :step1, :step2, :step3, :step4, :step5, :step6, :step7, :step8, :step9, :step10, :image, :nbperson, category_ids: [], ingredient_ids: [], ingredient_quantities: [], ingredient_unitys: [])
    end

    # Méthode pour sauvegarder les ingrédients d'une recette
    def save_recipe_ingredients(recipe)
      ingredient_ids = params.dig(:recipe, :ingredient_ids)
      ingredient_quantities = params.dig(:recipe, :ingredient_quantities)
      ingredient_unities = params.dig(:recipe, :ingredient_unities)  # Correction du nom du paramètre
    
      return if ingredient_ids.nil? || ingredient_quantities.nil? || ingredient_unities.nil?
    
      ingredient_ids.each do |ingredient_id|
        quantity = ingredient_quantities[ingredient_id.to_sym]
        unity = ingredient_unities[ingredient_id.to_sym]  # Correction du nom de la variable
    
        next if quantity.blank? || unity.blank?
    
        ingredient = Ingredient.find(ingredient_id)
    
        recipe.recipe_ingredients.create(
          ingredient_id: ingredient_id,
          quantity: quantity,
          unity: unity,
          title: ingredient.title,
          image: ingredient.image
        )
      end
    end
    
    # Méthode pour supprimer les entrées associées à une recette
    def delete_associated_entries(recipe)
      recipe.recipe_ingredients.destroy_all
      recipe.recipe_categories.destroy_all
    end
end
