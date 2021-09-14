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
 h= Hash[values.map { |key,value1,value2| [value1,{:type=>key,:target=>value2}]}]
 end

def resolve(dns_records, lookup_chain, domain)
  record= dns_records[domain]
  if (!record)
    err= "Error: Record not found for #{domain}"
    lookup_chain =[err]
    return lookup_chain
  elsif record[:type] == "CNAME"
    lookup_chain<<record[:target]
    resolve(dns_records,lookup_chain,record[:target])
  elsif record[:type] == "A"
    return lookup_chain<<record[:target]
  end
end

# To complete the assignment, implement `parse_dns` and `resolve`.
# Remember to implement them above this line since in Ruby
# you can invoke a function only after it is defined.

dns_records = parse_dns(dns_raw)
lookup_chain = [domain]
lookup_chain = resolve(dns_records, lookup_chain, domain)
puts lookup_chain.join(" => ")
