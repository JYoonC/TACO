#!/bin/bash
#SBATCH --job-name=chunk4
#SBATCH --nodes=1
#SBATCH --cpus-per-task=1           # adjust this if you are using parallel commands
#SBATCH --time=24:00:00             # adjust this to match the walltime of your job
#SBATCH --output=./%j.out
#SBATCH --ntasks-per-node=10

# Setup TACO 
# source ~/opt/anaconda3/etc/profile.d/conda.sh
source activate taco

# reset 
# PATH=/sbin:/bin:/usr/sbin:/usr/bin
# PYTHONPATH=/sbin:/bin:/usr/sbin:/usr/bin
# export PATH
# export PYTHONPATH

# echo "Before: PATH=$PATH"
# echo "Before: PYTHONPATH=$PYTHONPATH"


# environment setting 
# PATH=$PWD/src:$PATH
# PYTHONPATH=$PWD/src:$PWD/libs/sloscillations:$PYTHONPATH
# export PATH
# export PYTHONPATH

# echo "After: PATH=$PATH"
# echo "After: PYTHONPATH=$PYTYONPATH"

# install package 
# conda install rpy2 -y

# Load the GNU Parallel module
conda install -c conda-forge parallel
module load parallel

# Setup paths
export TACO=/hits/basement/tos/Choi/TACO_Choi
export Stars=/hits/fast/tos/Choi/Stars/APOKASC2/KASOC/stars_synbinaries/

export OMP_NUM_THREADS=${SLURM_CPUS_PER_TASK}
export NUM_PARALLEL=${SLURM_NTASKS}

# Define a function to be executed in parallel
function runTACO(){
        chmod u+rx /hits/basement/tos/Choi/TACO_Choi/src/pipeline.py

        for filename in "$@"
        do 
            echo $filename
                python $TACO/src/pipeline.py -i $Stars/$filename -o $Stars/$filename -s $TACO/pipeline/pipeline_settings.yaml
	done
}

# Export the function so it can be used by parallel
export -f runTACO

# Use parallel to execute the function in parallel 
parallel --jobs 10 runTACO :::: $Stars/binaries_chunk4.csv





