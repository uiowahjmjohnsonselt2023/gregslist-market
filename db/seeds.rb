# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

# db/seeds.rb
admin = User.create!(
  name: 'Admin User',
  username: 'admin',
  email: 'admin@example.com',
  password_digest: BCrypt::Password.create('password'),
  admin: true,
  activated: true,
  activated_at: Time.zone.now
)

roy = User.create!(
  name: 'Roy',
  username: 'roy',
  email: 'roy@example.com',
  password_digest: BCrypt::Password.create('password'),
  admin: false,
  activated: true,
  activated_at: Time.zone.now
)

admin_seller = Seller.create!(
  name: 'Admin Seller',
  description: 'This is the admin seller',
  address: '123 Admin Street',
)

roy_seller = Seller.create!(
  name: 'Roy Seller',
  description: 'This is the roy seller',
  address: '123 Roy Street',
)

admin.seller << admin_seller
roy.seller << roy_seller

Electronics = Category.create!(name: 'Electronics')
Cosmetics = Category.create!(name: 'Cosmetics and Body Care')
Food = Category.create!(name: 'Food and Beverages')
Home = Category.create!(name: 'Furniture and Home Appliances')
Health = Category.create!(name: 'Health and Wellness')
Books = Category.create!(name: 'Books and Media')
Office = Category.create!(name: 'Office and School Supplies')
Clothing = Category.create!(name: 'Clothing and Accessories')
Toys = Category.create!(name: 'Toys and Games')
Pets = Category.create!(name: 'Pets and Pet Supplies')
Sports = Category.create!(name: 'Sports and Outdoors')
Automotive = Category.create!(name: 'Automotive')
Others = Category.create!(name: 'Others')

Item.create!([
               {
                 name: 'Apple iPhone 12 Pro Max',
                 description: 'The biggest iPhone you can buy',
                 seller_id: admin_seller.id,
                 listing_date: Date.today,
                 listed_price: 499.99,
                 categories: [Electronics],
                 image: File.open(Rails.root.join('app', 'assets', 'images', 'electronics.png'))
               },
               {
                 name: 'Computer Desk',
                 description: 'A desk for your computer',
                 seller_id: admin_seller.id,
                 listing_date: Date.today,
                 listed_price: 100.00,
                 categories: [Home],
                 image: File.open(Rails.root.join('app', 'assets', 'images', 'home.png'))
               },
               {
                 name: 'Pepsi',
                 description: 'A can of Pepsi',
                 seller_id: admin_seller.id,
                 listing_date: Date.today,
                 listed_price: 1.00,
                 categories: [Food],
                 image: File.open(Rails.root.join('app', 'assets', 'images', 'food.png'))
               },
               {
                 name: 'Backpack',
                 description: 'A backpack for your school supplies',
                 seller_id: admin_seller.id,
                 listing_date: Date.today,
                 listed_price: 53.55,
                 categories: [Office],
                 image: File.open(Rails.root.join('app', 'assets', 'images', 'office.png'))
               },
               {
                 name: 'Nike Air Max',
                 description: 'A pair of Nike Air Max',
                 seller_id: admin_seller.id,
                 listing_date: Date.today,
                 listed_price: 150.00,
                 categories: [Clothing],
                 image: File.open(Rails.root.join('app', 'assets', 'images', 'clothing.png'))
               },
               {
                 name: 'Lego Star Wars',
                 description: 'A Lego Star Wars set',
                 seller_id: admin_seller.id,
                 listing_date: Date.today,
                 listed_price: 100.00,
                 categories: [Toys],
                 image: File.open(Rails.root.join('app', 'assets', 'images', 'toy.png'))
               },
               {
                 name: 'Dog Food',
                 description: 'A bag of dog food',
                 seller_id: admin_seller.id,
                 listing_date: Date.today,
                 listed_price: 20.00,
                 categories: [Pets],
                 image: File.open(Rails.root.join('app', 'assets', 'images', 'pet.png'))
               },
               {
                 name: 'Basketball',
                 description: 'A basketball',
                 seller_id: admin_seller.id,
                 listing_date: Date.today,
                 listed_price: 20.00,
                 categories: [Sports],
                 image: File.open(Rails.root.join('app', 'assets', 'images', 'sports.png'))
               },
               {
                 name: 'Car Battery',
                 description: 'A car battery',
                 seller_id: admin_seller.id,
                 listing_date: Date.today,
                 listed_price: 100.00,
                 categories: [Automotive],
                 image: File.open(Rails.root.join('app', 'assets', 'images', 'car.png'))
               }
             ])

