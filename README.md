GroundworkCSS Rails Gem
====


Add GroundworkCSS to your rails project.


Inside your Gemfile add the following lines:

```ruby
group :assets do
  gem 'compass-rails'
  gem 'groundworkcss'
end
```

Also, if not already done, you will need to enable therubyracer to support coffeescript. Uncomment this line in your Gemfile:
```
gem 'therubyracer', :platforms => :ruby
```

Rails 4
----

@ghepting: I've noticed that `compass-rails` doesn't propertly support Rails 4 yet, so I've been using the edge version of @milgner's fork, which seems to work well. Use at your own risk.

```ruby
gem 'compass-rails', github: 'milgner/compass-rails', ref: '1749c06f15dc4b058427e7969810457213647fb8'
```

Then run `bundle install` to install the gem.

## And then?

If you want to include GroundworkCSS on all of your pages then run the following to append `groundworkcss` to your application sprockets files:

```bash
bundle exec rails g groundworkcss:install
```

You can also manually include `groundworkcss` on individual pages:

```ruby
stylesheet_link_tag "groundworkcss"
javascript_include_tag "groundworkcss"
```

You can add `require "groundworkcss"` to your javascripts sprockets file(s):

**in application.js**  

```javascript
//= require "groundworkcss"
```

### Advanced

Alternatively, you may be more selective about which modules to use and can selectively add stylesheets and javascripts to your project:

**in application.css**

```css
@import "groundworkcss/groundwork/core/all-core";
@import "groundworkcss/groundwork/base/all-base";
@import "groundworkcss/groundwork/type/all-type";
```

**in application.js**

```javascript
//= require "groundworkcss/jquery-responsiveText"
//= require "groundworkcss/jquery.cycle2"
//= require "groundworkcss/jquery.magnific-popup"
```

### Setup your layout with the Groundwork boilerplate

Add the following to the `<head>` section in your layout file (i.e. `app/views/layouts/application.html.erb`)

```html
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
  <meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1" />
  <%= stylesheet_link_tag("application", :media => "screen") %>
  <!--[if IE]>
  <link type="text/css" rel="stylesheet" href="/assets/groundworkcss/groundwork-ie.css">
  <![endif]-->
  <!--[if IE 7]>
  <link type="text/css" rel="stylesheet" href="/assets/groundworkcss/font-awesome-ie7.min.css">
  <![endif]-->
  <%= javascript_include_tag("application") %>
  <script type="text/javascript">
    // SVG support?
    Modernizr.load({
      test: Modernizr.inlinesvg,
      yep: [
        "/assets/groundworkcss/social-icons-svg.css"
      ],
      nope: [
        "/assets/groundworkcss/social-icons-png.css",
        "/assets/sidereel-ie/svg-to-png.js"
      ]
    });
    // HTML5 placeholder support?
    Modernizr.load({
      test: Modernizr.input.placeholder,
      nope: [
        '/assets/groundworkcss/placeholder_polyfill.css',
        '/assets/groundworkcss/libs/placeholder_polyfill.jquery.js'
      ]
    });
  </script>
```


# Using GroundworkCSS in production

Before pushing your application to production, you'll need to determine how you want your assets served.  You can either compile them on-the-fly or precompile them (recommended).  Before continuing you'll want to check your Rails application Gemfile and ensure that `gem 'groundworkcss', :git => 'git://github.com/groundworkcss/groundworkcss-rails.git'` is included in the `assets` group.

## To compile on-the-fly

In your Rails application edit `config/application.rb` and change:

```ruby
Bundler.require(*Rails.groups(:assets => %w(development test)))
```

to:

```ruby
Bundler.require(:default, :assets, Rails.env)
```

Then in `config/environments/production.rb` make sure the following setting exists:

```ruby
config.assets.compile = true
```

Assets will be compiled on the first visits to your site, which can cause a delay.

## To precompile assets using Capistrano

In your Rails application edit `Capfile` and add the following line after `load 'deploy'`:

```ruby
load 'deploy/assets'
```

Now when you run `cap deploy` the `deploy:assets:precompile` task will be run which takes care of running `bundle exec rake assets:precompile` for you.

By default assets that are precompiled will be located in the `public/assets/` folder of your application.


# Dependencies
* compass-rails (~> 1)
* rails (~> 3.1)
* jquery-rails (~> 1.0)
