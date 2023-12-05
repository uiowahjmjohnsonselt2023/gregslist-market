# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).


# db/seeds.rb
admin = User.create!(
  name: 'Admin User',
  username: 'admin',
  email: 'admin@example.com',
  password_digest: BCrypt::Password.create('password'),
  admin: true
)

roy = User.create!(
  name: 'Roy', 
  username: 'roy',
  email: 'roy@example.com',
  password_digest: BCrypt::Password.create('password'),
  admin: false
)

admin_seller = Seller.create!(
  name: 'Admin Seller',
  description: 'This is the admin seller',
  address: '123 Admin Street',
  users: [admin]
)

roy_seller = Seller.create!(
  name: 'Roy Seller',
  description: 'This is the roy seller',
  address: '123 Roy Street',
  users: [roy]
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
    categories: [Electronics]
  },
  {
    name: 'Computer Desk',
    description: 'A desk for your computer',
    seller_id: admin_seller.id,
    listing_date: Date.today,
    listed_price: 100.00,
    categories: [Home]
  },
  {
    name: 'Pepsi',
    description: 'A can of Pepsi',
    seller_id: admin_seller.id,
    listing_date: Date.today,
    listed_price: 1.00,
    categories: [Food]
  },
  {
    name: 'Backpack',
    description: 'A backpack for your school supplies',
    seller_id: admin_seller.id,
    listing_date: Date.today,
    listed_price: 53.55,
    categories: [Office]
  }
])