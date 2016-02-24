hadoop pipes \
  -D hadoop.pipes.java.recordreader=true \
  -D hadoop.pipes.java.recordwriter=true \
  -input /user/vagrant/gutenberg/pg4300.txt \
  -output dft1-out \
  -program bin/wordcount
