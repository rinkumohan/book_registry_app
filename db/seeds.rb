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
