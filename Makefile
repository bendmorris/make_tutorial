all: $(patsubst %.fasta, %.png, $(wildcard *.fasta))

clean:
	rm -f *.aln *.phy* *.png RAxML* *.new
.SECONDARY: %.fasta.aln %.phy %.new

# make the alignment, in FASTA format
%.fasta.aln: %.fasta
	muscle -in $< -out $@

# convert the FASTA alignment to Phylip format
%.phy: %.fasta.aln
	python -c "import Bio.AlignIO; Bio.AlignIO.convert('$<', 'fasta', '$@', 'phylip-relaxed')"

%.new: %.phy
	rm -f RAxML*
	raxmlHPC -m GTRCAT -n $@ -p 10000 -s $<
	mv RAxML_result.$@ $@

%.png: %.new draw_tree.py
	python draw_tree.py $< $@
