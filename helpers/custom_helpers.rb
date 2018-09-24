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

  def pdf_filename lang=::I18n.locale
#    "CV Bruno MEDICI #{Time.now.strftime('%Y%m%d')} #{lang.upcase}"
    "CV Bruno MEDICI #{lang.upcase}"
  end

  # def jobs_randomized
  #   data.jobs.shuffle
  # end

  def ldata
    data[I18n.locale]
  end

  def fa_icon type
    content_tag(:i, '', class: "fa fa-#{type}")
  end

  def nl2br(string)
    string.to_s.gsub("\n\r","<br />").gsub("\r", "").gsub("\n", "<br />")
  end

  def job_has_details(job)
    return false unless job.what.is_a?(Array)

    # Count where detail is not empty
    found = job.what.select{ |w| w.respond_to?(:detail) && w.detail}.count

    return found > 0
  end

  def localized(entry)
    loc = I18n.locale
    html = []

    # We have no translation
    if !entry.is_a? Hash
      html << localized_block(:t_notrans, entry.to_s)

    # We have a translation with many items
    elsif entry[loc].is_a?(Array)
      entry[loc].each do |line|
        html << localized_block(:t_lines, line)
      end

    # We have a siple translation
    elsif value = entry[loc]
      html << localized_block(:t_ok, value)

    # Otherwise, as it's a hash with no "loc" version, take the first one 
    else
        first = entry.reject{ |key, value| value.to_s.blank? }.first
        key, value = first
        html << localized_block(:t_fallback, value) if value

    end

    # Build tags
    return html.join
  end

  def localized_block style, content
    # content_tag(:div, content.to_s)
    # content.to_s
    if config[:debug]
      content_tag(:span, content.to_s, class: "t #{style}")
    else
      content.to_s
    end
  end

end