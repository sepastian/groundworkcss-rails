require 'rails/generators'

module GroundworkCSS
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.join(File.dirname(__FILE__), 'templates')

      def add_assets
        insert_into_file "app/assets/javascripts/application#{detect_js_format[0]}", "#{detect_js_format[1]} require groundworkcss\n", :after => "jquery_ujs\n"
        insert_into_file "app/assets/stylesheets/application#{detect_css_format[0]}", "#{detect_css_format[1]} require groundworkcss\n", :after => "require_self\n"              
      end

      def detect_js_format
        return ['.js.coffee', '#='] if File.exist?('app/assets/javascripts/application.js.coffee')
        return ['.js', '//='] if File.exist?('app/assets/javascripts/application.js')
      end

      def detect_css_format
        return ['.css', ' *='] if File.exist?('app/assets/stylesheets/application.css')
        return ['.css.sass', ' //='] if File.exist?('app/assets/stylesheets/application.css.sass')
        return ['.sass', ' //='] if File.exist?('app/assets/stylesheets/application.sass')
        return ['.css.scss', ' //='] if File.exist?('app/assets/stylesheets/application.css.scss')
        return ['.scss', ' //='] if File.exist?('app/assets/stylesheets/application.scss')
      end
    end
  end
end
