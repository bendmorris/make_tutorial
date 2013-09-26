# USAGE:
#   python draw_tree.py [tree file] [output image file]
import sys
import Bio.Phylo as bp
import matplotlib.pyplot as plt

# get command line arguments
tree_file = sys.argv[1]
output_image = sys.argv[2]

# read in the input tree
tree = bp.read(tree_file, 'newick')
#tree.root_at_midpoint()

# draw the tree
bp._utils.draw(tree, do_show=False)
plt.title('Figure title')
plt.savefig(output_image)
