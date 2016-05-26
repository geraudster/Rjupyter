# install R Kernel

install.packages(c('rzmq','repr','IRkernel','IRdisplay'), c('~/R/x86_64-pc-linux-gnu-library/3.3'),
                 repos = c('http://irkernel.github.io/', getOption('repos')))
IRkernel::installspec()
