#!/usr/bin/env ruby
require 'bio'

pattern = ARGV[1].upcase

File.open("out/ej4.out", 'w') do |f|
  f.puts "Pattern: #{pattern}"
  Bio::Blast.reports(File.new(ARGV[0])) do |report|
    report.each do |hit|
      if hit.definition.upcase.index(pattern)
        f.puts '------------------------------------------------'
        f.puts "- Definition: #{hit.definition}"
        f.puts "- Accession: #{hit.accession}"
      end
    end
  end
end