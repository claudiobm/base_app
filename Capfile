require 'bundler/capistrano'

load 'deploy' if respond_to?(:namespace) # cap2 differentiator
Dir['vendor/plugins/*/recipes/*.rb'].each { |plugin| load(plugin) }
load 'config/deploy'

Dir['config/recipes/*.rb'].each { |recipe| load(recipe) }
