# Loop every word input
sql_query = "INSERT INTO words (name, sorted_name, created_at, updated_at) VALUES "
n = 0
d = 0
ActiveRecord::Base.transaction do
  File.readlines('words').each do |line|
    word = line.chomp
    sql_query << "('#{word}', '#{word.downcase.split(//).sort.join}', now(), now()),"
    n += 1
    if n >= 1000
      d += 1
      print "#{d}."
      ActiveRecord::Base.connection.execute(sql_query[0, sql_query.length - 1] << ";")
      sql_query = "INSERT INTO words (name, sorted_name, created_at, updated_at) VALUES "
      n = 0
    end
  end
  ActiveRecord::Base.connection.execute(sql_query[0, sql_query.length - 1] << ";")
end
puts ""

# The code below consumes a huge amount of time!
# Each line corresponds to one SQL INSERT statement.
#
# File.readlines('words').each do |line|
#   word = line.chomp
#   Word.create!(name: word, sorted_name: word.downcase.split(//).sort.join)
# end
#
# Constants slow the script down!
# QUERY_HEAD = "INSERT INTO words (name, sorted_name, created_at, updated_at) VALUES "
#
# Benchmarking results (Using raw SQLs):
# 16.350000   0.300000  16.650000 (38.075944): Without transaction (1000/batch)
# 13.090000   0.310000  13.400000 (29.592404): With transaction (1000/batch) (X)
# 11.090000   0.390000  11.480000 (24.967660): With transaction (5000/batch)
# 11.630000   0.240000  11.870000 (24.707879): With transaction (10000/batch)