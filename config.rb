# Middleman configuration
set :layout,      :orbit
set :css_dir,     'stylesheets'
set :js_dir,      'javascripts'
set :images_dir,  'images'
set :relative_links, false
# Time.zone = 'Paris'


# Activate debug if DEBUG is a non-zero integer
set :debug,       !ENV['DEBUG'].to_i.zero?
set :image_box,   "150x35"


# Blank site ?
set :blank,       false
if !ENV['BLANK'].to_i.zero?
  set :build_dir, 'build/full'
  set :blank,       true
end


# Sitemap
page "sitemap.xml", :layout => false


# For custom domains on github pages
page "CNAME",      layout: false


# Turn this on if you want to make your url's prettier, without the .html
activate :directory_indexes


# Automatic image dimensions on image_tag helper
activate :automatic_image_sizes
activate :middleman_simple_thumbnailer, use_specs: true


# Localization and meta tags
activate :i18n, :mount_at_root => :en, path: "/"
activate :meta_tags


# S3 sync
activate :s3_sync do |s3_sync|
  s3_sync.bucket                = 's3.bmconseil.com'
  s3_sync.region                = 'eu-west-3'
  s3_sync.aws_access_key_id     = '***REMOVED***'
  s3_sync.aws_secret_access_key = '***REMOVED***'
  s3_sync.path_style            = true
  s3_sync.reduced_redundancy_storage = true
  s3_sync.version_bucket             = false
  s3_sync.index_document             = 'index.html'
  s3_sync.error_document             = '404.html'
  # s3_sync.content_types = true
  # s3.prefer_gzip                = true
end
default_caching_policy max_age: 60


# Asset pipeline
activate :sprockets do |c|
  # c.expose_middleman_helpers = true
end


# Reload the browser automatically whenever files change
configure :development do
  activate :livereload
end


# Easier bootstrap navbars
activate :bootstrap_navbar do |bootstrap_navbar|
  # bootstrap_navbar.bootstrap_version = '4.0.0'
end


# Build-specific configuration
configure :build do
  # For example, change the Compass output style for deployment
  activate :minify_css

  # Minify Javascript on build
  activate :minify_javascript

  # Minify HTML on build
  activate :minify_html

  # Enable cache buster
  # activate :asset_hash

  # Ignore original files
  ignore 'stylesheets/application/*.css'  
  ignore 'javascripts/application/*.css'  

  # Use relative URLs
  activate :relative_assets

  # Build PDF files
  activate :pdfkit do |p|
    p.filenames = {
      'cv-bruno-medici-fr/index' => 'cv-bruno-medici-fr.pdf',
      'cv-bruno-medici-en/index' => 'cv-bruno-medici-en.pdf',
     }
    # p.filenames = ['cv-bruno-medici-fr/index', 'cv-bruno-medici-en/index']
    p.disable_smart_shrinking = true
    p.quiet = false
    p.page_size = 'A4'
    p.margin_top = 10
    p.margin_right = 10
    p.margin_bottom = 10
    p.margin_left = 10
    # p.page_width = 3000
    # p.dpi = 10
    # p.print_media_type = true
    # p.page_width = '169.33'
    # p.page_height = '95.25'
    # p.encoding = 'UTF-8'
  end

  # activate :favicon_maker, :icons => {
  #     "_favicon_template.png" => [
  #       { icon: "apple-touch-icon-152x152-precomposed.png" },
  #       { icon: "apple-touch-icon-114x114-precomposed.png" },
  #       { icon: "apple-touch-icon-72x72-precomposed.png" },
  #     ]
  #   }
end


# after_build do |builder|
#      FileUtils.mv(Dir['build/templates/*'],'build/', {:force => true})
#      FileUtils.mv(Dir['build/translations/*'],'build/', {:force => true})
#      FileUtils.rm_rf('build/templates')
#      FileUtils.rm_rf('build/translations')
# end

# config.middleware.use PDFKit::Middleware, {}, :only => %r[^/public]


# activate :blog do |blog|
#   blog.prefix = 'posts'
#   blog.permalink = ':title'
#   blog.default_extension = '.md'
#   blog.layout = 'post'
#   blog.paginate = true
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

helpers do
end
