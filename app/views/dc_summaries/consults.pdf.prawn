@dc_summary.consults.each do |consult|
  pdf.start_new_page unless consult == @dc_summary.consults.first
  
  # header
  pdf.text_box "COUNTY OF LOS ANGELES", :size => 7, :align => :left
  pdf.text_box "DEPARTMENT OF HEALTH SERVICES", :size => 7, :align => :right
  
  pdf.text_box "OLIVE VIEW-UCLA MEDICAL CENTER", :at => [0, pdf.bounds.top - 10], :size => 9, :align => :center
  pdf.text_box "CONSULTATION REQUEST", :at => [0, pdf.bounds.top - 25], :size => 12, :align => :center
  
  pdf.define_grid(:columns => 15, :rows => 19, :gutter => 0)
  # pdf.grid.show_all
  

  pdf.stroke do
    pdf.line_width = 0.5
  end

  # to  
  pdf.grid([3,0], [3,4]).bounding_box do
        pdf.stroke { pdf.horizontal_line 0, pdf.bounds.width, :at => 0 }
        pdf.stroke { pdf.horizontal_line 0, pdf.bounds.width, :at => pdf.bounds.height }
        pdf.move_down(5)
        pdf.text "TO:", :size => 7
        pdf.text_box consult.service.decrypt(session[:group_password]), :at => [15,pdf.bounds.height], :width => pdf.bounds.width-15, :height => pdf.bounds.height, :overflow => :shrink_to_fit, :valign => :center, :align => :left
  end

  # requested by
  pdf.grid([3,5], [3,10]).bounding_box do
    pdf.move_down(5)
    pdf.text "REQUESTED BY: #{current_user.name}", :size => 7, :indent_paragraphs => 5
    pdf.move_down(8)
    pdf.text "WARD: #{consult.dc_summary.service || 'Internal Medicine'}", :size => 7, :indent_paragraphs => 5
    pdf.stroke_bounds
  end
  
  # position
  pdf.grid([3,11], [3,14]).bounding_box do
    pdf.stroke { pdf.horizontal_line 0, pdf.bounds.width, :at => 0 }
    pdf.stroke { pdf.horizontal_line 0, pdf.bounds.width, :at => pdf.bounds.height }
    pdf.move_down(8)
    pdf.text_box "POSITION:", :size => 7, :at => [5,pdf.bounds.top-5]
    pdf.text_box "DATE: #{Time.now.strftime("%m-%d-%Y")}", :size => 7, :at => [5,10]
  end
  
  # reason
  pdf.grid([4,0],[7,14]).bounding_box do
    pdf.move_down(5)
    pdf.text "REASON FOR REQUEST (INCLUDE DETAILS OF RELEVANT STUDIES ORDERED AND PRESENT MEDICATIONS)", :size => 7
    pdf.text_box "PROVISIONAL DIAGNOSIS:", :at => [0,10], :size => 7
    pdf.stroke { pdf.horizontal_line 0, pdf.bounds.width, :at => 0 }
    pdf.text_box consult.reason_for_yellow(session[:group_password]), :at => [15, pdf.bounds.height-20], :width => pdf.bounds.width-15, :height => pdf.bounds.height-40, :overflow => :shrink_to_fit
  end
  
  # Evaluate
  pdf.grid([8,0],[8,8]).bounding_box do
    pdf.text_box "EVALUATE ONLY", :size => 7, :at => [0,pdf.bounds.height-5]
    pdf.text_box "EVALUATE & TREAT   X", :size => 7, :at => [150,pdf.bounds.height-5]
    pdf.text_box "CONTACT ME AFTER SEEING PATIENTS AT THIS PHONE", :size => 7, :at => [0,10]
    pdf.stroke { pdf.vertical_line 0, pdf.bounds.height, :at => pdf.bounds.width }
    pdf.stroke { pdf.horizontal_line 0, pdf.bounds.width, :at => 0 }
  end
  
  # Priority
  pdf.grid([8,9], [8,14]).bounding_box do
    pdf.text_box "PRIORITY:", :size => 7, :at => [5, pdf.bounds.height-5]
    pdf.move_down(20)
    pdf.text consult.priority, :size => 10, :align => :center
    pdf.stroke { pdf.horizontal_line 0, pdf.bounds.width, :at => 0 }
  end
  
  # Signed
  pdf.grid([9,0],[9,7]).bounding_box do
    pdf.text_box "SIGNED: ", :size => 7, :at => [0, 10]
    pdf.stroke { pdf.horizontal_line 36, 252, :at => 5 }
    pdf.text_box "M.D. ", :size => 7, :at => [255, 10]
    pdf.fill_color "aaaaaa"
    pdf.text_box current_user.name, :size => 12, :at => [36, 20], :height => 20, :overflow => :shrink_to_fit, :width => 180
    pdf.fill_color "000000"
    pdf.stroke { pdf.horizontal_line 0, pdf.bounds.width, :at => 0 }
    pdf.stroke { pdf.vertical_line 0, pdf.bounds.height, :at => pdf.bounds.width }
  end
  
  # Date of Clinic Appointment
  pdf.grid([9,8],[9,14]).bounding_box do
    pdf.text_box "DATE OF CLINIC APPOINTMENT: ", :size => 7, :at => [10, pdf.bounds.top-5]
    pdf.stroke { pdf.horizontal_line 10, pdf.bounds.width, :at => 5 }
    pdf.stroke { pdf.horizontal_line 0, pdf.bounds.width, :at => 0 }
    pdf.text_box consult.appointment_time.strftime("%m-%d-%Y %l:%M%p"), :size => 12, :at => [36, 20], :height => 20, :overflow => :shrink_to_fit, :width => 180 if consult.appointment_time
  end
  
  
  # MRN Box
  pdf.grid([15,9],[17,14]).bounding_box do
    pdf.stroke { pdf.rounded_rectangle [0, pdf.bounds.height], pdf.bounds.width, pdf.bounds.height, 10 }
    pdf.move_down(5)
    pdf.text "PATIENT DATA - Imprint or Print Legibly", :size => 7, :align => :center
    pdf.move_down(15)
    pdf.text "Name: #{consult.dc_summary.patient_name(session[:group_password])}", :indent_paragraphs => 10, :size => 10, :leading => 5
    pdf.text "MRN: #{consult.dc_summary.mrn}", :indent_paragraphs => 10, :size => 10, :leading => 5
    pdf.text "Date of Birth: #{consult.dc_summary.dob.strftime("%m-%d-%Y")}", :indent_paragraphs => 10, :size => 10, :leading => 5
  end
  
  pdf.move_down(20)
  pdf.text "CONSULTATION REQUEST", :align => :right
end