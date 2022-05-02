# Nextalign_ClustalO

### https://www.ebi.ac.uk/Tools/msa/clustalo/
### http://www.clustal.org/


### Download Clustal Omega
`http://www.clustal.org/omega/`

### Download Nextalign CLI
```
curl -fsSL "https://github.com/nextstrain/nextclade/releases/latest/download/nextalign-Linux-x86_64" -o "nextalign" && chmod +x nextalign

```



## Nextalign README
```
# ./nextalign -h
nextalign 1.11.0
based on libnextalign 1.11.0


Nextalign is a part of Nextstrain project: https://nextstrain.org

Documentation: https://docs.nextstrain.org/projects/nextclade
Nextclade Web: https://clades.nextstrain.org
Publication:   https://doi.org/10.21105/joss.03773

Nextalign is a viral genome sequence alignment tool. It performs pairwise alignment of provided sequences against a given reference sequence using banded local alignment algorithm with affine gap-cost. Band width and rough relative positions are determined through seed matching.

Nextalign will strip insertions relative to the reference and output them in a separate CSV file.

Optionally, when provided with a gene map and a list of genes, Nextalign can perform translation of these genes.

Currently Nextalign primarily focuses on SARS-CoV-2 genome, but it can be used on any virus, given a sufficiently similar reference sequence (less than a 5% divergence).


Nextalign is a free and open-source software and the source code can be found in the Nextclade GitHub repository:
https://github.com/nextstrain/nextclade

The latest downloads are available at:
https://github.com/nextstrain/nextclade/releases

Docker container images are available at:
https://hub.docker.com/r/nextstrain/nextalign

Please report bugs and request features using GitHub Issues:
https://github.com/nextstrain/nextclade/issues/new

For questions and general discussion join Nextstrain discussion forum:
https://discussion.nextstrain.org


Quick Example:

 1. Download the example SARS-CoV-2 data files from

  https://github.com/nextstrain/nextclade/tree/master/data/sars-cov-2

  (You can also try other viruses in the `data/` directory)

 2. Run:

    nextalign --sequences=sequences.fasta --reference=reference.fasta --genemap=genemap.gff --genes=E,M,N,ORF1a,ORF1b,ORF3a,ORF6,ORF7a,ORF7b,ORF8,ORF9b,S --output-dir=output/ --output-basename=nextalign

    Add `--verbose` flag to show more information in the console. Add `--include-reference` flag to also write gap-stripped reference sequence and peptides into outputs.

 3. Find the output files in the `output/` directory:

    - nextalign.aligned.fasta - aligned input sequences
    - nextalign.gene.<gene_name>.fasta - peptides corresponding to each gene
    - nextalign.insertions.csv - list of stripped insertions for each input sequence



Usage:
  nextalign [OPTION...]

  -h, --help                    Show this help
  -v, --version                 Show version
      --version-detailed        Show detailed version
      --verbosity VERBOSITY     (optional, string) Set minimum verbosity
                                level of console output. Possible values are (from
                                least verbose to most verbose): "silent",
                                "error", "warn", "info", "debug". Default: 'warn'
                                (only errors and warnings are shown).
                                (default: warn)
      --verbose                 (optional, boolean) Increase verbosity of the
                                console output. Same as --verbosity=info.
      --silent                  (optional, boolean) Disable console output
                                entirely. --verbosity=silent.
  -j, --jobs JOBS               (optional, integer) Number of CPU threads
                                used by the algorithm. If not specified or if a
                                non-positive value specified, the algorithm
                                will use all the available threads. (default: 0)
      --in-order                Force parallel processing in-order. With this
                                flag the program will wait for results from
                                the previous sequences to be written to the
                                output files before writing the results of the
                                next sequences, preserving the same order as in
                                the input file. Due to variable sequence
                                processing times, this might introduce unnecessary
                                waiting times, but ensures that the resulting
                                sequences are written in the same order as
                                they occur in the inputs (except for sequences
                                which have errors). By default, without this
                                flag, processing might happen out of order, which
                                is faster, due to the elimination of waiting,
                                but might also lead to results written out of
                                order - the order of results is not specified
                                and depends on thread scheduling and
                                processing times of individual sequences. This option
                                is only relevant when `--jobs` is greater than
                                1 or is omitted. Note: the sequences which
                                trigger errors during processing will be omitted
                                from outputs, regardless of this flag.
  -i, --sequences SEQS          (required, string) Path to a FASTA file with
                                input sequences
  -r, --reference REF           (required, string) Path to a FASTA or plain
                                text file containing reference sequence
  -g, --genes GENES             (optional, string) List of genes to
                                translate. Requires `--genemap`. If not supplied or
                                empty, sequence will not be translated. If
                                non-empty, should contain a coma-separated list of
                                gene names. Parameters `--genes` and
                                `--genemap` should be either both specified or both
                                omitted.
  -m, --genemap GENEMAP         (optional, string) Path to a GFF file
                                containing custom gene map. Requires `--genes.` If
                                not supplied, sequence will not be translated.
                                Parameters `--genes` and `--genemap` should be
                                either both specified or both omitted.
  -d, --output-dir OUTPUT_DIR   (optional, string) Write output files to this
                                directory. The base filename can be set using
                                `--output-basename` flag. The paths can be
                                overridden on a per-file basis using
                                `--output-*` flags. If the required directory tree does
                                not exist, it will be created.
  -n, --output-basename OUTPUT_BASENAME
                                (optional, string) Set the base filename to
                                use for output files. To be used together with
                                `--output-dir` flag. By default uses the
                                filename of the sequences file (provided with
                                `--sequences`). The paths can be overridden on a
                                per-file basis using `--output-*` flags.
      --include-reference       (optional, boolean) Whether to include
                                aligned reference nucleotide sequence into output
                                nucleotide sequence fasta file and reference
                                peptides into output peptide files.
  -o, --output-fasta OUTPUT_FASTA
                                (optional, string) Path to output aligned
                                sequences in FASTA format (overrides paths given
                                with `--output-dir` and `--output-basename`).
                                If the required directory tree does not exist,
                                it will be created.
  -I, --output-insertions OUTPUT_INSERTIONS
                                (optional, string) Path to output stripped
                                insertions data in CSV format (overrides paths
                                given with `--output-dir` and
                                `--output-basename`). If the required directory tree does not
                                exist, it will be created.
  -E, --output-errors OUTPUT_ERRORS
                                (optional, string) Path to output errors and
                                warnings occurred during processing, in CSV
                                format (overrides paths given with
                                `--output-dir` and `--output-basename`). If the required
                                directory tree does not exist, it will be
                                created.
      --min-length MIN_LENGTH   (optional, integer, non-negative) Minimum
                                length of nucleotide sequence to consider for
                                alignment. If a sequence is shorter than that,
                                alignment will not be attempted and a warning
                                will be emitted. When adjusting this parameter,
                                note that alignment of short sequences can be
                                unreliable. (default: 100)
      --penalty-gap-extend PENALTY_GAP_EXTEND
                                (optional, integer, non-negative) Penalty for
                                extending a gap. If zero, all gaps regardless
                                of length incur the same penalty. (default:
                                0)
      --penalty-gap-open PENALTY_GAP_OPEN
                                (optional, integer, positive) Penalty for
                                opening of a gap. A higher penalty results in
                                fewer gaps and more mismatches. Should be less
                                than `--penalty-gap-open-in-frame` to avoid gaps
                                in genes. (default: 6)
      --penalty-gap-open-in-frame PENALTY_GAP_OPEN_IN_FRAME
                                (optional, integer, positive) As
                                `--penalty-gap-open`, but for opening gaps at the
                                beginning of a codon. Should be greater than
                                `--penalty-gap-open` and less than
                                `--penalty-gap-open-out-of-frame`, to avoid gaps in genes, but
                                favor gaps that align with codons. (default: 7)
      --penalty-gap-open-out-of-frame PENALTY_GAP_OPEN_OUT_OF_FRAME
                                (optional, integer, positive) As
                                `--penalty-gap-open`, but for opening gaps in the body of
                                a codon. Should be greater than
                                `--penalty-gap-open-in-frame` to favor gaps that align with
                                codons. (default: 8)
      --penalty-mismatch PENALTY_MISMATCH
                                (optional, integer, positive) Penalty for
                                aligned nucleotides or aminoacids that differ in
                                state during alignment. Note that this is
                                redundantly parameterized with `--score-match`.
                                (default: 1)
      --score-match SCORE_MATCH
                                (optional, integer, positive) Score for
                                encouraging aligned nucleotides or aminoacids with
                                matching state. (default: 3)
      --max-indel MAX_INDEL     (optional, integer, non-negative) Maximum
                                length of insertions or deletions allowed to
                                proceed with alignment. Alignments with long
                                indels are slow to compute and require substantial
                                memory in the current implementation.
                                Alignment of sequences with indels longer that this
                                value, will not be attempted and a warning will
                                be emitted. (default: 400)
      --nuc-seed-length NUC_SEED_LENGTH
                                (optional, integer, positive) Seed length for
                                nucleotide alignment. Seeds should be long
                                enough to be unique, but short enough to match
                                with high probability. (default: 21)
      --nuc-min-seeds NUC_MIN_SEEDS
                                (optional, integer, positive) Minimum number
                                of seeds to search for during nucleotide
                                alignment. Relevant for short sequences. In long
                                sequences, the number of seeds is determined by
                                `--nuc-seed-spacing`. Should be a positive
                                integer. (default: 10)
      --nuc-seed-spacing NUC_SEED_SPACING
                                (optional, integer, non-negative) Spacing
                                between seeds during nucleotide alignment.
                                (default: 100)
      --nuc-mismatches-allowed NUC_MISMATCHES_ALLOWED
                                (optional, integer, non-negative) Maximum
                                number of mismatching nucleotides allowed for a
                                seed to be considered a match. (default: 3)
      --no-translate-past-stop  (optional, boolean) Whether to stop gene
                                translation after first stop codon. It will cut
                                the genes in places cases where mutations
                                resulted in premature stop codons. If this flag is
                                present, the aminoacid sequences wil be
                                truncated at the first stop codon and analysis of
                                aminoacid mutations will not be available for the
                                regions after first stop codon.
```

