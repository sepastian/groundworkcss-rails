Setup assets and create boilerplate layout for GroundworkCSS
==============================================================

`rails g groundworkcss:install`

Inserts required lines into application manifest files:
  /app/assets/javascripts/application.{js,coffee}
  /app/assets/stylesheets/application.{css,scss}

Creates boilerplate layout:
  /app/views/layouts/application.html.erb

Creates Groundwork settings file:
  /app/assets/stylesheets/_groudnwork_settings.scss


Add GroundworkCSS documentation files (great for testing, too)
--------------------------------------------------------------

`rails g groundworkcss:docs`

Creates required files, controller and configures routes to 
Groundwork documenation pages in your rails app (great for 
offline use and testing).
