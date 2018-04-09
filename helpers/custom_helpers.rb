module CustomHelpers

  def test
    "testing123"
  end

  def ldata
    data[I18n.locale]
  end

  def localized(entry)
    loc = I18n.locale

    if !entry.is_a? Hash
      return content_tag(:span, entry.to_s, style: 'color: blue')

    elsif value = entry[loc]
      return content_tag(:span, value, style: 'color: green')

    elsif value = entry.first
      return content_tag(:span, value, style: 'color: orange')

    end

  end

end