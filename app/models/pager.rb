require 'net/http'
require 'rexml/document'
include REXML

class Pager

  def self.send_page(msg,pn) 
    begin
      # American Messaging WCTP URL
      target_url = ENV['WCTP_URL']
      url = URI.parse(target_url)
      request = Net::HTTP::Post.new(url.path)
    
      # generate XMl request
      xml_request = Pager.create_xml_single(msg,pn)
      request.body = xml_request
    
      # send request
      if ENV['use_proxy']
      	response = Net::HTTP::Proxy(ENV['proxy_url'], ENV['proxy_port'], ENV['proxy_username'], ENV['proxy_password']).start(url.host, url.port) {|http| http.request(request)}
      else
      	response = Net::HTTP.start(url.host, url.port) {|http| http.request(request)}
      end
    
      succeeded = false
      doc = Document.new response.body
      if doc.root.elements["wctp-Confirmation"].elements["wctp-Success"]
        status_code = 200 
        status_message = "Message accepted by wctp.amsmsg.net"
        succeeded = true
      else
        status_code = doc.root.elements["wctp-Confirmation"].elements["wctp-Failure"].attributes["errorCode"]
        status_message = doc.root.elements["wctp-Confirmation"].elements["wctp-Failure"].attributes["errorText"]
        logger.warn "unable to page #{pn}, error: #{status_message} (#{status_code})"
      end
    
      return succeeded
    rescue
      logger.fatal "crash when attempting to page #{pn}"
      return false
    end
  end
  
  def self.create_xml_single(msg,pager)
    doc = Document.new '<!DOCTYPE wctp-Operation 
         SYSTEM "http://wctp.myairmail.com/wctp-dtd-v1r1.dtd">'
    wctp_operation = doc.add_element 'wctp-Operation', {"wctpVersion" => "wctp-dtd-v1r1"}
    wctp_submitrequest = wctp_operation.add_element 'wctp-SubmitRequest'
    wctp_submitheader = wctp_submitrequest.add_element 'wctp-SubmitHeader', {"submitTimeStamp" => Time.now.strftime("%Y-%m-%dT%H:%M:%S")}
    wctp_submitheader.add_element 'wctp-Originator', {"senderID" => ENV['WCTP_USERNAME'], "securityCode"=> ENV['WCTP_PASSWORD']}
    wctp_submitheader.add_element 'wctp-MessageControl', {"messageID"=>Time.now.strftime("%s")}
    wctp_submitheader.add_element 'wctp-Recipient', {"recipientID"=>pager}
    wctp_payload = wctp_submitrequest.add_element 'wctp-Payload'
    wctp_alphanumeric = wctp_payload.add_element 'wctp-Alphanumeric'
    wctp_alphanumeric.text = msg
    doc << XMLDecl.new("1.0","UTF-8")

    return doc.to_s
  end
  
end