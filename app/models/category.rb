class Category < ApplicationRecord
    has_many :recipe_categories
    validates :title, uniqueness: true
end
