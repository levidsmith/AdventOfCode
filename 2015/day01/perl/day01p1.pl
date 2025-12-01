#2025 Levi D. Smith

open(f, "../input01.txt");
while($strLine = <f>) {
#  print "$strLine\n";
  chomp($strLine);
  @chars = split(//, $strLine);
  $iValue = 0;
  foreach my $c (@chars) {
    if ($c eq '(') {
        $iValue += 1;
    } elsif ($c eq ')') {
        $iValue -= 1;
    }
  }
  print "$iValue\n";
}
