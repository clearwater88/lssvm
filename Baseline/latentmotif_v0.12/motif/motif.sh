./svm_motif_learn -c 1 --m 8 --o 3 -b 0 parser_data/res_Alx3_3418.2_deBruijn.txt example.model
./svm_motif_classify --m 8 --o 3 parser_data/res_Dlx1_1741.2_deBruijn.txt example.model
