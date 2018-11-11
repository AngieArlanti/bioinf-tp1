#!/usr/bin/env ruby
# Compile EMBOSS and paste the binaries into this folder.
# Download ftp://ftp.expasy.org/databases/prosite
#
# ruby Ex5.rb --orf sequence.gb sequence.orf
# ruby Ex5.rb --prosite out\ej1.outX.fas analysis.prosite
#
require 'bio'
type = ARGV[0]

if type.eql? '--orf'
    Bio::EMBOSS.run('getorf', ARGV[1], ARGV[2])
end

if type.eql? '--prosite'
    Bio::EMBOSS.run('prosextract', 'prosite')
    Bio::EMBOSS.run('patmatmotifs', ARGV[1], ARGV[2])
end
