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

        insert_into_file "app/controllers/groundworkdocs_controller.rb", "layout 'groundworkdocs'\n\n", :after => "class GroundworkdocsController < ApplicationController\n"

        if Rails::VERSION::MAJOR >= 4
          rails_settings = [
                            '$root_path:      "./";',
                            '$images_path:    asset-path("images/");',
                            '$fonts_path:     "groundworkcss/";',
                            '$boxsizing_path: asset-path("groundworkcss/libs/boxsizing.htc");',
                            '$PIE_path:       asset-path("groundworkcss/libs/PIE.htc");'
                           ].join("\n")
        else
          rails_settings = [
                            '$root_path:      "/assets/";',
                            '$images_path:    asset-path("", image);',
                            '$fonts_path:     "groundworkcss/";',
                            '$boxsizing_path: asset-path("groundworkcss/libs/boxsizing.htc", javascript);',
                            '$PIE_path:       asset-path("groundworkcss/libs/PIE.htc", javascript);'
                           ].join("\n")
        end

        css_file = "app/assets/stylesheets/groundworkdocs.css.scss"
        File.open(css_file, "w") do |file|
          file.write("// GroundworkCSS 2 Documentation\n\n#{rails_settings}\n@import 'groundworkcss/groundwork';\n@import 'groundworkcss/demo/jquery.snippet';\n@import 'groundworkcss/demo/groundworkdocs';\n")
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
