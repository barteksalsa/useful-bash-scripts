($3~/[0-9]+/) { sum+=$3; i++; } 

END {print "\ntotal size= " sum/1024000" MB" "\nnumber of files= " i}
