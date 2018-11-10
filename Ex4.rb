#!/usr/bin/env ruby
require 'bio'

inpath = ARGV[0]
outpath = ARGV[1]
pattern = ARGV[2].upcase
type = ARGV[3]

Bio::NCBI.default_email = "jalonso@itba.edu.ar"

File.open(outpath, 'w') do |f|
  f.puts "Pattern: #{pattern}"
  Bio::Blast.reports(File.new(inpath)) do |report|
    report.each do |hit|
      if hit.definition.upcase.index(pattern)
        f.puts '--------------------------------'
        f.puts "Definition: #{hit.definition}"
        f.puts "Accession: #{hit.accession}"
        f.puts "Fasta sequence: "
        if type.eql? '--protein'
          f.puts Bio::NCBI::REST::EFetch.protein(hit.accession, "fasta")
          #Bio::DB::GenBank
        else
          f.puts Bio::NCBI::REST::EFetch.nucleotide(hit.accession, "fasta")
        end
      end
    end
  end
end