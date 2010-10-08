# -*- encoding: utf-8 -*-
module AirportMacChanger

  class Address
  
    attr_accessor :address
  
    def size
      12
    end
  
    def initialize(address = nil)
      @address = address || current
    end
  
    def current
      current_mac_str = %x{ifconfig en1 | grep ether}.gsub(/[\W]/,'').gsub('ether','')
      current_mac_int = current_mac_str.to_i(16)
    end
  
    def to_s
      str = @address.to_s(16)
      left_zeroes = "0" * (12 - str.size)
      str = left_zeroes + str
      str.gsub(/(..)/,"\\1:").gsub(/:\Z/,'')
    end
    
    def renew
      @address += 1
    end
    
    def set
      command = "sudo ifconfig en1 ether #{self}"
      system command
      sleep(1)
    end
    
    def self.reset
      address = new
      puts "Current MAC address: \t#{address}"
      address.renew
      puts "New MAC address: \t#{address}"    
      address.set
      puts "Current MAC address: \t#{new}"
    end
    
  end

  class Connection
    
    def self.disconnected
      network = current_network
      if network
        disconnect
        yield
        connect network
      else
        yield
      end
    end
    
    def self.current_network
      network = %x{/usr/sbin/networksetup -getairportnetwork Airport}.gsub('Current AirPort Network: ', '').gsub("\n",'')
      (network != 'You are not associated with an AirPort network.') && network
    end

    def self.disconnect
      print "Disconnecting Airport... "
      system "sudo /System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -z"
      sleep(10)
      if network = current_network
        puts "still connected to #{network}"
      else
        puts "OK"
      end
    end
    
    def self.connect(network)
      print "Connecting Airport to '#{network}'... "
      system "/usr/sbin/networksetup -setairportnetwork Airport #{network}"
      network = current_network
      if network
        puts "OK"
      else
        puts "Whoops, Airport not connected"
      end
    end
    
  end
  
  def self.change!
    Connection.disconnected do
      Address.reset
    end
  end

end
