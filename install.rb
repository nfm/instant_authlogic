puts "Copying files..."

src_dir = File.join(File.dirname(__FILE__), "lib", "installed_files")
rails_dir = Rails.root

# Create directories, if necessary
[ 'app/controllers', 'app/models', 'app/views', 'db/migrate', 'config' ].each do |dir|
	FileUtils.makedirs(File.join(rails_dir, dir))
end

# Install new controllers
FileUtils.copy(File.join(src_dir, "controllers", "users_controller.rb"), "#{rails_dir}/app/controllers/")
FileUtils.copy(File.join(src_dir, "controllers", "user_sessions_controller.rb"), "#{rails_dir}/app/controllers/")

# Install new models
FileUtils.copy(File.join(src_dir, "models", "user.rb"), "#{rails_dir}/app/models/")
FileUtils.copy(File.join(src_dir, "models", "user_session.rb"), "#{rails_dir}/app/models/")

# Install new views
FileUtils.cp_r(File.join(src_dir, "views", "users/"), "#{rails_dir}/app/views/")

# Install create_users migration, and timestamp it to order migrations correctly
timestamp = Time.now.strftime('%Y%m%d%H%M%S')
FileUtils.copy(File.join(src_dir, "migrate", "create_users.rb"), "#{rails_dir}/db/migrate/#{timestamp}_create_users.rb")

# Optionally overwrite application_controller.rb and routes.rb
puts "Overwrite app/controllers/application_controller.rb? [y/n]"
overwrite_application_controller = gets.chomp
if overwrite_application_controller == 'y'
  FileUtils.copy(File.join(src_dir, "controllers", "application_controller.rb"), "#{rails_dir}/app/controllers/")
else
  # Output the file
  puts "Copy the following lines into app/controllers/application_controller.rb:"
  `cat #{File.join(src_dir, "controllers", "application_controller.rb")}`
end

puts "Overwrite config/routes.rb [y/n]"
overwrite_routes = gets.chomp
if overwrite_routes == 'y'
  FileUtils.copy(File.join(src_dir, "config", "routes.rb"), "#{rails_dir}/config/")
else
  # Output the file
  puts "Copy the following lines into config/routes.rb:"
  `cat #{File.join(src_dir, "config", "routes.rb")}`
end
