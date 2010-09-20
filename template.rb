def get_file(file)
  get "#{base_app_url}/#{file}", file
end

def base_app_url
  "http://github.com/danielvlopes/base_app/raw/master"
end

# bundler
# run "rm -Rf Gemfile"
# get_file "Gemfile"
# run "bundle install"

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

# other downloads
get_file "config/locales/pt-BR.yml"
get_file "app/views/layouts/application.html.erb"
get_file "app/helpers/application_helper.rb"

# public folder
run "rm -Rf public/index.html"
run "rm -Rf public/javascripts"
run "rm -Rf public/stylesheets"
run "mkdir public/javascripts public/stylesheets"

get_file "public/stylesheets/application.css"
get_file "public/stylesheets/common.css"
get_file "public/stylesheets/reset.css"

get_file "public/images/alert.png"
get_file "public/images/error.png"
get_file "public/images/notice.png"
get_file "public/images/ua_ch.jpg"
get_file "public/images/ua_ff.jpg"
get_file "public/images/ua_ie.jpg"
get_file "public/images/ua_op.jpg"
get_file "public/images/ua_sf.jpg"

get "http://github.com/rails/jquery-ujs/raw/master/src/rails.js", "public/javascripts/rails.js"

run "mkdir public/javascripts/app public/javascripts/vendor"

get_file "public/javascripts/vendor/PIE.htc"
get_file "public/javascripts/vendor/pngfix.js"
get_file "public/javascripts/vendor/jquery.placeholder.js"

# scaffold customization
run "mkdir -p lib/templates/rails/scaffold_controller"
get_file "lib/templates/rails/scaffold_controller/controller.rb"

# test
generate "rspec:install"
generate "steak"

application  <<-GENERATORS
config.generators do |g|
  g.test_framework  :rspec, :fixture => false, :views => false
  g.fixture_replacement :factory_girl, :dir => "spec/support/factories"
end
GENERATORS

# git

git :init
git :add => '.'
git :commit => '-am "Initial commit"'

puts "=================================="
puts "SUCCESS"