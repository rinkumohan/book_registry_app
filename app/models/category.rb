class Category < ApplicationRecord

  CATEGORY_SORT = [["ID", "id"], ["Name","name"]]

  SORT_ODR = [["Ascending","ASC"],["Descending","DESC"]]

  def self.search(search)
    where("name LIKE ?", "%#{search}%")
  end
end
