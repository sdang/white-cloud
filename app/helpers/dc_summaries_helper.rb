module DcSummariesHelper
  def import_buttons(prefix)
    html = ""
    html += button_tag "import from signout", :class => "button white small", :id => "#{prefix}-import-signout"
    html += " "
    html += button_tag "import from last d/c summary", :class => "button white small", :id => "#{prefix}-import-dc-summary"
    html += "<div id='#{prefix}-import-error' class='hidden alert'></div><div id='#{prefix}-import-notice' class='hidden notice'></div>"
    return html.html_safe
  end
  
  def req_field
    return "<span class='required'>*</span> ".html_safe
  end
end
