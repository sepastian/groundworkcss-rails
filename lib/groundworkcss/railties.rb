module GroundworkCSS
  class Railtie < Rails::Railtie
    initializer "groundworkcss.configure_compass" do
      images_path = Pathname.new(Gem.loaded_specs['groundworkcss'].full_gem_path).join('vendor/assets/images/groundworkcss')
      Rails.application.config.compass.images_path = images_path
    end
  end
end
