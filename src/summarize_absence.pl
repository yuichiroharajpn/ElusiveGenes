#!/usr/bin/perl 
use strict;
use warnings;

use vars qw($opt_p $opt_d $opt_M $opt_A $opt_V $opt_e $opt_h);
use Getopt::Std;
getopts("AMVd:e:p:h");

#======== Preset of leaf, node, trees =======
my @leaf = qw/Homsap Pantro Panpan Gorgor Ponabe Nomleu Piltep Colang Rhirox Rhibie Chlsab Manleu Ceraty Papanu Macmul Macfas Macnem Saibol Cebcap Caljac Aotnan Procoq Micmur Otogar Carsyr Galvar Tupchi Jacjac Nangal Crigri Mesaur Perman Micoch Merung Ratnor Muspah Muscar Musspr Musmus Ochpri Cavpor Chilan Octdeg Hetgla Fukdam Manjav Dipord Cascan Icttri Marmar Erieur Sorara Panpar Pantig Felcat Ursmar Ailmel Musput Enhlut Canfam Neosch Odoros Ptevam Pteale Rouaeg Myodav Myobra Eptfus Minnat Rhisin Equcab Equprz Equasi Cersim Caphir Oviari Bostau Bosmut Bisbis Odovir Turtru Orcorc Delleu Lipvex Phycat Balacu Susscr Vicpac Camdro Camfer Cambac Loxafr Triman Echtel Chrasi Eleedw Oryafe Dasnov Phacin Sarhar Mondom Galgal Melgal Cotjap Nummel Anscyg Anapla Manvit Lepcor Parmaj Ficalb Taegut Lonstr Sercan Corbra Psehum Stuvul Falche Falper Aquchr Halleu Calpug Chavoc Colliv Cuccan Nipnip Egrgar Aptfor Calann Chapel Strcam Allsin Allmis Cropor Gavgan Chrpic Termex Chemyd Pelsin Parpic Gekjap Pogvit Anocar Promuc Pytbiv Xentro Xenlae Nanpar Latcha Lepocu Sclfor Parkin Astmex Pygnat Ictpun Danrer Sinans Sinrhi Singra Cluhar Esoluc Salsal Takrub Serlal Serog_flag Latcal Cynsem Paroli Monalb Ampoce Acapol Stepar Orenil Mayzeb Punnye Hapbur Orylat Orymel Krymar Auslim Notfur Funhet Cypvar Xipmac Poemex Poefor Poelat Rhityp Chipun Scytor Calmil/;
my @nod = qw/Hominoidea Cercopithecoidea Platyrrhini Strepsirhini Myodonta Castorimorpha Sciuromorpha Hystricognathi Eulipotyphla Carnivora Chiroptera Perissodactyla Cetartiodactyla Afrotheria Marsupialia Galloanserae Neoaves Crocodilia Testudines Gekkota Toxicofera/;

