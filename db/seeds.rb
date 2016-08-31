# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


User.destroy_all
sennacy = User.create!(email: "sennacy@gmail.com")
tommy = User.create!(email: "tommy@gmail.com")
luna = User.create!(email: "luna@gmail.com")

ShortenedUrl.destroy_all
link1 = ShortenedUrl.create_for_user_and_long_url!(User.find_by_email('sennacy@gmail.com'), 'http://www.testing13989.com')
link2 = ShortenedUrl.create_for_user_and_long_url!(User.find_by_email('luna@gmail.com'), 'http://www.anothertest.com')
link3 = ShortenedUrl.create_for_user_and_long_url!(User.find_by_email('luna@gmail.com'), 'http://www.news.google.com')



Visit.destroy_all
  Visit.record_visit!(User.first, ShortenedUrl.first)
  Visit.record_visit!(User.last, ShortenedUrl.first)
