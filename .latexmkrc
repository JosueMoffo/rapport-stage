$clean_ext .= ' %R.gls %R.glo %R.glg %R.acr %R.acn %R.alg';

add_cus_dep('glo', 'gls', 0, 'run_makeglossaries');
add_cus_dep('acn', 'acr', 0, 'run_makeglossaries');

sub run_makeglossaries {
  my $dir = dirname($_[0]);
  my $base = basename($_[0]);
  if ($dir eq '.') {
    system("makeglossaries '$base'");
  } else {
    system("makeglossaries -d '$dir' '$base'");
  }
}