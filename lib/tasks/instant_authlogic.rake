namespace :instant_authlogic do
	desc "Install controllers, models, views, migration and routes for instant_authlogic plugin"
	task :install do

		src_dir = File.join(File.dirname(__FILE__), "..", "installed_files")
		rails_dir = Rails.root

		# Create directories, if necessary
		puts "Creating directories..."
		[ 'app/controllers', 'app/models', 'app/views', 'db/migrate', 'config' ].each do |dir|
			FileUtils.makedirs(File.join(rails_dir, dir))
		end

		# Install new controllers
		puts "Installing controllers..."
		FileUtils.copy(File.join(src_dir, "controllers", "users_controller.rb"), "#{rails_dir}/app/controllers/")
		FileUtils.copy(File.join(src_dir, "controllers", "user_sessions_controller.rb"), "#{rails_dir}/app/controllers/")

		# Install new models
		puts "Installing models..."
		FileUtils.copy(File.join(src_dir, "models", "user.rb"), "#{rails_dir}/app/models/")
		FileUtils.copy(File.join(src_dir, "models", "user_session.rb"), "#{rails_dir}/app/models/")

		# Install new views
		puts "Installing views..."
		FileUtils.cp_r(File.join(src_dir, "views", "users/"), "#{rails_dir}/app/views/")
		FileUtils.cp_r(File.join(src_dir, "views", "user_sessions/"), "#{rails_dir}/app/views/")

		# Install create_users migration, and timestamp it to order migrations correctly
		puts "Installing migration..."
		timestamp = Time.now.strftime('%Y%m%d%H%M%S')
		FileUtils.copy(File.join(src_dir, "migrate", "create_users.rb"), "#{rails_dir}/db/migrate/#{timestamp}_create_users.rb")

		# Optionally overwrite application_controller.rb and routes.rb
		overwrite_application_controller = ask("Overwrite app/controllers/application_controller.rb? [y/n] ")
		if overwrite_application_controller == 'y'
			FileUtils.copy(File.join(src_dir, "controllers", "application_controller.rb"), "#{rails_dir}/app/controllers/")
		else
			# Output the file
			puts "Copy the following lines into app/controllers/application_controller.rb:"
      puts
			puts `cat #{File.join(src_dir, "controllers", "application_controller.rb")}`
      puts
		end

		overwrite_routes = ask("Overwrite config/routes.rb? [y/n] ")
		if overwrite_routes == 'y'
			FileUtils.copy(File.join(src_dir, "config", "routes.rb"), "#{rails_dir}/config/")
		else
			# Output the file
			puts "Copy the following lines into config/routes.rb:"
      puts
			puts `cat #{File.join(src_dir, "config", "routes.rb")}`
      puts
		end

		# Tell the user to require the authlogic gem in config/environment.rb
		puts "Add the following line to config/environment.rb:"
		puts "  config.gem 'authlogic', :version => '2.1.15'"
		puts

	end
end

def ask(question)
  print question
  STDIN.gets.chomp
end
