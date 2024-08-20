#!/bin/bash


awk '{ if (NR > 1) {
print substr($0,263810,20)
print substr($0,369144,20)
print substr($0,4156088,20)
print substr($0,4362519,20)
print substr($0,17252283,20)
print substr($0,17259559,20)
print substr($0,17263973,20)
print substr($0,23441616,20)
print substr($0,27094512,20)
print substr($0,30320549,20)
print substr($0,33192146,20)
print("\n\n14:\n")
}
}' gChr22.fa


awk '{ if (NR > 1) {


print "2073750 "  substr($0,2073750,20)
print "6782970 "  substr($0,6782970,20)
print "7169017 "  substr($0,7169017,20)
print "9450027 "  substr($0,9450027,20)
print "16767177 "  substr($0,16767177,20)
print "16820628 "  substr($0,16820628,20)
print "16827013 "  substr($0,16827013,20)
print "17963555 "  substr($0,17963555,20)
print "18924956 "  substr($0,18924956,20)
print "27094504 "  substr($0,27094504,20)
print "33379707 "  substr($0,33379707,20)
print "42200206 "  substr($0,42200206,20)
print "55999982 "  substr($0,55999982,20)
print "65995361 "  substr($0,65995361,20)
print "71973360 "  substr($0,71973360,20)
print "74671174 "  substr($0,74671174,20)
print "80525718"  substr($0,80525718,20)
print "88212900"  substr($0,88212900,20)
print "90862466"  substr($0,90862466,20)
print "98128236"  substr($0,98128236,20)
print "98727489"  substr($0,98727489,20)

}
}' gChr14.fa

