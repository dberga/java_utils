# Change these two variables to match your 
# installation

GATE_HOME=c:\\work\\programs\\GATE-7.0
SUMMA_HOME=c:\\work\\programs\\GATE-7.0\\plugins\\summa_plugin


# change the ";" by ":" in a Linux environment!
# careful with the 'tr' statement below if you have paths with spaces!

CLASSPATH="$GATE_HOME/bin/gate.jar;$SUMMA_HOME/Summa_UPF.jar";
CLASSPATH="$(echo "$GATE_HOME"/lib/*.jar | tr ' ' ';');$CLASSPATH";
export CLASSPATH;

echo $CLASSPATH;

# input directory
INDIR=c:\\work\\programs\\GATE-7.0\\plugins\\summa_plugin\\test_files\\multi_eng
#export INDIR;


# output directory: change it to your own!
OUTDIR=c:\\test_summa_eng

mkdir $OUTDIR;
#export OUTDIR;


# feature list
FEATURES="tf_score;position_score;first_sim;sent_doc_sim;centroid_sim";
#export FEATURES;

# weight list
WEIGHTS="0.0;0.0;0.0;1.0;1.0";
#export WEIGHTS;

COMPRESSION=200
#export COMPRESSION;

SENT=false
#export SENT;
#EN or ES
LANG="EN"

MULTI_NAME="multi_doc";


PROPS="-DGATE_HOME=/${GATE_HOME} -DSUMMA_HOME=/${SUMMA_HOME} -DLANG=${LANG} -DINDIR=${INDIR} -DOUTDIR=${OUTDIR} -DCOMPRESSION=${COMPRESSION} -DSENT=${SENT} -DFEATURES=${FEATURES} -DWEIGHTS=${WEIGHTS} -DMULTI_NAME=${MULTI_NAME}";

# for Linux use this line instead of the one above
#PROPS="-DGATE_HOME=${GATE_HOME} -DSUMMA_HOME=${SUMMA_HOME} -DLANG=${LANG} -DINDIR=${INDIR} -DOUTDIR=${OUTDIR} -DCOMPRESSION=${COMPRESSION} -DSENT=${SENT} -DFEATURES=${FEATURES} -DWEIGHTS=${WEIGHTS} -DMULTI_NAME=${MULTI_NAME}";

java -cp $CLASSPATH  $PROPS summa.applications.SummaVanillaMultiDocSum;

