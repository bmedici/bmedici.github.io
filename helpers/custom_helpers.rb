module CustomHelpers

  def jobs_sorted
    data.jobs.sort_by{|k,v| k}.reverse
  end

  def jobs_collection
    data.jobs.sort_by{|k,v| k}.reverse.collect do |key, job|
      job_enriched(key, job)
    end
  end

  def job_enriched key, job
    year, name = key.split('_')
    job.name = name
    job.year = year
    job
  end

#   def pdf_filename lang=::I18n.locale
# #    "CV Bruno MEDICI #{Time.now.strftime('%Y%m%d')} #{lang.upcase}"
#     "cv-bruno-medici-#{lang.upcase}"
#   end

def cv_name stamp = nil, lang = nil
  stamp ||= Time.now.strftime('%Y%m%d')
  lang ||= ::I18n.locale
  # "cv-bruno-medici-#{stamp}-#{lang.downcase}"
  "CV Bruno MEDICI #{stamp} #{lang.upcase}"
end

def cv_filename stamp = nil, lang = nil
  "cv/#{cv_name(stamp, lang)}.pdf"
end

  def ldata
    data[I18n.locale]
  end

  def fa_icon type, title="", extra_styles = ""
    content_tag(:i, '', class: "fa fa-#{type} #{extra_styles}", title: title)
  end

  def nl2br(string)
    string.to_s.gsub("\n\r","<br />").gsub("\r", "").gsub("\n", "<br />")
  end

  def job_has_any_details(job)
    return false unless 
    details = []

    # Parse job and collect all task details
    job.tasks.collect do |task|
      task.details.each do |detail|
        details << localized(detail)
      end if task.details.is_a?(Array)
    end if job.tasks.is_a?(Array)

    # Keep only text details that are not nil
    return details.reject(&:nil?).any?
  end


  def localized(entry)
    # Let's determine the key name
    key = I18n.locale

    # We have no structured data > take it as-is
    if entry.is_a?(String)
      return localized_block(:t_notrans, entry)
    end

    # From now on, it should be a hash
    return nil unless entry.is_a?(Hash)

    # We have a translation with many items
    if entry[key].is_a?(Array)
      html = []
      entry[key].each do |line|
        html << localized_block(:t_lines, line)
      end
      return html.join
    end

    # We have a siple translation
    if value = entry[key]
      return localized_block(:t_ok, value)
    end

    # Otherwise, as it's a hash with no "key" version, take the first one
    first = entry.reject{ |key, value| value.to_s.blank? }.first
    key, value = first
    return localized_block(:t_fallback, value) if value
  end

  def localized_block style, content
    return content.to_s unless config[:debug]
    return content_tag(:span, content.to_s, class: "t #{style}")
  end

  def current_page?(path)
    current_page.url.chomp('/') == path.chomp('/')
  end

  def menu_item title, icon, path
    # klass = :active if current_page?(path)

    klass = :active if current_page?(path)

    content_tag(:li, class: klass) do
      out = []
      out << fa_icon(icon) if icon
      out << title
      link_to out.join(" ".html_safe), path
    end

  end

end