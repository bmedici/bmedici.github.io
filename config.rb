# require 'makepdf'
require 'middleman-pdfkit'


# Activate debug if DEBUG is a non-zero integer
set :debug, !ENV['DEBUG'].to_i.zero?

# For custom domains on github pages
page "CNAME", layout: false

# Turn this on if you want to make your url's prettier, without the .html
# activate :directory_indexes

# Automatic image dimensions on image_tag helper
activate :automatic_image_sizes
# activate :directory_indexes
activate :i18n, :mount_at_root => :fr

activate :s3_sync do |s3_sync|
  s3_sync.bucket                = 's3.bmconseil.com'
  s3_sync.region                = 'eu-west-3'
  s3_sync.aws_access_key_id     = '***REMOVED***'
  s3_sync.aws_secret_access_key = '***REMOVED***'
  s3_sync.path_style            = true
end

activate :sprockets do |c|
  # c.expose_middleman_helpers = true
end


# Easier bootstrap navbars
# activate :bootstrap_navbar do |bootstrap_navbar|
#   bootstrap_navbar.bootstrap_version = '4.0.0'
# end

# Assumes the file source/about/template.html.erb exists
# ["tom", "dick", "harry"].each do |name|
#   proxy "/about/#{name}.html", "/about/template.html", :locals => { :person_name => name }
# end

# activate :blog do |blog|
#   blog.prefix = 'posts'
#   blog.permalink = ':title'
#   blog.default_extension = '.md'
#   blog.layout = 'post'
#   blog.paginate = true
# end

# Time.zone = 'Paris'

###
# Compass
###

# Change Compass configuration
# compass_config do |config|
#   config.output_style = :compact
# end

###
# Page options, layouts, aliases and proxies
###

# Per-page layout changes:
#
# With no layout
# page "/path/to/file.html", :layout => false
#
# With alternative layout
# page "/path/to/file.html", :layout => :otherlayout
#
# A path which all have the same layout
# with_layout :admin do
#   page "/admin/*"
# end

# Proxy pages (https://middlemanapp.com/advanced/dynamic_pages/)
# proxy "/this-page-has-no-template.html", "/template-file.html", :locals => {
#  :which_fake_page => "Rendering a fake page with a local variable" }

###
# Helpers
###

# Automatic image dimensions on image_tag helper
# activate :automatic_image_sizes

# Reload the browser automatically whenever files change
configure :development do
  activate :livereload
end

# Deploy
# activate :deploy do |deploy|
#   deploy.deploy_method = :git
#   # deploy.deploy_method = :rsync
#   # deploy.host          = 'www.example.com'
#   # deploy.path          = '/srv/www/site'
#   # Optional Settings
#   # deploy.user  = 'tvaughan' # no default
#   # deploy.port  = 5309 # ssh port, default: 22
#   # deploy.clean = true # remove orphaned files on remote host, default: false
#   # deploy.flags = '-rltgoDvzO --no-p --del' # add custom flags, default: -avz
# end

# Methods defined in the helpers block are available in templates
# helpers do
#   def some_helper
#     "Helping"
#   end
# end

set :css_dir, 'stylesheets'

set :js_dir, 'javascripts'

set :images_dir, 'images'

# Build-specific configuration
configure :build do
  # For example, change the Compass output style for deployment
  # activate :minify_css

  # Minify Javascript on build
  # activate :minify_javascript

  # Enable cache buster
  activate :asset_hash

  # Use relative URLs
  activate :relative_assets

  # Sprockets
  activate :sprockets

  # Build PDF files
  activate :pdfkit do |p|
    p.filenames = ['cv-bruno-medici-fr', 'cv-bruno-medici-en']
    # p.disable_smart_shrinking = true
    # p.quiet = false
    # p.page_size = 'A5'
    p.margin_top = 10
    p.margin_right = 10
    p.margin_bottom = 10
    p.margin_left = 10
    # p.encoding = 'UTF-8'
  end

  # Or use a different image path
  # set :http_prefix, "/Content/images/"
end

# This will push to the gh-pages branch of the repo, which will
# host it on github pages (If this is a github repository)
# activate :deploy do |deploy|
#   deploy.method = :git
#   deploy.build_before = true
# end


helpers do
  def t_title object
    return unless object.repond_to? :title
    object.title
  end
end
