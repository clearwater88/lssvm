import os;
import re;
import math;

data_dir = "protein_data/";
res_dir = "parser_data/";

data_files = os.listdir(data_dir);

for f in data_files:
    print "on file: " + f
    seqs = [];
    for line in open(data_dir + f,'r'):
        seq = re.search('\w+$',line).group(0);
        seqs.append(seq);


    res_f = open(res_dir + "res_" + f,'w');
    res_f.write(str(len(seqs)) + "\n");
    for i in xrange(len(seqs)):
        pos = 1 if i < math.ceil(len(seqs)/2) else -1;
        non_bg_only = 1;
        res_f.write("seq" + str(i) + ":" +
                    str(pos) + ":" +
                    str(non_bg_only) + ":" +
                    seqs[i] + "\n");
    res_f.close();
