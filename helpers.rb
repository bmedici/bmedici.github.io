def localized_paths_for(page)
  localized_paths = {}

  (langs).each do |locale|
    # First look to see if locale version for the page exists:
    locale_version_of_page = sitemap.resources.select do |resource|
      # Find a page that matches the same file name with only the locale portion replaced
      resource.proxied_to == page.proxied_to.gsub(".#{page.metadata[:options][:lang]}.", ".#{locale}.")
    end.first

    # If it exists, populate the localized_paths hash.
    localized_paths[locale] = locale_version_of_page.url if locale_version_of_page
  end

  localized_paths
end

# <% localized_paths_for(current_page).each do |text, path| %>
#   <%= link_to text, path %>
# <% end %>