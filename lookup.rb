def get_command_line_argument

  if ARGV.empty?
    puts "Usage: ruby lookup.rb <domain>"
    exit
  end
  ARGV.first

end

domain = get_command_line_argument

dns_raw = File.readlines("zone")


def parse_dns(dns_raw)
  dns_raw = dns_raw.map(&:strip).delete_if { |string| string.length == 0 }
  dns_raw=dns_raw[1..-1]
  values=Array.new(5) {Array.new(3) }
  rows=[]
  for i in 0..4
    rows=dns_raw[i].strip.split(",")
    for j in 0..2
      values[i][j]=rows[j].strip
    end
  end
 dns_records=[]
 values.each { |record| dns_records << {'type' => record[0], 'domain' => record[1], 'target' =>   record[2]} }
 return dns_records
end

def resolve(dns_records, lookup_chain, domain)

end

# To complete the assignment, implement `parse_dns` and `resolve`.
# Remember to implement them above this line since in Ruby
# you can invoke a function only after it is defined.


dns_records = parse_dns(dns_raw)
puts dns_records
lookup_chain = [domain]
lookup_chain = resolve(dns_records, lookup_chain, domain)
#puts lookup_chain.join(" => ")
