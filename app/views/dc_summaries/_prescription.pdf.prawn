# a single prescription
p_pdf.bounding_box [h_displace, 540.0], :width => 350.0, :height => 540.0 do
  p_pdf.font "Helvetica"
  
  # header
  p_pdf.text_box "COUNTY OF LOS ANGELES", :at => [0, 530], :size => 7, :align => :left
  p_pdf.text_box "DEPARTMENT OF HEALTH SERVICES", :at => [0, 530], :size => 7, :align => :right
  p_pdf.font "Times-Roman"
  p_pdf.text_box "ValleyCare", :at => [0, 532], :size => 10, :align => :center, :style => :bold_italic
  p_pdf.font "Helvetica"
  
  # ov address boxes
  p_pdf.bounding_box [0.5.send(:in), 7.0.send(:in)], :width => 1.5.send(:in), :height => 0.8.send(:in) do
    p_pdf.font "Helvetica", :size => 8, :style => :bold
    p_pdf.text "OLIVE VIEW-UCLA"
    p_pdf.text "MEDICAL CENTER"
    p_pdf.font "Helvetica", :style => :normal, :size => 8
    p_pdf.text "14445 Olive View Drive"
    p_pdf.text "Sylmar, CA 91342-1495"
    p_pdf.text "(818) 364-1555", :style => :bold
  end
  
  # mid-valley address boxes
  p_pdf.bounding_box [0.5.send(:in), 6.2.send(:in)], :width => 1.5.send(:in), :height => 0.8.send(:in) do
    p_pdf.font "Helvetica", :size => 8, :style => :bold
    p_pdf.text "MID-VALLEY COMPREHENSIVE"
    p_pdf.text "HEALTH CENTER"
    p_pdf.font "Helvetica", :style => :normal, :size => 8
    p_pdf.text "7515 Van Nuys Blvd."
    p_pdf.text "Van Nuys, CA 91405"
    p_pdf.text "(818) 947-4000", :style => :bold
  end
  
  # san-frenando address boxes
  p_pdf.bounding_box [3.0.send(:in), 7.0.send(:in)], :width => 1.5.send(:in), :height => 0.8.send(:in) do
    p_pdf.font "Helvetica", :size => 8, :style => :bold
    p_pdf.text "SAN FRENANDO"
    p_pdf.text "HELATH CENTER"
    p_pdf.font "Helvetica", :style => :normal, :size => 8
    p_pdf.text "1212 Pico Ave."
    p_pdf.text "San Frenando, CA 91340"
    p_pdf.text "(818) 837-6969", :style => :bold
  end
  
  # glendale address boxes
  p_pdf.bounding_box [3.0.send(:in), 6.2.send(:in)], :width => 1.5.send(:in), :height => 0.8.send(:in) do
    p_pdf.font "Helvetica", :size => 8, :style => :bold
    p_pdf.text "GLENDALE HEALTH CENTER"
    p_pdf.font "Helvetica", :style => :normal, :size => 8
    p_pdf.text "501 N. Glendale Avenue."
    p_pdf.text "Glendale, CA 91206"
    p_pdf.text "(818) 500-5786", :style => :bold
  end
  
  # script background
  p_pdf.bounding_box [350.0, 540.0], :width => 5.0.send(:in), :height => 5.5.send(:in) do

  end

  prescriptions.each do |p|
    p_pdf.text p.in_medlish
  end
end