my $amntree = "(((Phacin,Sarhar,Mondom)Marsupialia,((Loxafr,Triman,Echtel,Chrasi,Eleedw,Oryafe)Afrotheria,Dasnov,((Procoq,Micmur,Otogar)Strepsirhini,Carsyr,(Saibol,Cebcap,Caljac,Aotnan)Platyrrhini,(Panpan,Pantro,Homsap,Gorgor,Ponabe,Nomleu)Hominoidea,(Piltep,Colang,Rhirox,Rhibie,Chlsab,Manleu,Ceraty,Papanu,Macmul,Macfas,Macnem)Cercopithecoidea)Primates,Galvar,Tupchi,(Ochpri,(Cavpor,Chilan,Octdeg,Hetgla,Fukdam)Hystricognathi,(Icttri,Marmar)Sciuromorpha,(Dipord,Cascan)Castorimorpha,(Jacjac,Nangal,Crigri,Mesaur,Perman,Micoch,Merung,Ratnor,Muspah,Muscar,Musspr,Musmus)Myodonta)Glires,(Erieur,Sorara)Eulipotyphla,(Panpar,Pantig,Felcat,Ursmar,Ailmel,Musput,Enhlut,Canfam,Neosch,Odoros)Carnivora,Manjav,(Ptevam,Pteale,Rouaeg,Myodav,Myobra,Eptfus,Minnat,Rhisin)Chiroptera,(Caphir,Oviari,Bostau,Bosmut,Bisbis,Odovir,Turtru,Orcorc,Delleu,Lipvex,Phycat,Balacu,Susscr,Vicpac,Camdro,Camfer,Cambac)Cetartiodactyla,(Equcab,Equprz,Equasi,Cersim)Perissodactyla)#Eutheria)#Theria,(((Pogvit,Anocar,Promuc,Pytbiv)Toxicofera,(Parpic,Gekjap)Gekkota)#Squamata,(Chrpic,Termex,Chemyd,Pelsin)Testudines,(Allsin,Allmis,Cropor,Gavgan)Crocodilia,Strcam,(Galgal,Melgal,Cotjap,Nummel,Anscyg,Anapla)Galloanserae,(Manvit,Lepcor,Parmaj,Ficalb,Taegut,Lonstr,Sercan,Corbra,Psehum,Stuvul,Falche,Falper,Aquchr,Halleu,Calpug,Chavoc,Colliv,Cuccan,Nipnip,Egrgar,Aptfor,Calann,Chapel)Neoaves)#Sauropsida)#Amniota";
my $mamtree = "((Phacin,Sarhar,Mondom)Marsupialia,((Loxafr,Triman,Echtel,Chrasi,Eleedw,Oryafe)Afrotheria,Dasnov,((Procoq,Micmur,Otogar)Strepsirhini,Carsyr,(Saibol,Cebcap,Caljac,Aotnan)Platyrrhini,(Panpan,Pantro,Homsap,Gorgor,Ponabe,Nomleu)Hominoidea,(Piltep,Colang,Rhirox,Rhibie,Chlsab,Manleu,Ceraty,Papanu,Macmul,Macfas,Macnem)Cercopithecoidea)Primates,Galvar,Tupchi,(Ochpri,(Cavpor,Chilan,Octdeg,Hetgla,Fukdam)Hystricognathi,(Icttri,Marmar)Sciuromorpha,(Dipord,Cascan)Castorimorpha,(Jacjac,Nangal,Crigri,Mesaur,Perman,Micoch,Merung,Ratnor,Muspah,Muscar,Musspr,Musmus)Myodonta)Glires,(Erieur,Sorara)Eulipotyphla,(Panpar,Pantig,Felcat,Ursmar,Ailmel,Musput,Enhlut,Canfam,Neosch,Odoros)Carnivora,Manjav,(Ptevam,Pteale,Rouaeg,Myodav,Myobra,Eptfus,Minnat,Rhisin)Chiroptera,(Caphir,Oviari,Bostau,Bosmut,Bisbis,Odovir,Turtru,Orcorc,Delleu,Lipvex,Phycat,Balacu,Susscr,Vicpac,Camdro,Camfer,Cambac)Cetartiodactyla,(Equcab,Equprz,Equasi,Cersim)Perissodactyla)#Eutheria)#Theria";

#my @orthosp = qw/Anocar Ailmel Astmex Aotnan Anapla Bostau Ceraty Cebcap Crigri Canfam Caphir Caljac Chilan Colang Cavpor Chlsab Carsyr Dasnov Dipord Danrer Equcab Erieur Echtel Ficalb Felcat Fukdam Galgal Gorgor Hetgla Icttri Jacjac Loxafr Latcha Lepocu Mesaur Mondom Macfas Musput Melgal Manleu Macmul Musmus Macnem Micoch Nangal Nomleu Oviari Octdeg Otogar Orylat Orenil Ochpri Ponabe Papanu Perman Procoq Poefor Panpan Pelsin Pantro Ptevam Rhibie Ratnor Rhirox Sorara Saibol Sarhar Susscr Taegut Takrub Turtru Vicpac Xipmac Xentro/;
#============================================

my $help = <<EXP;
$0 counts presence and absence of orthologs in a gene tree for the species in a given species phylogeny.

usage: $0 -d tree_dir [-MVA] [-e Ensembl_ortholog_pair] > outfile

Options:
	-d	directory where the output files of ete3 get_my_evol_events of the individual trees are stored [default: current directory].
	-M	Search for gene presence and absense referring to the given mammalian phylogeny [one of the -M, -A, -V options required].
	-A	Search for gene presence and absense referring to the given aminote phylogeny [one of the -M, -A, -V options required].
	-V	Search for gene presence and absense referring to the given aminote phylogeny with non-amniote vertebrates as outgroup [one of the -M, -A, -V options required].
	-e	Use Ensembl Human-nonhuman orthologous pair for additive annotation
		The file should be contain, human gene id, human transcriptome id, human protein id, non-human gene id, non-human transcriptome id,
		and non-human protein id, and these fields should be placed in the same order as they are.
		Species prefix (six-characters such as Homsap, Anocar) should be attaced to the individual IDs.
	-p	prefix of the ortholog group
	-h	Display this message and exit