## ClustalO README
```
# ./clustalo-1.2.4-Ubuntu-x86_64 -h
Clustal Omega - 1.2.4 (AndreaGiacomo)

If you like Clustal-Omega please cite:
 Sievers F, Wilm A, Dineen D, Gibson TJ, Karplus K, Li W, Lopez R, McWilliam H, Remmert M, Söding J, Thompson JD, Higgins DG.
 Fast, scalable generation of high-quality protein multiple sequence alignments using Clustal Omega.
 Mol Syst Biol. 2011 Oct 11;7:539. doi: 10.1038/msb.2011.75. PMID: 21988835.
If you don't like Clustal-Omega, please let us know why (and cite us anyway).

Check http://www.clustal.org for more information and updates.

Usage: clustalo-1.2.4-Ubuntu-x86_64 [-hv] [-i {<file>,-}] [--hmm-in=<file>]... [--hmm-batch=<file>] [--dealign] [--profile1=<file>] [--profile2=<file>] [--is-profile] [-t {Protein, RNA, DNA}] [--infmt={a2m=fa[sta],clu[stal],msf,phy[lip],selex,st[ockholm],vie[nna]}] [--distmat-in=<file>] [--distmat-out=<file>] [--guidetree-in=<file>] [--guidetree-out=<file>] [--pileup] [--full] [--full-iter] [--cluster-size=<n>] [--clustering-out=<file>] [--trans=<n>] [--posterior-out=<file>] [--use-kimura] [--percent-id] [-o {file,-}] [--outfmt={a2m=fa[sta],clu[stal],msf,phy[lip],selex,st[ockholm],vie[nna]}] [--residuenumber] [--wrap=<n>] [--output-order={input-order,tree-order}] [--iterations=<n>] [--max-guidetree-iterations=<n>] [--max-hmm-iterations=<n>] [--maxnumseq=<n>] [--maxseqlen=<l>] [--auto] [--threads=<n>] [--pseudo=<file>] [-l <file>] [--version] [--long-version] [--force] [--MAC-RAM=<n>]

A typical invocation would be: clustalo-1.2.4-Ubuntu-x86_64 -i my-in-seqs.fa -o my-out-seqs.fa -v
See below for a list of all options.

Sequence Input:
  -i, --in, --infile={<file>,-} Multiple sequence input file (- for stdin)
  --hmm-in=<file>           HMM input files
  --hmm-batch=<file>        specify HMMs for individual sequences
  --dealign                 Dealign input sequences
  --profile1, --p1=<file>   Pre-aligned multiple sequence file (aligned columns will be kept fix)
  --profile2, --p2=<file>   Pre-aligned multiple sequence file (aligned columns will be kept fix)
  --is-profile              disable check if profile, force profile (default no)
  -t, --seqtype={Protein, RNA, DNA} Force a sequence type (default: auto)
  --infmt={a2m=fa[sta],clu[stal],msf,phy[lip],selex,st[ockholm],vie[nna]} Forced sequence input file format (default: auto)

Clustering:
  --distmat-in=<file>       Pairwise distance matrix input file (skips distance computation)
  --distmat-out=<file>      Pairwise distance matrix output file
  --guidetree-in=<file>     Guide tree input file (skips distance computation and guide-tree clustering step)
  --guidetree-out=<file>    Guide tree output file
  --pileup                  Sequentially align sequences
  --full                    Use full distance matrix for guide-tree calculation (might be slow; mBed is default)
  --full-iter               Use full distance matrix for guide-tree calculation during iteration (might be slowish; mBed is default)
  --cluster-size=<n>        soft maximum of sequences in sub-clusters
  --clustering-out=<file>   Clustering output file
  --trans=<n>               use transitivity (default: 0)
  --posterior-out=<file>    Posterior probability output file
  --use-kimura              use Kimura distance correction for aligned sequences (default no)
  --percent-id              convert distances into percent identities (default no)

Alignment Output:
  -o, --out, --outfile={file,-} Multiple sequence alignment output file (default: stdout)
  --outfmt={a2m=fa[sta],clu[stal],msf,phy[lip],selex,st[ockholm],vie[nna]} MSA output file format (default: fasta)
  --residuenumber, --resno  in Clustal format print residue numbers (default no)
  --wrap=<n>                number of residues before line-wrap in output
  --output-order={input-order,tree-order} MSA output order like in input/guide-tree

Iteration:
  --iterations, --iter=<n>  Number of (combined guide-tree/HMM) iterations
  --max-guidetree-iterations=<n> Maximum number of guidetree iterations
  --max-hmm-iterations=<n>  Maximum number of HMM iterations

Limits (will exit early, if exceeded):
  --maxnumseq=<n>           Maximum allowed number of sequences
  --maxseqlen=<l>           Maximum allowed sequence length

Miscellaneous:
  --auto                    Set options automatically (might overwrite some of your options)
  --threads=<n>             Number of processors to use
  --pseudo=<file>           Input file for pseudo-count parameters
  -l, --log=<file>          Log all non-essential output to this file
  -h, --help                Print this help and exit
  -v, --verbose             Verbose output (increases if given multiple times)
  --version                 Print version information and exit
  --long-version            Print long version information and exit
  --force                   Force file overwriting
```