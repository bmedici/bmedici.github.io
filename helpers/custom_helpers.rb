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

  def fa_icon type
    content_tag(:i, "", class: "fa fa-#{type}")
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
    elsif value = entry.first
      html << localized_block(:t_fallback, value)

    end

    # Build tags
    return html.join
  end

  def localized_block style, content
    content.to_s
    # content_tag(:div, content.to_s, class: "t #{style}")
  end

end