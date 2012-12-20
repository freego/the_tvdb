module TheTvdb
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("../../templates", __FILE__)

      desc "Creates a TheTvdb initializer and copy locale files to your application."

      def copy_initializer
        template "the_tvdb.rb", "config/initializers/the_tvdb.rb"
      end

    end
  end
end