EXP

my($prefix, $dir, $nspecies, $ext, $tmp);

if(defined($opt_h)){
	print STDERR $help;
	exit;
}

## Set prefix of tree file name
if($opt_p){
	$prefix = $opt_p;
}else{
	$prefix = "group_BchorENS";
}

## Set directory where tree files are located
if($opt_d){
	$dir = $opt_d;
}else{
	$dir = ".";
}

## specify taxonomic group
die "Specify one of -A (Amniote), -M (Mammalian), and -V (Amniote with non-amniote vertebrate outgroup) options.\n" if((defined($opt_A) && defined($opt_M)) || (defined($opt_A) && defined($opt_V)) || (defined($opt_M) && defined($opt_V)));

if(defined($opt_A)){ #Search for gene absense in aminote phylogeny
	$nspecies = 145;
	$ext = "SOAMN";
	$tmp = $amntree;
}elsif(defined($opt_M)){ #Search for gene absense in mammalian phylogeny
	$nspecies = 101;
	$ext = "SOMAM";
	$tmp = $mamtree;
}elsif(defined($opt_V)){ #Search for gene absense in amniote phylogeny with non-amniote vertebrate outgroup
	$nspecies = 10000;
	$ext = "SOVRT";
	$tmp = $amntree;
}else{
	die "Specify -A (Amniote), -M (Mammalian), or -V (Amniote with non-amniote vertebrate outgroup) option.\n";
}


## Additional orthologous information between human and the other speceis from Ensembl
my %ens = ();
if($opt_e){
	open(IN,$opt_e);
	while(<IN>){
		chomp;
		my @aa = split(/\t/);
		#++$ens{$aa[2]}{$aa[5]};
		++$ens{$aa[0]}{$aa[1]};
	}
	close(IN);
}

