GroundworkCSS 2 Rails Gem
====


Add GroundworkCSS to your rails project.


Inside your Gemfile add the following lines:

```ruby
gem 'autoprefixer-rails'
gem 'compass-rails'
gem 'groundworkcss'
```

Note, you will need to have therubyracer enabled in order to support Coffeescript. Ensure that this line is uncommented in your Gemfile:

```ruby
gem 'therubyracer', :platforms => :ruby
```

Then run `bundle install` to install the gem.

**Note from @sepastian** For Rails 4.1, just use the 'compass-rails' gem, which now officially supports Rails 4.1. (Previously, `groundworkcss/compass-rails` must be used.) This is probably true for Rails 4.x, too - can anyone verify this?

## Include GroundworkCSS in your manifest file(s):

If you want to include Groundwork on all of your pages then run the following generator to include it in your application sprockets files:

```bash
$ bundle exec rails generate groundworkcss:install
```

**Note:** This will automatically rename `application.css` to `application.scss`, if necessary, to enable Sass compilation.

Alternately, you can manually include groundwork on individual pages/layouts:

```html
<link rel="stylesheet" href="<%= asset_path('groundworkcss/groundwork.css') %>" />
<script type="text/javascript" src="<%= asset_path('groundworkcss/libs/modernizr-2.6.2.min.js') %>"></script>
<script type="text/javascript" src="<%= asset_path('groundworkcss/libs/jquery-1.10.2.min.js') %>"></script>
<script type="text/javascript" src="<%= asset_path('groundworkcss/all.js') %>"></script>
```

Or you can include groundwork manually in javascript and stylesheet manifest files:

**in application.js**

```javascript
//= require jquery
//= require "groundworkcss/libs/modernizr-2.6.2.min"
//= require "groundworkcss/all"
```

**in application.scss**

```scss
@import 'groundworkcss/settings-rails4'; // or 'settings-rails3'
@import "groundworkcss/groundwork";
```

## Include the GroundworkCSS docs pages:

If you want to include the GroundworkCSS docs pages in the rails development environment (comes in handy for quick reference and testing installation) then run the following generator (after running the install generator):

```bash
$ bundle exec rails generate groundworkcss:docs
```

### Advanced

Alternatively, you may selectively choose which Groundwork modules to be included in your stylesheet and javascript manifest files:

**in application.scss**

```scss
@import "groundworkcss/core/all-core";             // required
@import "groundworkcss/base/all-base";             // required
@import "groundworkcss/icons/all-icons";           // required
@import "groundworkcss/type/all-type";             // recommended
@import "groundworkcss/ui/all-ui";                 // optional
@import "groundworkcss/anim/all-animations";       // optional
@import "groundworkcss/responsive/all-responsive"; // recommended
```

Expert users may be even more selective, however, it is best to control this level of optimization with the configurations in `_groundwork_settings.scss` as there are several complex dependancy chains that must be understood. Two modules that this can be easily done, however, are `ui` and `anim`.

```scss
@import "groundworkcss/core/all-core";             // required
@import "groundworkcss/base/all-base";             // required
@import "groundworkcss/icons/all-icons";           // required
@import "groundworkcss/type/all-type";             // recommended

// UI Components
@import "groundworkcss/ui/boxes";                  // optional
@import "groundworkcss/ui/buttons";                // optional
@import "groundworkcss/ui/forms";                  // optional
@import "groundworkcss/ui/messages";               // optional
@import "groundworkcss/ui/nav";                    // optional
@import "groundworkcss/ui/tables";                 // optional
@import "groundworkcss/ui/tabs";                   // optional

// Animations
@import "groundworkcss/anim/bounce";               // optional
@import "groundworkcss/anim/fade";                 // optional
@import "groundworkcss/anim/flash";                // optional
@import "groundworkcss/anim/flip";                 // optional
@import "groundworkcss/anim/hinge";                // optional
@import "groundworkcss/anim/lightspeed";           // optional
@import "groundworkcss/anim/pulse";                // optional
@import "groundworkcss/anim/roll";                 // optional
@import "groundworkcss/anim/rotate";               // optional
@import "groundworkcss/anim/shake";                // optional
@import "groundworkcss/anim/spin";                 // optional
@import "groundworkcss/anim/swing";                // optional
@import "groundworkcss/anim/tada";                 // optional
@import "groundworkcss/anim/wiggle";               // optional
@import "groundworkcss/anim/wobble";               // optional

@import "groundworkcss/responsive/all-responsive"; // recommended
```

**in application.js**

```javascript
//= require "groundworkcss/jquery-placeholderText"
//= require "groundworkcss/jquery-responsiveTables"
//= require "groundworkcss/jquery-responsiveText"
//= require "groundworkcss/jquery-truncateLines"
//= require "groundworkcss/checklists"
//= require "groundworkcss/dismissible"
//= require "groundworkcss/equalizeColumns"
//= require "groundworkcss/forms"
//= require "groundworkcss/menus"
//= require "groundworkcss/navigation"
//= require "groundworkcss/tabs"
```

### Setup your layout with the GroundworkCSS boilerplate

Add the following to the `<head>` section in your layout file (i.e. `app/views/layouts/application.html.erb`)

```html
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
  <meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1" />
  <%= stylesheet_link_tag("application", :media => "screen") %>
  <!--[if IE]>
  <link type="text/css" rel="stylesheet" href="/assets/groundworkcss/groundwork-ie.css">
  <![endif]-->
  <%= javascript_include_tag("application") %>
```


# Using GroundworkCSS in production

Before pushing your application to production, you'll need to determine how you want your assets served.  You can either compile them on-the-fly or precompile them (recommended).  Before continuing you'll want to check your Rails application Gemfile and ensure that `gem 'groundworkcss'` is included in the `assets` group.

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
* jquery-rails (~> 3)
* autoprefixer-rails (~> 0.7)
