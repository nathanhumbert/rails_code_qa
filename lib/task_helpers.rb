def flog_runner(threshold, dirs)
  flog = Flog.new
  flog.flog dirs
  average_threshold = threshold / 3.0
  puts "=============================================="
  puts "Flog output for #{dirs.join(", ")}:"
  puts "Method threshold: %4.1f \nAverage threshold: %4.1f" % [threshold, average_threshold]
  puts "Flog total: %17.1f" % [flog.total]
  puts "Flog method average: %8.1f" % [flog.average]
  puts ""
  bad_methods = flog.totals.select do |name,score|
    score > threshold
  end
  bad_methods.sort { |a,b| a[1] <=> b[1] }.each do |name, score|
    puts "%8.1f: %s" % [score, name]
  end
   
  puts "#{bad_methods.size} methods have a flog complexity > #{threshold}" unless bad_methods.empty?
  puts "Average flog complexity > #{average_threshold}" unless flog.average < average_threshold
  puts "=============================================="
  puts ""
end
