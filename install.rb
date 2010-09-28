puts "Copying files..."

src_dir = File.join(File.dirname(__FILE__), "lib", "installed_files")

FileUtils.copy(File.join(src_dir, "controllers", "users_controller.rb"), "#{RAILS_ROOT}/app/controllers/")
FileUtils.copy(File.join(src_dir, "controllers", "user_sessions_controller.rb"), "#{RAILS_ROOT}/app/controllers/")

FileUtils.copy(File.join(src_dir, "models", "user.rb"), "#{RAILS_ROOT}/app/models/")
FileUtils.copy(File.join(src_dir, "models", "user_session.rb"), "#{RAILS_ROOT}/app/models/")

FileUtils.copy(File.join(src_dir, "views", "users/"), "#{RAILS_ROOT}/app/views/")

timestamp = Time.now.strftime('%Y%m%d%H%M%S')
FileUtils.copy(File.join(src_dir, "migrate", "create_users.rb"), "#{RAILS_ROOT}/db/migrate/#{timestamp}_create_users.rb")

puts "Files copied - installation complete!"
