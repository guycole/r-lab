#! /usr/bin/rscript
# 
# Title: one53.r
# Description: 153 solved in R
# Development Environment: R 3.2.2, OSX 10.10.5
# 
for (hundred in 1:9) {
  for (ten in 0:9) {
    for (one in 0:9) {
      candidate1 = hundred * 100 + ten * 10 + one  
      candidate2 = hundred^3 + ten^3 + one^3
      if (candidate1 == candidate2) {
        print(sprintf("%d %d %d %d %d", hundred, ten, one, candidate1, candidate2))
      }
    }
  }
}
#
