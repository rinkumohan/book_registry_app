class Book < ApplicationRecord
  belongs_to :user
  belongs_to :category

  scope :published, -> { where("publish_status is true") }

  validates :book_name, :author, :price,:category,:isbn, :presence => true
  validates :price, :numericality => { greater_than_or_equal_to: 0}
  validates :isbn, format: { with: /\A\d+\z/, message: "must be a number. String and special characters are not allowed." }

  BOOK_SORT = [["Name","book_name"],["Author","author"],["Isbn","isbn"],["price","price"],["Category","category"],["Publish Status","publish_status"]]

  SORT_ODR = [["Ascending","ASC"],["Descending","DESC"]]

  def publish_book
    update_attributes(:publish_status => true)
  end

  def unpublish_book
    update_attributes(:publish_status => false)
  end

  def self.search(search)
    joins(:category).where("book_name LIKE ? or author LIKE ? or isbn LIKE ? or categories.name LIKE ?", "%#{search}%","%#{search}%","%#{search}%","%#{search}%")
  end
end
