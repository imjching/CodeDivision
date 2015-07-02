require 'csv'
require_relative '../app/models/CongressMember'

class SunlightLegislatorsImporter
  def self.import(filename=File.dirname(__FILE__) + "/../db/data/legislators.csv")
    CongressMember.transaction do
        csv = CSV.new(File.open(filename), :headers => true, :header_converters => :symbol).map(&:to_hash)
        csv.each do |row|
            row[:gender] = row[:gender] == "M" ? "1" : "0"
            row[:phone] = row[:phone].gsub("-", "")
            row[:fax] = row[:fax].gsub("-", "")
            row[:birthdate] = row[:birthdate].gsub("/", "-")
            CongressMember.create!(row)
        end
    end
  end
end

# IF YOU WANT TO HAVE THIS FILE RUN ON ITS OWN AND NOT BE IN THE RAKEFILE, UNCOMMENT THE BELOW
# AND RUN THIS FILE FROM THE COMMAND LINE WITH THE PROPER ARGUMENT.
# begin
#   raise ArgumentError, "you must supply a filename argument" unless ARGV.length == 1
#   SunlightLegislatorsImporter.import(ARGV[0])
# rescue ArgumentError => e
#   $stderr.puts "Usage: ruby sunlight_legislators_importer.rb <filename>"
# rescue NotImplementedError => e
#   $stderr.puts "You shouldn't be running this until you've modified it with your implementation!"
# end