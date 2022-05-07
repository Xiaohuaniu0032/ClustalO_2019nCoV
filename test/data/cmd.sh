#cat Ion_AmpliSeq_SARS-CoV-2-Insight.Reference.fa Auto_SARS-CoV-2_Insight_Research_Panel_-_530-2022-4-28_torrent-server_95.consensus.fasta >input.fa

#/data/fulongfei/git_repo/Nextalign_ClustalO/bin/clustalo -i input.fa -o clustalo.out.aln.fa --outfmt=clu

/data/fulongfei/git_repo/Nextalign_ClustalO/bin/nextalign --sequences=Auto_SARS-CoV-2_Insight_Research_Panel_-_530-2022-4-28_torrent-server_95.consensus.fasta --reference=Ion_AmpliSeq_SARS-CoV-2-Insight.Reference.fa --output-dir=$PWD --output-basename=nextalign --include-reference


perl ../../add_position_info_clustalo.pl clustalo.out.aln.fa clustalo.out.aln.POS.fa
