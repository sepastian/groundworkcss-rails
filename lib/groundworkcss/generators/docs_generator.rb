require 'rails/generators'

module Groundworkcss
  module Generators
    class DocsGenerator < Rails::Generators::Base
      source_root File.join(File.dirname(__FILE__), 'templates')

      def create_docs
        dir = Pathname.new(Gem.loaded_specs['groundworkcss'].full_gem_path)

        layoutpath = "app/views/layouts/"
        layout = File.join(dir, "#{layoutpath}groundworkdocs.html.erb")
        copy_file layout, "#{layoutpath}#{File.basename(layout)}", :force => true

        generator_command = "rails generate controller groundworkdocs"

        viewpath = "app/views/groundworkdocs/"
        pages = File.join(dir, "#{viewpath}*.html.erb")
        Dir.glob(pages) do |page|
          generator_command << " #{File.basename(page, ".html.erb")}"
        end

        run generator_command

        #routes_file = "config/routes.rb"
        #insert_into_file routes_file, "\n  if Rails.env.development?\n", :before => "  get \"groundworkdocs/animations\"\n"
        #insert_into_file routes_file, "\n  end\n\n", :after => "  get \"groundworkdocs/typography\"\n"
        #content = ''
        #File.open(routes_file, "r") do |file|
          #file.each_line do |line|
            #if line.include? "groundworkdocs/"
              #content << '    ' + line.lstrip
            #else
              #content << line
            #end
          #end
        #end
        #File.open(routes_file, "w") do |file|
          #file.write(content)
        #end

        insert_into_file "app/controllers/groundworkdocs_controller.rb", "layout 'groundworkdocs'\n\n", :after => "class GroundworkdocsController < ApplicationController\n"

        css_file = "app/assets/stylesheets/groundworkdocs.css.scss"
        File.open(css_file, "w") do |file|
          file.write("// GroundworkCSS 2 Documentation\n\n@import 'groundwork_settings';\n@import 'groundworkcss/groundwork';\n@import 'groundworkcss/demo/jquery.snippet';\n@import 'groundworkcss/demo/groundworkdocs';\n")
        end

        js_file = "app/assets/javascripts/groundworkdocs.js.coffee"
        File.open(js_file, "w") do |file|
          file.write("# GroundworkCSS 2 Documentation\n\n#= require 'groundworkcss/libs/modernizr-2.6.2.min'\n#= require 'groundworkcss/libs/jquery-1.10.2.min'\n#= require 'groundworkcss/all'\n#= require 'groundworkcss/demo/jquery.snippet.min'\n")
        end

        Dir.glob(pages) do |page|
          copy_file page, "#{viewpath}#{File.basename(page)}", :force => true
        end
      end

    end
  end
end
