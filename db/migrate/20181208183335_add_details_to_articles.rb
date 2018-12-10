class AddDetailsToArticles < ActiveRecord::Migration[5.2]
  def change
    add_column :articles, :url, :string
    add_column :articles, :title, :string
    add_column :articles, :image, :string
    add_column :articles, :description, :text
    add_column :articles, :site_name, :string
    add_column :articles, :updated_time, :integer
  end
end
