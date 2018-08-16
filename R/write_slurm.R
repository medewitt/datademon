#' @ write_slurm
#' @param r_file_name the file R file that you want to use
#' @param job_name what do you want to call the job name (recommend using R name without R)
#' @param cores how many cores per node to request (default is 4)
#' @param mem how many GB of memory to request (default = 16)
#' @param my_directory the directory where to store and access your files (default is dewittme)
#' @return a slurm script that can be submitted to the cluster
#'
#'
#' @export
#'
#'

write_slurm <- function(r_file_name, job_name, cores = 4, mem = 16, my_directory =  "/deac/generalGrp/usershare/dewittme"){
  file <- glue::glue("
#!/bin/bash
#SBATCH --job-name={job_name}
#SBATCH --partition=small
#SBATCH --account=generalGrp
#SBATCH --nodes=1
#SBATCH --tasks-per-node={cores}
#SBATCH --time=8:00:00
#SBATCH --mem={mem}GB
#SBATCH --mail-user=dewittme@wfu.edu
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --workdir='{my_directory}'
#SBATCH --output={job_name}-%j.o
#SBATCH --error={job_name}-%j.e

module load R/3.5.0
R --vanilla --no-timing CMD BATCH {my_directory}/{r_file_name}")

  writeLines(file, glue::glue("{job_name}.SLURM"))
}
#' @example
#'write_slurm(r_file_name = "test.R", job_name = "my_job")


