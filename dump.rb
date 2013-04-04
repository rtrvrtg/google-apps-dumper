#!/usr/bin/env ruby

require 'open3'
require 'fileutils'
require './config'

class EmailDumper
  
  attr_accessor :user_name, :user_password
  @ready = false
  
  def initialize(user_name, user_password)
    @user_name = user_name
    @user_password = user_password
    
    if offline_imap_exists
      create_structure
      @ready = true
    else
      puts "OfflineImap is not installed."
    end
  end
  
  def ready
    @ready
  end
  
  def run
    if ready
      `offlineimap -c #{user_name}/#{user_name}.offlineimap`
    end
  end
  
  private
  
  def create_structure
    unless File.directory? user_name
      FileUtils.mkdir user_name
    end
    
    config_file = File.join(user_name, user_name + '.offlineimap')
    if File.file? config_file
      File.unlink config_file
    end
    
    File.open(config_file, 'w') {|f| f.write(create_text) }
    puts "Created directory #{user_name} and config file #{user_name}.offlineimap"
  end
  
  def template( templateStr, values )
    outStr = templateStr.clone()
    values.keys.each { |key|
      outStr.gsub!( /:::#{key}:::/, values[ key ] )
    }
    outStr
  end
  
  def create_text
    tpl = "[general]\naccounts = :::user_name:::\n\n[Account :::user_name:::]\nlocalrepository = :::user_name:::Local\nremoterepository = :::user_name:::Remote\n\n[Repository :::user_name:::Local]\ntype = Maildir\nlocalfolders = :::current_dir:::/:::user_name:::\n\n\n[Repository :::user_name:::Remote]\ntype = Gmail\ncert_fingerprint = :::cert_fingerprint:::\nremoteuser = :::user_name:::@:::host:::\nremotepass = :::user_password:::\nnametrans = lambda x: 'INBOX.' + x"
    
    values = {
      :user_name => @user_name,
      :user_password => @user_password,
      :current_dir => File.expand_path(File.dirname(__FILE__)),
      :host => $dump_config[:host],
      :cert_fingerprint => $dump_config[:cert_fingerprint],
    }
    
    template(tpl, values)
  end
  
  def offline_imap_exists
    stdout, stderr, status = Open3.capture3("which offlineimap")
    status == 0
  end
  
end


user_name = ARGV[0]
user_password = ARGV[1]

ed = EmailDumper.new(user_name, user_password)
if ed.ready
  ed.run
end

