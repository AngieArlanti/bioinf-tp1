#!/usr/bin/env ruby

require 'bio'

if ARGV.length != 1
  puts 'USAGE: ruby Ex1.rb <input_file> '
  exit
end

data = Hash.new


(1..6).each do |frame|
  entries = Bio::GenBank.open(ARGV[0])
  entries.each_entry do |entry|
    seq = entry.to_biosequence
    data[frame] = seq.translate(frame) unless seq.empty?
  end
end

puts data

Dir.mkdir("out") unless File.exist?("out")
(1..6).each do |frame|
  File.open("out/ej1.out#{frame}.fas", 'w+') do |f|
    seq = Bio::Sequence::NA.new(data[frame])
    f.write(seq.to_fasta) unless seq.empty?
  end
end
