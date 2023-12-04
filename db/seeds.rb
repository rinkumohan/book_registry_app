# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

if ActiveRecord::Base.connection.table_exists? 'users'
  if User.all.blank?
    ActiveRecord::Base.connection.execute 'ALTER TABLE users AUTO_INCREMENT = 1;'
    user = User.new(
          :email                 => "rinku@lub.com",
          :password              => "123456",
          :password_confirmation => "123456"
      )
      user.save!
   end
end

if ActiveRecord::Base.connection.table_exists? 'categories'
  if Category.all.blank?
    ActiveRecord::Base.connection.execute 'ALTER TABLE categories AUTO_INCREMENT = 1;'
      categories = ['Adventure stories',
                    'Classics',
                    'Crime',
                    'Fairy tales',
                    'Fantasy',
                    'Historical fiction',
                    'Horror',
                    'Humour and satire',
                    'Literary fiction',
                    'Mystery',
                    'Poetry',
                    'Plays',
                    'Romance',
                    'Science fiction',
                    'Short stories',
                    'Thrillers',
                    'War',
                    'Women’s fiction',
                    'Young adult']

    categories.each do |category|
      Category.find_or_create_by(name: category)
    end
  end
end

if ActiveRecord::Base.connection.table_exists? 'books'
  if Book.all.blank?
    ActiveRecord::Base.connection.execute 'ALTER TABLE books AUTO_INCREMENT = 1;'
      user_id = User.last.id
      books = [ { book_name: 'Wings of Fire', author: 'Dr. Abdul Kalam', isbn: 3462774627, price: 30,
                 category_id: 1, user_id: user_id, available_count: 10 },
                { book_name: 'Pride and Prejudice', author: 'Jane Austen', isbn: 9780141439518, price: 25, category_id: 2, user_id: user_id, available_count: 17 },
                { book_name: 'The Girl with the Dragon Tattoo', author: 'Stieg Larsson', isbn: 9780307454546, price: 35, category_id: 3, user_id: user_id, available_count: 16 },
                { book_name: 'Alice in Wonderland', author: 'Lewis Carroll', isbn: 9780141439761, price: 20, category_id: 4, user_id: user_id, available_count: 22 },
                { book_name: 'The Hobbit', author: 'J.R.R. Tolkien', isbn: 9780547928227, price: 40, category_id: 5, user_id: user_id, available_count: 17 },
                { book_name: 'To Kill a Mockingbird', author: 'Harper Lee', isbn: 9780061120084, price: 28, category_id: 6, user_id: user_id, available_count: 14 },
                { book_name: 'Frankenstein', author: 'Mary Shelley', isbn: 9780486282114, price: 32, category_id: 7, user_id: user_id, available_count: 25 },
                { book_name: 'Catch-22', author: 'Joseph Heller', isbn: 9780684833392, price: 36, category_id: 8, user_id: user_id, available_count: 13 },
                { book_name: '1984', author: 'George Orwell', isbn: 9780451524935, price: 30, category_id: 9, user_id: user_id, available_count: 16 },
                { book_name: 'The Maltese Falcon', author: 'Dashiell Hammett', isbn: 9780679722649, price: 22, category_id: 10, user_id: user_id, available_count: 20 },
                { book_name: 'The Raven', author: 'Edgar Allan Poe', isbn: 9781480015069, price: 18, category_id: 11, user_id: user_id, available_count: 21 },
                { book_name: 'Romeo and Juliet', author: 'William Shakespeare', isbn: 9780743477116, price: 24, category_id: 12, user_id: user_id, available_count: 30 },
                { book_name: 'Pride and Prejudice', author: 'Jane Austen', isbn: 9780141439518, price: 25, category_id: 13, user_id: user_id, available_count: 12 },
                { book_name: 'Dune', author: 'Frank Herbert', isbn: 9780441172719, price: 38, category_id: 14, user_id: user_id, available_count: 32 },
                { book_name: 'The Tell-Tale Heart', author: 'Edgar Allan Poe', isbn: 9780679722649, price: 18, category_id: 15, user_id: user_id, available_count: 22 },
                { book_name: 'The Da Vinci Code', author: 'Dan Brown', isbn: 9780307474278, price: 42, category_id: 16, user_id: user_id, available_count: 13 },
                { book_name: 'War and Peace', author: 'Leo Tolstoy', isbn: 9781400079988, price: 45, category_id: 17, user_id: user_id, available_count: 36 },
                { book_name: 'Little Women', author: 'Louisa May Alcott', isbn: 9780147514011, price: 26, category_id: 18, user_id: user_id, available_count: 30 },
                { book_name: 'Harry Potter and the Sorcerer\'s Stone', author: 'J.K. Rowling', isbn: 9780590353403, price: 34, category_id: 19, user_id: user_id, available_count: 42 }
              ]

    books.each do |book|
      Book.create(book)
    end
  end
end
