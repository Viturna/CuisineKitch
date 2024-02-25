class RecipesController < ApplicationController
  before_action :set_recipe, only: %i[ show edit update destroy ]

  # GET /recipes or /recipes.json
  def index
    @categories = Category.all
    @recipes = Recipe.all
    @current_page_url = request.original_url
    @page_title = "Cuisine Kitch - Recettes déjantées pour une cuisine créative"
    @meta_description = "Explorez l'univers déjanté de Cuisine Kitch, où la créativité culinaire est à l'honneur. Découvrez des recettes uniques, partagez vos créations et plongez dans un voyage gustatif sans pareil. Rejoignez-nous dès aujourd'hui pour une expérience culinaire inoubliable !"
 end

  def apropos
    @recipes = Recipe.all
    @current_page_url = request.original_url
    @page_title = "À propos de Cuisine Kitch - Découvrez notre univers déjanté"
    @meta_description = "Découvrez l'univers déjanté de Cuisine Kitch. Explorez notre mission, notre communauté et nos recettes farfelues. Rejoignez-nous pour une expérience culinaire unique !"
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
    @current_page_url = request.original_url
    @page_title = "Ajouter une recette - Cuisine Kitch"
    @meta_description = "Ajoutez vos recettes uniques, partagez avec une communauté passionnée et explorez de nouveaux horizons gustatifs. Rejoignez-nous pour une expérience culinaire unique !"
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
    @recipe = Recipe.new(recipe_params.except(:ingredient_quantities, :ingredient_unities))

    if @recipe.save
      # Enregistrez les ingrédients avec leurs quantités et unités
      save_ingredients(recipe_params[:ingredient_quantities], recipe_params[:ingredient_unities])

      redirect_to @recipe, notice: 'Recipe was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /recipes/1 or /recipes/1.json
  def update
    @recipe = Recipe.find(params[:id])
  
    respond_to do |format|
      if @recipe.update(recipe_params.except(:ingredient_quantities, :ingredient_unities))
        # Mettre à jour les ingrédients associés à la recette
        save_ingredients(recipe_params[:ingredient_quantities], recipe_params[:ingredient_unities], @recipe)
  
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
      if params[:id] != "apropos"
        @recipe = Recipe.find(params[:id])
      end
    end
    def recipe_params
      params.require(:recipe).permit(
        :title, :preparationtime, :cookingtime, :restingtime, :description,
        :difficulty, :price, :nbperson, :step1, :step2, :step3, :step4, :step5,
        :step6, :step7, :step8, :step9, :step10, :image,
        category_ids: [],
        ingredient_quantities: {},
        ingredient_unities: {}
      )
    end

    def save_ingredients(quantities, unities, recipe)
      quantities.each do |ingredient_id, quantity|
        unity = unities[ingredient_id]
        ingredient = Ingredient.find(ingredient_id)
        
        # Créer ou mettre à jour l'ingrédient associé à la recette avec la quantité et l'unité
        recipe_ingredient = recipe.recipe_ingredients.find_or_initialize_by(ingredient_id: ingredient_id)
        recipe_ingredient.title = ingredient.title
        recipe_ingredient.image = ingredient.image
        recipe_ingredient.quantity = quantity
        recipe_ingredient.unity = unity
        recipe_ingredient.save
      end
    end
    

    def delete_associated_entries(recipe)
      recipe.recipe_ingredients.destroy_all
      recipe.recipe_categories.destroy_all
    end

end
