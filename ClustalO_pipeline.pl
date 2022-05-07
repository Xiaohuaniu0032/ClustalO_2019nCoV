use strict;
use warnings;
use FindBin qw/$Bin/;
use File::Basename;

my ($cons_dir,$outdir) = @ARGV;

# get .consensus.fasta
my @cons_fa = glob "$cons_dir/*.consensus.fasta";
my $cons_fa = $cons_fa[0];

# make input.fa
my $ref_fa = "$Bin/test/data/Ion_AmpliSeq_SARS-CoV-2-Insight.Reference.fa";
my $cmd = "cat $ref_fa $cons_fa >$outdir/input.fa";
systme($cmd);

# do align
my $input_fa = "$outdir/input.fa";
my $out_temp = "$outdir/clustalo.out.aln.fa";
$cmd = "$Bin/bin/clustalo -i $input_fa -o $out_temp --outfmt=clu";
smstem($cmd);

# add pos info
my $outdir_basename = basename($outdir);
my $outfile = "$outdir/$outdir_basename\.ClustalO.fasta";
$cmd = "perl $Bin/add_position_info_clustalo.pl $out_temp $outfile";
system($cmd);
