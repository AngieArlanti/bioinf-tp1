#!/usr/bin/env ruby
require 'bio'

blast = Bio::Blast.remote('blastp', 'swissprot', '-e 0.0001 -m 7', 'genomenet')

Dir.mkdir("out") unless File.exist?("out")

(1..6).each do |frame|
  ff = Bio::FlatFile.open(Bio::FastaFormat, "out/ej1.out#{frame}.fas")
  File.open("out/blast#{frame}.out", 'w') do |f|
    ff.each_entry do |entry|
      report = blast.query(entry.seq)
      report.each do |hit|
        f.puts('___________________________')
        f.puts "Bit score: #{hit.bit_score}"
        f.puts "Identities: #{hit.identity}"
        f.puts "Overlap: #{hit.overlap}"
        f.puts "Query start: #{hit.query_start} end: #{hit.query_end}"
        f.puts 'Target ID: ' + hit.target_id
        f.puts 'Target def: ' + hit.target_def
        f.puts "Target start: #{hit.target_start} end: #{hit.target_end}"
        f.puts 'Sequence length: ' + hit.target_len.to_s
        f.puts 'Sequence: ' + hit.target_seq
      end
      File.open("out/xml/blast#{frame}.xml", 'w') do |x|
        x.puts blast.output
      end
    end
  end
end
