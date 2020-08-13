class FixArticleCategoriesCategory < ActiveRecord::Migration[6.0]
  def change

    rename_column :article_categories, :category, :category_id

  end
end
