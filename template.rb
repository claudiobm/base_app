def get_file(file)
  get "#{base_app_url}/#{file}", file
end

def base_app_url
  "https://github.com/claudiobm/base_app/raw/master"
end

# bundler
get_file 'Gemfile'
run 'bundle install'

# capistrano
get_file "Capfile"
get_file "config/deploy.rb"

run "mkdir -p config/deploy/templates"

get_file "config/deploy/templates/database.yml.erb"
get_file "config/deploy/templates/hoptoad.rb.erb"
get_file "config/deploy/templates/maintenance.html.erb"
get_file "config/deploy/templates/newrelic.yml.erb"
get_file "config/deploy/templates/smtp.rb.erb"

run "mkdir -p config/deploy/recipes"

get_file "config/deploy/recipes/log.rb"
get_file "config/deploy/recipes/setup.rb"
get_file "config/deploy/recipes/passenger.rb"
get_file "config/deploy/recipes/maintenance.rb"

# libs helper
get_file "lib/array_helper.rb"
get_file "lib/string_helper.rb"
get_file "lib/slugify.rb"

# other downloads
get_file "config/locales/pt-BR.yml"
get_file "app/views/layouts/application.html.erb"
get_file "app/helpers/application_helper.rb"

run "mkdir -p app/views/shared"
get_file "app/views/shared/_error_messages.html.erb"

# public folder
run "rm -Rf public/index.html"
run "rm -Rf public/javascripts"
run "rm -Rf public/stylesheets"
run "mkdir -p public/javascripts public/stylesheets public/stylesheets/jquery-ui/humanity/images"

get_file "public/stylesheets/application.css"
get_file "public/stylesheets/common.css"
get_file "public/stylesheets/reset.css"
get_file "public/stylesheets/jquery-ui/humanity/jquery-ui.css"

get_file "public/stylesheets/jquery-ui/humanity/images/ui-bg_flat_75_aaaaaa_40x100.png"
get_file "public/stylesheets/jquery-ui/humanity/images/ui-bg_glass_100_f5f0e5_1x400.png"
get_file "public/stylesheets/jquery-ui/humanity/images/ui-bg_glass_25_cb842e_1x400.png"
get_file "public/stylesheets/jquery-ui/humanity/images/ui-bg_glass_70_ede4d4_1x400.png"
get_file "public/stylesheets/jquery-ui/humanity/images/ui-bg_highlight-hard_100_f4f0ec_1x100.png"
get_file "public/stylesheets/jquery-ui/humanity/images/ui-bg_highlight-hard_65_fee4bd_1x100.png"
get_file "public/stylesheets/jquery-ui/humanity/images/ui-bg_highlight-hard_75_f5f5b5_1x100.png"
get_file "public/stylesheets/jquery-ui/humanity/images/ui-bg_inset-soft_100_f4f0ec_1x100.png"
get_file "public/stylesheets/jquery-ui/humanity/images/ui-icons_c47a23_256x240.png"
get_file "public/stylesheets/jquery-ui/humanity/images/ui-icons_cb672b_256x240.png"
get_file "public/stylesheets/jquery-ui/humanity/images/ui-icons_f08000_256x240.png"
get_file "public/stylesheets/jquery-ui/humanity/images/ui-icons_f35f07_256x240.png"
get_file "public/stylesheets/jquery-ui/humanity/images/ui-icons_ff7519_256x240.png"
get_file "public/stylesheets/jquery-ui/humanity/images/ui-icons_ffffff_256x240.png"

get_file "public/images/alert.png"
get_file "public/images/error.png"
get_file "public/images/notice.png"
get_file "public/images/ua_ch.jpg"
get_file "public/images/ua_ff.jpg"
get_file "public/images/ua_ie.jpg"
get_file "public/images/ua_op.jpg"
get_file "public/images/ua_sf.jpg"

get "https://github.com/rails/jquery-ujs/raw/master/src/rails.js", "public/javascripts/rails.js"

run "mkdir public/javascripts/app public/javascripts/common"

get_file "public/javascripts/common/PIE.htc"
get_file "public/javascripts/common/pngfix.js"
get_file "public/javascripts/common/jquery.placeholder.js"
get_file "public/javascripts/common/jquery.no-conflict.js"
get_file "public/javascripts/common/jquery-ui.js"
run "curl http://code.jquery.com/jquery.min.js public/javascripts/common/jquery.js"

# scaffold customization
run "mkdir -p lib/templates/rails/scaffold_controller"
get_file "lib/templates/rails/scaffold_controller/controller.rb"

# test
generate "rspec:install"
generate "steak"

get_file "spec/acceptance/support/helpers.rb"

# devise
generate 'devise:install'
generate 'devise User'
generate 'devise:views'

inject_into_file "app/models/user.rb", "\n:confirmable, ", :after => ":registerable,"

devise_migration = Dir.glob("db/migrate/*_devise_create_users.rb").to_s
inject_into_file devise_migration, "\nt.confirmable\n", :before => "t.timestamps"


application <<-GENERATORS
config.generators do |g|
  g.test_framework  :rspec, :fixture => false, :views => false
  g.fixture_replacement :factory_girl, :dir => "spec/support/factories"
end

config.action_mailer.default_url_options = { :host => "localhost:3000" }

GENERATORS

# git

git :init
git :add => '.'
git :commit => '-am "Initial commit"'

puts "=================================="
puts "SUCCESS"
