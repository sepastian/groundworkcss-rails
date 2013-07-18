require 'rails/generators'

module Groundworkcss
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.join(File.dirname(__FILE__), 'templates')

      def create_example_settings
        dir = Pathname.new(Gem.loaded_specs['groundworkcss'].full_gem_path)
        file = File.join(dir, "app/assets/stylesheets/groundworkcss/_settings-rails#{Rails::VERSION::MAJOR}.scss")
        create_file "app/assets/stylesheets/_groundworkcss_settings.scss", File.read(file)
      end

      def add_assets
        insert_into_file "app/assets/javascripts/application#{detect_js_format[0]}", "#{detect_js_format[1]} require groundworkcss/libs/modernizr-2.6.2.min\n", :after => "jquery_ujs\n"
        insert_into_file "app/assets/javascripts/application#{detect_js_format[0]}", "#{detect_js_format[1]} require groundworkcss\n", :after => "groundworkcss/libs/modernizr-2.6.2.min\n"
        insert_into_file "app/assets/stylesheets/application#{detect_css_format[0]}", "@import 'groundworkcss_settings';\n", :after => "*/\n"
        insert_into_file "app/assets/stylesheets/application#{detect_css_format[0]}", "@import 'groundworkcss/groundwork';\n", :after => "@import 'groundworkcss_settings';\n"
      end

      def detect_js_format
        return ['.js.coffee', '#='] if File.exist?('app/assets/javascripts/application.js.coffee')
        return ['.js', '//='] if File.exist?('app/assets/javascripts/application.js')
      end

      def detect_css_format
        return ['.css'] if File.exist?('app/assets/stylesheets/application.css')
        return ['.css.sass'] if File.exist?('app/assets/stylesheets/application.css.sass')
        return ['.sass'] if File.exist?('app/assets/stylesheets/application.sass')
        return ['.css.scss'] if File.exist?('app/assets/stylesheets/application.css.scss')
        return ['.scss'] if File.exist?('app/assets/stylesheets/application.scss')
      end
    end
  end
end
