use strict;
use warnings;

my ($infile,$outfile) = @ARGV;

my $end_pos = 0;

open O, ">$outfile" or die;

open IN, "$infile" or die;
while (<IN>){
	chomp;
	if (/^2019-nCoV/){
		my @arr = split /\s+/, $_;
		my $seq = $arr[1];
		my $len = length($seq);

		# check if "---" in ref (consensus.fa has insertion)
		my $middle_line = 0;
		my @seq = split //, $seq;
		for my $base (@seq){
			if ($base eq "-"){
				$middle_line += 1;
			}
		}

		my $useful_len = $len - $middle_line;
		$end_pos += $useful_len;
		
		print O "$_\t$end_pos\n";
	}else{
		print O "$_\n";
	}
}
close IN;
close O;