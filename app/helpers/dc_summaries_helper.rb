module DcSummariesHelper
  def import_buttons(prefix, dc_summary_id)
    html = ""
    # html += button_tag "import from signout", :class => "button white small", :id => "#{prefix}-import-signout"
    # html += " "
    html += "<div id='#{prefix}-import-error' class='hidden alert'></div><div id='#{prefix}-import-notice' class='hidden notice'></div>"
    html += link_to "import from last d/c summary", url_for(:controller => "/dc_summaries", :action => "import_handler", :prefix => prefix, :from => "dc", :id => dc_summary_id), :class => "btn btn-mini", :remote => true, :id => "#{prefix}-import-dc-summary"
    return html.html_safe
  end
end
