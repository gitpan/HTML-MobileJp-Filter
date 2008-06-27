use inc::Module::Install;

name 'HTML-MobileJp-Filter';
all_from 'lib/HTML/MobileJp/Filter.pm';

requires 'Class::Trigger';
requires 'UNIVERSAL::require';
requires 'HTTP::MobileAgent';

requires 'Encode';
requires 'Encode::JP::Mobile';
requires 'HTML::DoCoMoCSS';
requires 'HTML::StickyQuery::DoCoMoGUID';
requires 'HTML::Entities::ConvertPictogramMobileJp';

build_requires 'Test::More';
build_requires 'Test::Base';

use_test_base;
auto_include;

WriteAll;
