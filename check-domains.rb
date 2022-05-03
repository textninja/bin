require 'resolv'

domains = ENV["MY_DOMAINS"].split(",")

max_length = domains.reduce(0) { |l,d| [l,d.length].max } + 4
dns_resolver = Resolv::DNS.new
domains.each do |domain|
  ip = dns_resolver.getaddress(domain) rescue nil
  www_ip = dns_resolver.getaddress("www.#{domain}") rescue nil
  www_domain = "www.#{domain}"
  puts "#{domain.rjust(max_length)} #{ip}"
  puts "#{www_domain.rjust(max_length)} #{www_ip}" if www_ip != ip
end
