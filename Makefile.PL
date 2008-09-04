use inc::Module::Install;

name 'HTML-MobileJp-Filter';
all_from 'lib/HTML/MobileJp/Filter.pm';

requires 'Moose' => 0.55;
requires 'Moose::Role';
requires 'Class::Trigger';
requires 'Class::MOP';
requires 'XML::LibXML';

requires 'Encode' => 2.25;
requires 'Encode::JP::Mobile' => 0.25;
requires 'Encode::JP::Mobile::Charnames';
requires 'HTML::DoCoMoCSS';
requires 'HTML::StickyQuery::DoCoMoGUID';
requires 'HTML::Entities::ConvertPictogramMobileJp';
requires 'YAML';

test_requires 'Test::More';
test_requires 'Test::Base';
test_requires 'HTTP::MobileAgent';

use_test_base;
auto_include;

WriteAll;
