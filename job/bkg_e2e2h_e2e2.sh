#!/bin/bash
FILENUM=36
i=0
j=0
k=0
flag=0
n=`ls /cefs/data/RecData/CEPC250/CEPC_v1/2fermions/E250.Pe2e2.e0.p0.whizard195/e2e2/*slcio -l | grep "^-" | wc -l`
let "n = $n - 1"
for SLCIO in `ls /cefs/data/RecData/CEPC250/CEPC_v1/2fermions/E250.Pe2e2.e0.p0.whizard195/e2e2/*slcio -l | awk '{print $9}'`
do
	if [ $flag == 0 ]; then
		STEER_FILE="../steer/bkg_e2e2h_e2e2_"$j".steer"
		JOB_FILE="bkg_e2e2h_e2e2_"$j
		echo "" > $STEER_FILE
		echo ".begin Global  ---------------------------------------" >> $STEER_FILE
		flag=1
	fi
	if [ $i -lt $FILENUM ]; then
		echo "LCIOInputFiles $SLCIO" >> $STEER_FILE
		let "i = $i + 1"
	fi
	if [ $i -ge $FILENUM ]; then
		echo "" >> $STEER_FILE
		echo "ActiveProcessors myhig2inv" >> $STEER_FILE
		echo "MaxRecordNumber -1" >> $STEER_FILE
		echo "" >> $STEER_FILE
		echo ".end   -----------------------------------------------" >> $STEER_FILE
		echo "" >> $STEER_FILE
		echo ".begin myhig2inv" >> $STEER_FILE
		echo "ProcessorType hig2inv" >> $STEER_FILE
		echo "" >> $STEER_FILE
		echo "#       The name of the PFOs" >> $STEER_FILE
		echo "#        type:  [string]" >> $STEER_FILE
		echo "#        default: MCParticle" >> $STEER_FILE
		echo "        MCObjects   MCParticle" >> $STEER_FILE
		echo "" >> $STEER_FILE
		echo "    OverwriteFile   0" >> $STEER_FILE
		echo "" >> $STEER_FILE
		echo "    TreeName   MCPart" >> $STEER_FILE
		echo "" >> $STEER_FILE
		echo "    LeptonIDTag 13" >> $STEER_FILE
		echo "" >> $STEER_FILE
		echo "    TreeOutputFile   ../rawdata/bkg_e2e2h_e2e2_"$j".root" >> $STEER_FILE
		echo ".end -------------------------------------------------" >> $STEER_FILE
		echo "#!/bin/bash" > $JOB_FILE
		echo "source ../setup.sh" >> $JOB_FILE
		echo "unset MARLIN_DLL" >> $JOB_FILE
		echo "export MARLIN_DLL=../lib/libhig2inv.so" >> $JOB_FILE
		echo "Marlin "$STEER_FILE >> $JOB_FILE
		chmod u+x $JOB_FILE
		hep_sub -g physics $JOB_FILE -o ./job.out -e ./job.err
		i=0
		flag=0
		let "j = $j + 1"
	elif [ $k == $n ]; then
		echo "" >> $STEER_FILE
		echo "ActiveProcessors myhig2inv" >> $STEER_FILE
		echo "MaxRecordNumber -1" >> $STEER_FILE
		echo "" >> $STEER_FILE
		echo ".end   -----------------------------------------------" >> $STEER_FILE
		echo "" >> $STEER_FILE
		echo ".begin myhig2inv" >> $STEER_FILE
		echo "ProcessorType hig2inv" >> $STEER_FILE
		echo "" >> $STEER_FILE
		echo "#       The name of the PFOs" >> $STEER_FILE
		echo "#        type:  [string]" >> $STEER_FILE
		echo "#        default: MCParticle" >> $STEER_FILE
		echo "        MCObjects   MCParticle" >> $STEER_FILE
		echo "" >> $STEER_FILE
		echo "    OverwriteFile   0" >> $STEER_FILE
		echo "" >> $STEER_FILE
		echo "    TreeName   MCPart" >> $STEER_FILE
		echo "" >> $STEER_FILE
		echo "    LeptonIDTag 13" >> $STEER_FILE
		echo "" >> $STEER_FILE
		echo "    TreeOutputFile   ../rawdata/bkg_e2e2h_e2e2_"$j".root" >> $STEER_FILE
		echo ".end -------------------------------------------------" >> $STEER_FILE
		echo "#!/bin/bash" > $JOB_FILE
		echo "source ../setup.sh" >> $JOB_FILE
		echo "unset MARLIN_DLL" >> $JOB_FILE
		echo "export MARLIN_DLL=../lib/libhig2inv.so" >> $JOB_FILE
		echo "Marlin "$STEER_FILE >> $JOB_FILE
		chmod u+x $JOB_FILE
		hep_sub -g physics $JOB_FILE -o ./job.out -e ./job.err
	else
		let "k = $j * $FILENUM + $i"
	fi
done
