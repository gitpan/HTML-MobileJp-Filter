use Test::More;
eval q{ use Test::Spelling };
plan skip_all => "Test::Spelling is not installed." if $@;
add_stopwords(map { split /[\s\:\-]/ } <DATA>);
$ENV{LANG} = 'C';
all_pod_files_spelling_ok('lib');
__DATA__
Naoki Tomita
tomi-ru
CPAN
DTD
DoCoMo
PictogramFallback
TODO
TypeCast
XML
freenode
html
irc
params
API
