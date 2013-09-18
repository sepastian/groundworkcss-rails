require 'rails/generators'

module Groundworkcss
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.join(File.dirname(__FILE__), 'templates')

      def create_settings_file
        dir = Pathname.new(Gem.loaded_specs['groundworkcss'].full_gem_path)
        file = File.join(dir, "app/assets/stylesheets/groundworkcss/_settings-rails#{Rails::VERSION::MAJOR}.scss")
        create_file "app/assets/stylesheets/_groundwork_settings.scss", File.read(file)
      end

      def add_assets
        js_file = "app/assets/javascripts/application#{detect_js_format[0]}"
        css_file = "app/assets/stylesheets/application#{detect_css_format[0]}"

        if File.exists?(js_file)
          insert_into_file js_file, "#{detect_js_format[1]} require groundworkcss/libs/modernizr-2.6.2.min\n", :after => "jquery_ujs\n"
          insert_into_file js_file, "#{detect_js_format[1]} require groundworkcss/all\n", :after => "groundworkcss/libs/modernizr-2.6.2.min\n"
        else
          puts 'Cannot locate "application.js" or "application(.js).coffee" manifest file for writing...'
          puts 'You will need to add the following to your javascript manifest file manually:\n\n//= require groundworkcss/libs/modernizr-2.6.2.min\n//= require groundworkcss/all'
        end

        if File.exists?(css_file)
          insert_into_file css_file, "@import 'groundwork_settings';\n", :after => "*/\n"
          insert_into_file css_file, "@import 'groundworkcss/groundwork';\n", :after => "@import 'groundwork_settings';\n"
          if detect_css_format[0] == '.css'
            puts "Renaming #{css_file} to #{css_file}.scss (to enable Sass partial includes)..."
            File.rename(css_file, css_file + '.scss')
          end
        else
          puts 'Cannot locate "application.css", "application(.css).scss" or "application(.css).sass" manifest file for writing...'
          puts 'You will need to add the following to your stylesheet manifest file manually:\n\n@import \'groundwork_settings\';\n@import \'groundworkcss/groundwork\';'
        end
      end

      def detect_js_format
        return ['.js', '//='] if File.exist?('app/assets/javascripts/application.js')
        return ['.js.coffee', '#='] if File.exist?('app/assets/javascripts/application.js.coffee')
        return ['.coffee', '#='] if File.exist?('app/assets/javascripts/application.coffee')
        return ['', '']
      end

      def detect_css_format
        return ['.css'] if File.exist?('app/assets/stylesheets/application.css')
        return ['.css.sass'] if File.exist?('app/assets/stylesheets/application.css.sass')
        return ['.css.scss'] if File.exist?('app/assets/stylesheets/application.css.scss')
        return ['.sass'] if File.exist?('app/assets/stylesheets/application.sass')
        return ['.scss'] if File.exist?('app/assets/stylesheets/application.scss')
        return ['']
      end
    end
  end
end
