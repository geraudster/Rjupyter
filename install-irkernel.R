# install R Kernel
library(devtools)
# Install the packages
install_github('geraudster/repr')
install_github('IRkernel/IRdisplay')
install_github('IRkernel/IRkernel')

IRkernel::installspec()
