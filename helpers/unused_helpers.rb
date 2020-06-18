# module UnusedHelpers

#   def t_title object
#     return unless object.repond_to? :title
#     object.title
#   end

#   def link_to_locale(text, target, lang=::I18n.locale)
#     url = extensions[:i18n].localized_path(target, lang)
#     url ? super(text, url) : super(text, target)
#   end

#   def get_content(page = current_page)
#     # if page.data.layout == 'orbit'
#     page.render({layout: :orbit})
#   end

#   def pdf_for(pagename)
#     page = sitemap.find_resource_by_path(pagename)
#     pdf_for_debug pagename, "found: #{page.class}"
#     pdf_for_debug pagename, "url: #{page.url}"

#     html = get_content(page)
#     pdf_for_debug pagename, "html: #{html.bytesize}"

#     kit = ::PDFKit.new(html)
#     # kit = ::PDFKit.new('<html><body>HELLO</body></html>')
#     pdf = kit.to_pdf
#     pdf_for_debug pagename, "pdf: #{pdf.bytesize}"

#     return pdf
#   end

#   def pdf_for_debug(pagename, message)   
#     puts "pdf_for [#{pagename}] #{message}"
#   end

# end