Item.create!([
               {
                 name: 'Face Mask',
                 description: 'A face mask',
                 seller_id: roy_seller.id,
                 listing_date: Date.today,
                 listed_price: 10.00,
                 categories: [Cosmetics],
                 image: File.open(Rails.root.join('app', 'assets', 'images', 'body.png'))
               },
               {
                 name: 'Gone with the Wind',
                 description: 'A book',
                 seller_id: roy_seller.id,
                 listing_date: Date.today,
                 listed_price: 10.00,
                 categories: [Books],
                 image: File.open(Rails.root.join('app', 'assets', 'images', 'books.png'))
               },
               {
                 name: '2009 Used Car',
                 description: 'A used car',
                 seller_id: roy_seller.id,
                 listing_date: Date.today,
                 listed_price: 2999.99,
                 categories: [Automotive],
                 image: File.open(Rails.root.join('app', 'assets', 'images', 'car.png'))
               },
               {
                 name: 'T-Shirt',
                 description: 'A t-shirt',
                 seller_id: roy_seller.id,
                 listing_date: Date.today,
                 listed_price: 10.00,
                 categories: [Clothing],
                 image: File.open(Rails.root.join('app', 'assets', 'images', 'clothing.png'))
               },
               {
                 name: 'Wireless Mouse',
                 description: 'A wireless mouse',
                 seller_id: roy_seller.id,
                 listing_date: Date.today,
                 listed_price: 10.00,
                 categories: [Electronics],
                 image: File.open(Rails.root.join('app', 'assets', 'images', 'electronics.png'))
               },
               {
                 name: 'Dog Toy',
                 description: 'A dog toy',
                 seller_id: roy_seller.id,
                 listing_date: Date.today,
                 listed_price: 10.00,
                 categories: [Pets],
                 image: File.open(Rails.root.join('app', 'assets', 'images', 'pet.png'))
               },
               {
                 name: 'Pencil',
                 description: 'A pencil',
                 seller_id: roy_seller.id,
                 listing_date: Date.today,
                 listed_price: 2.99,
                 categories: [Office],
                 image: File.open(Rails.root.join('app', 'assets', 'images', 'office.png'))
               },
               {
                 name: 'A Whole Chicken',
                 description: 'A whole chicken',
                 seller_id: roy_seller.id,
                 listing_date: Date.today,
                 listed_price: 10.00,
                 categories: [Food],
                 image: File.open(Rails.root.join('app', 'assets', 'images', 'food.png'))
               },
               {
                 name: 'Sofa',
                 description: 'A sofa',
                 seller_id: roy_seller.id,
                 listing_date: Date.today,
                 listed_price: 100.00,
                 categories: [Home],
                 image: File.open(Rails.root.join('app', 'assets', 'images', 'home.png'))
               },
               {
                 name: 'Call of Duty Modern Warfare 2',
                 description: 'A video game',
                 seller_id: roy_seller.id,
                 listing_date: Date.today,
                 listed_price: 10.00,
                 categories: [Toys],
                 image: File.open(Rails.root.join('app', 'assets', 'images', 'toy.png'))
               },
               {
                 name: 'Vitamin C',
                 description: 'A bottle of vitamin C',
                 seller_id: roy_seller.id,
                 listing_date: Date.today,
                 listed_price: 10.00,
                 categories: [Health],
                 image: File.open(Rails.root.join('app', 'assets', 'images', 'wellness.png'))
               },
               {
                 name: "Time-traveler's Pocket Watch",
                 description: 'A pocket watch that can travel through time',
                 seller_id: roy_seller.id,
                 listing_date: Date.today,
                 listed_price: 4.53,
                 categories: [Others],
                 image: File.open(Rails.root.join('app', 'assets', 'images', 'other.png'))
               }
             ])
