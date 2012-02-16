# a single prescription
p_pdf.bounding_box [h_displace, 540.0], :width => 350.0, :height => 540.0 do
  p_pdf.font "Helvetica"

  # script background
  p_pdf.bounding_box [0, 540.0], :width => 4.86.send(:in), :height => 5.5.send(:in) do
    p_pdf.line_width = 0.5
    p_pdf.stroke_color "#000000"

    p_pdf.fill_color "eeeeee"
    p_pdf.fill { p_pdf.rectangle [0, 5.5.send(:in)], 4.86.send(:in), 5.5.send(:in)}
    
    p_pdf.stroke_bounds
  end
    
  p_pdf.fill_color "000000"
  # header
  p_pdf.text_box " COUNTY OF LOS ANGELES", :at => [0, 530], :size => 7, :align => :left
  p_pdf.text_box "DEPARTMENT OF HEALTH SERVICES ", :at => [0, 530], :size => 7, :align => :right
  p_pdf.font "Times-Roman"
  p_pdf.text_box "ValleyCare", :at => [0, 532], :size => 10, :align => :center, :style => :bold_italic
  p_pdf.font "Helvetica"
  
  # ov address boxes
  p_pdf.bounding_box [0.5.send(:in), 7.1.send(:in)], :width => 1.5.send(:in), :height => 0.8.send(:in) do
    p_pdf.font "Helvetica", :size => 7, :style => :bold
    p_pdf.text "OLIVE VIEW-UCLA"
    p_pdf.text "MEDICAL CENTER"
    p_pdf.font "Helvetica", :style => :normal, :size => 7
    p_pdf.text "14445 Olive View Drive"
    p_pdf.text "Sylmar, CA 91342-1495"
    p_pdf.text "(818) 364-1555", :style => :bold
    
    p_pdf.stroke { p_pdf.rectangle [-12, 58], 6, 6 }
    
    p_pdf.text_box "X", :at => [-11.2, 57.63]
  end
  
  # mid-valley address boxes
  p_pdf.bounding_box [0.5.send(:in), 6.4.send(:in)], :width => 1.5.send(:in), :height => 0.8.send(:in) do
    p_pdf.font "Helvetica", :size => 7, :style => :bold
    p_pdf.text "MID-VALLEY COMPREHENSIVE"
    p_pdf.text "HEALTH CENTER"
    p_pdf.font "Helvetica", :style => :normal, :size => 7
    p_pdf.text "7515 Van Nuys Blvd."
    p_pdf.text "Van Nuys, CA 91405"
    p_pdf.text "(818) 947-4000", :style => :bold
    p_pdf.stroke { p_pdf.rectangle [-12, 58], 6, 6 }
  end
  
  # san-frenando address boxes
  p_pdf.bounding_box [3.0.send(:in), 7.1.send(:in)], :width => 1.5.send(:in), :height => 0.8.send(:in) do
    p_pdf.font "Helvetica", :size => 7, :style => :bold
    p_pdf.text "SAN FRENANDO"
    p_pdf.text "HELATH CENTER"
    p_pdf.font "Helvetica", :style => :normal, :size => 7
    p_pdf.text "1212 Pico Ave."
    p_pdf.text "San Frenando, CA 91340"
    p_pdf.text "(818) 837-6969", :style => :bold
    p_pdf.stroke { p_pdf.rectangle [-12, 58], 6, 6 }
  end
  
  # glendale address boxes
  p_pdf.bounding_box [3.0.send(:in), 6.4.send(:in)], :width => 1.5.send(:in), :height => 0.8.send(:in) do
    p_pdf.font "Helvetica", :size => 7, :style => :bold
    p_pdf.text "GLENDALE HEALTH CENTER"
    p_pdf.font "Helvetica", :style => :normal, :size => 7
    p_pdf.text "501 N. Glendale Avenue."
    p_pdf.text "Glendale, CA 91206"
    p_pdf.text "(818) 500-5786", :style => :bold
    p_pdf.stroke { p_pdf.rectangle [-12, 58], 6, 6 }
  end
  
  # divider bar
  p_pdf.stroke do
    p_pdf.line_width = 0.5
    p_pdf.stroke_color "#000000"
    p_pdf.horizontal_line 0, 350, :at => 412
    p_pdf.horizontal_line 0, 350, :at => 399
  end
  
  p_pdf.text_box "Los Angeles County Phramacy may dispense closest package size as approved by The Pharmacy & " +
                  "Therapeutics Committee, unless box is checked [ ] Los Angeles County Pharmacy may dispense" +
                  " generic equivalent unless box is changed and initialed [ ]",
                  :at => [1,411], :width => 350, :style => :bold, :size => 5
                  
  #script content header
  p_pdf.font "Helvetica", :size => 5, :style => :bold
  p_pdf.stroke do
    p_pdf.line_width = 0.5
    p_pdf.horizontal_line 0, 350, :at => 368
  end
  
  p_pdf.move_down(35)
  t = p_pdf.make_table([["DRUG NAME & STRENGTH", "QUANT.", "DIRECTIONS", "REFILLS"]], 
          :width => p_pdf.bounds.width, 
          :cell_style => {:height => 11, :align => :center, :padding => 2, :border_width => 0.5},
          :column_widths => [140, 35, 140]
      )
  t.draw
  
  #actual prescriptions
  p_pdf.bounding_box [0, 357.0], :width => 4.86.send(:in), :height => 213 do
    p_pdf.define_grid(:columns => 10, :rows => 7, :gutter => 0)
    # p_pdf.grid.show_all # comment out in prod
    
    # SCRIPTS
    p_pdf.font "Helvetica", :size => 10
    (0..5).each do |i|
      # drug boxes
      p_pdf.grid([0+i,0], [0+i,3]).bounding_box do
        p_pdf.stroke_bounds
        p_pdf.move_down(8)
        p_pdf.bounds.indent(4,4) do
          p_pdf.text prescriptions[i].drug, :overflow => :shrink_to_fit if prescriptions[i]
        end
      end
      
      # qty boxes
      p_pdf.grid([0+i,4], [0+i,4]).bounding_box do
        p_pdf.stroke_bounds
        p_pdf.move_down(8)
        p_pdf.bounds.indent(4,4) do
          p_pdf.text prescriptions[i].quantity, :overflow => :shrink_to_fit if prescriptions[i]
        end
      end
      
      # direction boxes
      p_pdf.grid([0+i,5], [0+i,8]).bounding_box do
        p_pdf.stroke_bounds
        p_pdf.move_down(8)
        p_pdf.bounds.indent(4,4) do
          p_pdf.text prescriptions[i].sig, :overflow => :shrink_to_fit if prescriptions[i]
        end
      end
      
      # refills boxes
      p_pdf.grid([0+i,9], [0+i,9]).bounding_box do
        p_pdf.stroke_bounds
        p_pdf.move_down(8)
        p_pdf.bounds.indent(4,4) do
          p_pdf.text prescriptions[i].refills.to_s, :overflow => :shrink_to_fit if prescriptions[i]
        end
      end
    end
    
    # Script Footer
    p_pdf.grid([6,0], [6,9]).bounding_box do
      p_pdf.stroke_bounds
      p_pdf.move_down(8)
      p_pdf.text_box "OR GENERIC EQUIVALENT", :align => :center, :size => 6, :at => [0,27]
      p_pdf.text_box "MORE THAN 6 PRESCRIPTIONS ON THIS BLANK WILL VOID THIS FORM", :align => :center, :size => 6, :at => [0,19]
      p_pdf.fill_color "000000"
      p_pdf.fill { p_pdf.rectangle [0,10], p_pdf.bounds.width, 9 }
      p_pdf.fill_color "ffffff"
      p_pdf.text_box "ALL CONTROLLED SUBSTANCES MUST BE WRITTEN ON DHS FORM HS-1012 OR HS-1013 AFTER JANUARY 1, 2005", :align => :center, :size => 6, :at => [0,7], :color => [0, 0, 0, 0]
    end
    
  end
  

end