import sys, re, os
import pandas as pd
from ete3 import PhyloTree

def get_species_name(node_name_string):
    spcode = node_name_string.split("_")[0]
    return(spcode)

# Input hierarchial relationship

#scriptdir = os.path.dirname(os.path.abspath(__file__))
scriptdir = os.path.dirname(os.path.abspath(sys.argv[0]))
hfile = scriptdir + '/../scripts/hierarchy_vrt.txt'
is_file = os.path.isfile(hfile)

try:
    df = pd.read_table(hfile)
except FileNotFoundError:
    print('Human-centric topological age file',file,'not found.')
    exit(1)


species2age = dict(zip(df['Species'],df['Hierarchy']))
#species2age = {
#    'Homsap': 1,
#    'Pantro': 2, 'Panpan': 2, 'Gorgor': 2, 'Ponabe': 2, 'Nomleu': 2, 
#    'Piltep': 3, 'Colang': 3, 'Rhirox': 3, 'Rhibie': 3, 'Chlsab': 3, 'Manleu': 3, 'Ceraty': 3, 'Papanu': 3, 'Macmul': 3, 'Macfas': 3, 'Macnem': 3, 'Saibol': 3, 'Cebcap': 3, 'Caljac': 3, 'Aotnan': 3, 'Procoq': 3, 'Micmur': 3, 'Otogar': 3, 'Carsyr': 3, 
#    'Galvar': 4, 'Tupchi': 4, 'Jacjac': 4, 'Nangal': 4, 'Crigri': 4, 'Mesaur': 4, 'Perman': 4, 'Micoch': 4, 'Merung': 4, 'Ratnor': 4, 'Muspah': 4, 'Muscar': 4, 'Musspr': 4, 'Musmus': 4, 'Ochpri': 4, 'Manjav': 4, 'Dipord': 4, 'Cascan': 4, 'Icttri': 4, 'Marmar': 4, 'cIcttri': 4, 'Marmar': 4, 'Erieur': 4, 'Sorara': 4, 'Panpar': 4, 'Pantig': 4, 'Felcat': 4, 'Ursmar': 4, 'Ailmel': 4, 'Musput': 4, 'Enhlut': 4, 'Canfam': 4, 'Neosch': 4, 'Odoros': 4, 'Ptevam': 4, 'Pteale': 4, 'Rouaeg': 4, 'Myodav': 4, 'Myobra': 4, 'Eptfus': 4, 'Minnat': 4, 'Rhisin': 4, 'Equcab': 4, 'Equprz': 4, 'Equasi': 4, 'Cersim': 4, 'Caphir': 4, 'Oviari': 4, 'Bostau': 4, 'Bosmut': 4, 'Bisbis': 4, 'Odovir': 4, 'Turtru': 4, 'Orcorc': 4, 'Delleu': 4, 'Lipvex': 4, 'Phycat': 4, 'Balacu': 4, 'Susscr': 4, 'Vicpac': 4, 'Camdro': 4, 'Camfer': 4, 'Cambac': 4, 'Loxafr': 4, 'Triman': 4, 'Echtel': 4, 'Chrasi': 4, 'Eleedw': 4, 'Oryafe': 4, 'Dasnov': 4, 'Octdeg': 4, 'Chilan': 4, 'Cavpor': 4, 'Hetgla': 4, 'Fukdam': 4,
#    'Phacin': 5, 'Sarhar': 5, 'Mondom': 5, 
#    'Galgal': 6, 'Melgal': 6, 'Cotjap': 6, 'Nummel': 6, 'Anscyg': 6, 'Anapla': 6, 'Manvit': 6, 'Lepcor': 6, 'Parmaj': 6, 'Ficalb': 6, 'Taegut': 6, 'Lonstr': 6, 'Sercan': 6, 'Corbra': 6, 'Psehum': 6, 'Stuvul': 6, 'Falche': 6, 'Falper': 6, 'Aquchr': 6, 'Halleu': 6, 'Calpug': 6, 'Chavoc': 6, 'Colliv': 6, 'Cuccan': 6, 'Nipnip': 6, 'Egrgar': 6, 'Aptfor': 6, 'Calann': 6, 'Chapel': 6, 'Strcam': 6, 'Allsin': 6, 'Allmis': 6, 'Cropor': 6, 'Gavgan': 6, 'Chrpic': 6, 'Termex': 6, 'Chemyd': 6, 'Pelsin': 6, 'Parpic': 6, 'Gekjap': 6, 'Pogvit': 6, 'Anocar': 6, 'Promuc': 6, 'Pytbiv': 6, 
#    'Xentro': 7, 'Xenlae': 7, 'Nanpar': 7, 'Latcha': 7, 
#    'Lepocu': 8, 'Sclfor': 8, 'Parkin': 8, 'Astmex': 8, 'Pygnat': 8, 'Ictpun': 8, 'Danrer': 8, 'Sinans': 8, 'Sinrhi': 8, 'Singra': 8, 'Cluhar': 8, 'Esoluc': 8, 'Salsal': 8, 'Takrub': 8, 'Serlal': 8, 'Serdum': 8, 'Latcal': 8, 'Cynsem': 8, 'Paroli': 8, 'Monalb': 8, 'Ampoce': 8, 'Acapol': 8, 'Stepar': 8, 'Orenil': 8, 'Mayzeb': 8, 'Punnye': 8, 'Hapbur': 8, 'Orylat': 8, 'Orymel': 8, 'Krymar': 8, 'Auslim': 8, 'Notfur': 8, 'Funhet': 8, 'Cypvar': 8, 'Xipmac': 8, 'Poemex': 8, 'Poefor': 8, 'Poelat': 8, 
#    'Rhityp': 9, 'Chipun': 9, 'Scytor': 9, 'Calmil': 9
#}

# Input tree file
tfile=sys.argv[1]
outfile = tfile.replace(".nwk","reroot.nwk")
if tfile == outfile:
	print('Extension of the tree file must be ".nwk"', file=sys.stderr)
	sys.exit()

with open(tfile) as f:
    l_strip = [s.strip() for s in f.readlines()]
    tre = l_strip[0]
t = PhyloTree(tre)

# Unrooting and rerooting referring to the taxonomic hierarchy
t.unroot()
t.set_species_naming_function(get_species_name)
og = t.get_age_balanced_outgroup(species2age)


# Output orthologous relationships for the individual human genes
t.set_outgroup(og)
m = re.findall(r'Homsap_[^:]+', tre)
for mid in m:
    matches = t.search_nodes(name=mid)
    hid = matches[0]
    #events = hid.get_my_evol_events()
    events = hid.get_my_evol_events(sos_thr=0.0)
    for ev in events:
        print (mid, ev.etype, ','.join(ev.in_seqs), ','.join(ev.out_seqs), sep="\t")

t.write(format=1, outfile=outfile)
