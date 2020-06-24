require "capistrano/setup"
require "capistrano/deploy"
require "capistrano/rbenv"
require "capistrano/bundler"
require "capistrano/rails/assets"
require "capistrano/rails/migrations"

# taskを記述したファイルを読み込むように設定。 場所、拡張子の指定
Dir.glob("lib/capistrano/tasks/*.rb").each { |r| import r }
