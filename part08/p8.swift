type file;

string curdir = java("java.lang.System","getProperty","user.dir");

app (file image, file out, file err) mandelbrotx (int iterations, int resolution)
{
    mpirun "-np" 28 mandelapp "-i" iterations "-s" 1 "-r" resolution "-f" @image stdout=@out stderr=@err;
}

app (file image, file out, file err) mandelbrot (int iterations, int resolution)
{
    mandelwrap 28 mandelapp "-i" iterations "-s" 1 "-r" resolution "-f" @image stdout=@out stderr=@err;
}

app (file movie, file montage, file out, file err) assemble (file[] mandel_imgs)
{
    assemble @movie @montage @mandel_imgs stdout=@out stderr=@err;
}

int  itermax     = toInt(arg("niter", "20"));     # number of iterations for mandelbrot
int  step        = toInt(arg("step", "5"));       # iteration step size
int  resolution  = toInt(arg("res",  "10000"));   # Resolution of result

// 5 -> 100 iterations stepping by 5

file mandel_img[] <simple_mapper; prefix="output/mandel_", suffix=".jpg">;
file mandel_out[] <simple_mapper; prefix="output/mandel_", suffix=".out">;
file mandel_err[] <simple_mapper; prefix="output/mandel_", suffix=".err">;

global string mandelapp = arg("mpiapp", curdir+"/bin/mandelbrot");

foreach i in [5:itermax:step]{
    tracef("i = %i \n", i);
    (mandel_img[i], mandel_out[i], mandel_err[i]) = mandelbrot(i, resolution);
}

file movie        <"output/mandel.gif">;
file montage      <"output/montage.jpg">;
file assemble_out <"output/assemble.out">;
file assemble_err <"output/assemble.err">;

(movie, montage, assemble_out, assemble_err) = assemble(mandel_img);





/*

app (file out, file err) mpi_hello (int time, int nproc)
{
    mpirun "-np" nproc mpiapp time stderr=filename(err) stdout=filename(out);
}

app (file image, file out, file err) mandelbrotORIG (file mandel_sh, int iterations, int resolution)
{
    bash @mandel_sh "-i" iterations "-s 1 -r" resolution "-f" @image stdout=@out stderr=@err;
}

*/