## Extract of the hierarchial relationships of an inner node with leaves in the phylogenetic tree
my %up = ();
while($tmp=~/\(/){
	$tmp =~ s/\(([^\(^\)]+)\)(#?[A-Z][a-z]+)/\[$1\]$2/;
	my $tmp1 = $1;
	my $tmp2 = $2;
	if($tmp1 !~ /\[/){
		foreach my $e (split(/,/,$tmp1)){
			$up{$e} = $tmp2;
		}
	}
}

my %nsp = ();
for(my $j=0; $j<@leaf; ++$j){
	$nsp{$leaf[$j]} = $j+1;
}

my $head = "grps\t".join("\t",(@nod,@leaf))."\tHomsap_IDs\n";
print $head;

# Read the output file of Speciation and Duplication events from viewpoints of human genes
my %og_flag = ();
my %dgrp = ();
my (%N, %NN) = ();
while(my $f = glob("$dir/*.clps.reroot.ortho.txt")){
	my %ortho = ();
	my @mem = ();
	my $f =~ /(${prefix}_\d+)/;
	my $grpid = $1;

	open(IN,$f);
	while(<IN>){
		chomp;
		my @aa = split(/\t/);

		my(@pn);
		if(!defined($og_flag{$aa[0]})){
			$og_flag{$aa[0]} = 0;
			@pn = (0)x250;
		}

		if($aa[1] eq "S" && !$og_flag{$aa[0]}){ #Examine branching points inferred as speciation if the outgroup flag has not been set
			foreach my $e (split(/,/,$aa[3])){
				$e =~ /^([^_]+)_/;

				#Set a flag and exit from the loop when outgroup species of the target taxonomy is included
				if($nsp{$1} && $nsp{$1}>$nspecies){
					$og_flag{$aa[0]} = 1;
					last;
				}
			}

			# Add orthologs for the individual human genes
			push(@mem,$aa[0]) if(!$ortho{$aa[0]});
			if(!$og_flag{$aa[0]}){
				$ortho{$aa[0]} = "$aa[2],$aa[3]";
				@pn = &countsp("$aa[2],$aa[3]");
			}else{
				$ortho{$aa[0]} = $aa[2] if(!$ortho{$aa[0]});
				@pn = &countsp($aa[2]);
			}
		}elsif($aa[1] eq "D" && !$og_flag{$aa[0]}){ #Examine branching points inferred as duplication if the outgroup flag has not been set
			foreach my $e (split(/,/,$aa[3])){
				$e =~ /^([^_]+)_/;
				if($nsp{$1} && $nsp{$1}>$nspecies){
					$og_flag{$aa[0]} = 1;
					last;
				}
			}
			
			# Search for the orthologs inferred by Ensembl Gene Tree
			# Search for the orthologs falsely included not in subtree of the specified taxon but in the outer lineage
			if(!$og_flag{$aa[0]}){
				foreach my $e (split(/,/,$aa[3])){
					$e =~ /^([A-Z][a-z]+)_/;
					my $ssp = $1;
					if($nsp{$ssp} && $nsp{$ssp}<=$nspecies){
						#if((!$pn[$nsp{$ssp}] && ! grep { $_ eq $ssp } @orthosp) || $ens{$aa[0]}{$e}){
						if(!$pn[$nsp{$ssp}] || $ens{$aa[0]}{$e}){
							push(@mem,$aa[0]) if(!$ortho{$aa[0]});
							$ortho{$aa[0]} = $aa[2] if(!$ortho{$aa[0]});
							$ortho{$aa[0]} .= ",$e";
							++$pn[$nsp{$ssp}];
						}
					}
				}
			}
		}

		# Search for the orthologs inferred by Ensembl Gene Tree
		# Search for the orthologs not included the subtree in the specified taxon but found outer lineage
		if($og_flag{$aa[0]}==1){
			foreach my $e (split(/,/,$aa[3])){
				$e =~ /^([A-Z][a-z]+)_/;
				if($nsp{$1} && $nsp{$1}<=$nspecies){
					if($ens{$aa[0]}{$e}){
						push(@mem,$aa[0]) if(!$ortho{$aa[0]});
						$ortho{$aa[0]} = $aa[2] if(!$ortho{$aa[0]});
						$ortho{$aa[0]} .= ",$e";
						++$pn[$nsp{$1}];
					}elsif(defined($opt_A) && !$pn[$nsp{$1}]){
					#}elsif($aa[3] !~ /Homsap && defined($opt_A) && !$pn[$nsp{$1}]){
						push(@mem,$aa[0]) if(!$ortho{$aa[0]});
						$ortho{$aa[0]} = $aa[2] if(!$ortho{$aa[0]});
						$ortho{$aa[0]} .= ",$e";
						++$pn[$nsp{$1}];
					}
				}
			}
		}
	}
	close(IN);

	my $nsub = 0;
	foreach my $e (@mem){
		my @hu = $ortho{$e} =~ /(Homsap_[^,]+)/g;

		if(!$dgrp{$e}){
			++$nsub;
			foreach my $e2 (@hu){
				$dgrp{$e2} = $nsub;
			}
		}else{
			next;
		}

		%N = ();
		%NN = ();
		foreach my $e2 ((@nod,@leaf)){
			$N{$e2} = 0;
			$NN{$e2} = 0;
		}

		&chkgrp($ortho{$e});

		my $str = "";
		my $str2 = "";
		foreach my $e2 (@nod){
			$str .= "\t$NN{$e2}";
		}
		foreach my $e2 (@leaf){
			$str2 .= "\t$N{$e2}";
		}

		my $jj = sprintf("%03d",$nsub);
		my $hstr = join(",",@hu);
		$hstr =~ s/Homsap_//g;
		print "$grpid\_${ext}_$jj$str\t|$str2\t$hstr\n";
		#++$j;
	}


}

sub countsp {
	my($str) = @_;

	my @m = split(/,/,$str);
	my @n = (0) x ($nspecies+1);
	foreach my $e (@m){
		$e =~ /^([A-Z][a-z]+)_/;
		++$n[$nsp{$1}] if($nsp{$1});
	}

	return(@n);
}

sub chkgrp {
	my($str) = @_;

	#foreach my $e ($str =~ /[\[,]([A-Z][a-z]+)/g){
	foreach my $e (split(/,/,$str)){
		$e =~ s/_.+//;
		if($up{$e}){
			++$NN{$up{$e}} if(!$N{$e});
			++$N{$up{$e}};
		}
		++$N{$e};
	}

	
}

