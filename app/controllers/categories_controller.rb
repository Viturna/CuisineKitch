class CategoriesController < ApplicationController
  before_action :set_category, only: %i[ show edit update destroy ]

  # GET /categories or /categories.json
  def index
    @categories = Category.all
    @current_page_url = request.original_url
    @page_title = "Voir les catégories - Cuisine Kitch"
    @meta_description = "Découvrez nos catégories sur Cuisine Kitch. Explorez une variété de catégories culinaires, des desserts décadents aux plats principaux étrangement délicieux, et trouvez l'inspiration pour vos prochaines créations culinaires !"
  end

  # GET /categories/1 or /categories/1.json
  def show
  end

  # GET /categories/new
  def new
    @category = Category.new
    @current_page_url = request.original_url
    @page_title = "Ajouter une catégorie - Cuisine Kitch"
    @meta_description = "Ajoutez une catégorie à notre collection sur Cuisine Kitch. Créez une nouvelle catégorie culinaire et partagez votre passion pour la cuisine créative avec notre communauté excentrique !"
  end

  # GET /categories/1/edit
  def edit
  end

  # POST /categories or /categories.json
  def create
    @category = Category.new(category_params)

    respond_to do |format|
      if @category.save
        format.html { redirect_to categories_path, notice: "Category was successfully created." }
        format.json { render :show, status: :created, location: @category }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /categories/1 or /categories/1.json
  def update
    respond_to do |format|
      if @category.update(category_params)
        format.html { redirect_to categories_path, notice: "Category was successfully updated." }
        format.json { render :show, status: :ok, location: @category }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /categories/1 or /categories/1.json
  def destroy
    delete_associated_entries(@category)
    @category.destroy!

    respond_to do |format|
      format.html { redirect_to categories_url, notice: "Category was successfully destroyed." }
      format.json { head :no_content }
    end
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def category_params
      params.require(:category).permit(:title)
    end

    def delete_associated_entries(category)
      category.recipe_categories.destroy_all
    end
end
