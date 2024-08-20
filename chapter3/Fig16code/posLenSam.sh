awk '{ if ($0 ~ /^@/) next; print $4, substr($6,1,length($6)-1) }' $1
