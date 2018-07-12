module CustomHelpers

  def test
    "testing123"
  end

  def jobs_sorted
    data.jobs.sort_by{|k,v| k}.reverse
  end

  def ldata
    data[I18n.locale]
  end

  def localized(entry)
    loc = I18n.locale
    html = []

    # We have no translation
    if !entry.is_a? Hash
      html << localized_block(:blue, entry.to_s)

    # We have a translation with many items
    elsif entry[loc].is_a?(Array)
      entry[loc].each do |line|
        html << localized_block(:YELLOWGREEN, line)
      end

    # We have a siple translation
    elsif value = entry[loc]
      html << localized_block(:green, value)

    # Otherwise, as it's a hash with no "loc" version, take the first one 
    elsif value = entry.first
      html << localized_block(:orange, value)

    end

    # Build tags
    return html.join
  end

  def localized_block color, content
    content_tag(:div, content.to_s, style: "color: #{color}")
  end

end