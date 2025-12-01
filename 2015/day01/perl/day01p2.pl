#2025 Levi D. Smith

open(f, "../input01.txt");
while($strLine = <f>) {
#  print "$strLine\n";
  chomp($strLine);
  @chars = split(//, $strLine);
  $iValue = 0;
  $i = 0;
  foreach my $c (@chars) {
    if ($c eq '(') {
        $iValue += 1;
    } elsif ($c eq ')') {
        $iValue -= 1;
    }
    
    if ($iValue == -1) {
      print ($i + 1);
      print "\n";
      last;
    }
    $i += 1;
  }
}
