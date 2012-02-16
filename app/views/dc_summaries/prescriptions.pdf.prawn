# how many scripts do we need?
num_scripts = (@dc_summary.prescriptions.size/6.0).ceil

(1..num_scripts).each do |i|
  # decide if this is the first or second prescription
  if i%2 == 0
    h_displace = 370
  else
    h_displace = 0
  end
  
  pdf.start_new_page if i.odd? and i > 2
  pdf.stroke do
    pdf.line_width = 1
    pdf.stroke_color "bbbbbb"
    pdf.vertical_line -35, 600, :at => 360
  end
  
  render :partial => "prescription",
      :locals => { :p_pdf => pdf, :h_displace => h_displace, :prescriptions => @dc_summary.prescriptions[(i-1)*6..(i-1)*6+5] }
end