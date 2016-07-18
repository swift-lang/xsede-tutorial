type file;

app (file out, file err) mpi_hello (file mpiapp, int time, int nproc)
{
    ibrun "-np" nproc "/home/xdtr1/swift-tutorial/mpi/mpi_hello" time stderr=filename(err) stdout=filename(out);
}

int nsim   = toInt(arg("nsim",   "10"));
int time   = toInt(arg("time",   "1"));
int nproc  = toInt(arg("nproc",  "4"));

file mpiapp <"mpi_hello">;

foreach i in [0:nsim-1] {
  file mpiout <single_file_mapper; file=strcat("output/mpi_",i,".out")>;
  file mpierr <single_file_mapper; file=strcat("output/mpi_",i,".err")>;
  (mpiout, mpierr) = mpi_hello(mpiapp, time, nproc);
}
