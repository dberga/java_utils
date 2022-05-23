use Unicode::String;

Unicode::String->stringify_as( 'utf8' ); # utf8 already is the default

my $string_iso_8859_1 = "This is latin text.";

my $string_utf8 = Unicode::String::latin1( $string_iso_8859_1 );

# $string_utf8 is now string_iso_8859_1 encoded as UTF-8

print $string_utf8;