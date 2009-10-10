# plugins
plugin 'rspec-rails', :git => "git://github.com/dchelimsky/rspec-rails.git"
plugin 'asset_packager', :git=>"git://github.com/sbecker/asset_packager.git"
plugin 'jrails', :git=>"http://github.com/aaronchi/jrails"

# gems
gem 'erubis'
gem 'rspec'
gem 'thoughtbot-factory_girl', :lib => 'factory_girl', :source => 'http://gems.github.com'

# rake
rake 'gems:install', :sudo => true
rake 'gems:unpack',  :sudo => true
rake 'asset:packager:create_yml'

# generators
generate 'rspec'

# config
file "config/locales/pt-BR.yml", open("http://github.com/svenfuchs/rails-i18n/raw/master/rails/locale/pt-BR.yml").read

# app folders
file "app/view/layouts/application.html.erb", open("http://github.com/danielvlopes/base_app/raw/master/app/views/layouts/application.html.erb").read
file "app/helpers/application_helper.rb", open("http://github.com/danielvlopes/base_app/raw/master/app/helpers/application_helper.rb").read

# public folder
file "public/stylesheets/application.css", open("http://github.com/danielvlopes/base_app/raw/master/public/stylesheets/application.css").read
file "public/stylesheets/global.css", open("http://github.com/danielvlopes/base_app/raw/master/public/stylesheets/global.css").read
run "curl -L http://jqueryjs.googlecode.com/files/jquery-1.2.6.min.js > public/javascripts/jquery.js"
run "curl -L http://github.com/danielvlopes/base_app/raw/master/images/ua_ch.jpg > public/images/ua_ch.jpg"
run "curl -L http://github.com/danielvlopes/base_app/raw/master/images/ua_ff.jpg > public/images/ua_ff.jpg"
run "curl -L http://github.com/danielvlopes/base_app/raw/master/images/ua_ie.jpg > public/images/ua_ie.jpg"
run "curl -L http://github.com/danielvlopes/base_app/raw/master/images/ua_op.jpg > public/images/ua_op.jpg"
run "curl -L http://github.com/danielvlopes/base_app/raw/master/images/ua_sf.jpg > public/images/ua_sf.jpg"

# commands
run "rm README"
run "rm public/index.html"
run "rm public/favicon.ico"

run "touch tmp/.gitignore log/.gitignore vendor/.gitignore"
file '.gitignore', <<-END
config/database.yml
db/schema.rb
db/schema.sql
coverage/*
doc/*
log/*.log
log/*.out
log/*.pid
tmp/**/*
tmp/.*
tmp/profile*
uploads/*
vendor/**/**/doc/*
.DS_Store
.project
ssl/*
Icon?
END

git :init
git :add => '.'

# capistrano
capify! if yes?("Do you want to use Capistrano?")

puts "SUCCESS!"