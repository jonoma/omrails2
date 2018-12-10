class AddListToArticles < ActiveRecord::Migration[5.2]
  def change
    add_reference :articles, :list, foreign_key: true
  end
end
