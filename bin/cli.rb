puts "Input your email:"
input = gets.chomp
user = User.find_by_email(input)

puts "What do you want to do?"
puts "0. Create shortened URL"
puts "1. Visit shortened URL"

answer = gets.chomp

if answer == "0"
  puts "Type in your long url"
  url = gets.chomp
  shortcut = ShortenedUrl.create_for_user_and_long_url!(user, url)
  puts "Short url is: #{shortcut.short_url}"
  puts "Goodbye!"
else
  puts "Type in the shortened URL"
  shortcut = gets.chomp
  original_url = ShortenedUrl.find_by_short_url(shortcut)
  Visit.record_visit!(user, original_url)
  puts "Launching #{original_url.long_url}..."
  puts "Goodbye!"
  Launchy.open ( original_url.long_url )
end
exit
