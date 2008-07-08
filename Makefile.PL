use inc::Module::Install;

name 'HTML-MobileJp-Filter';
all_from 'lib/HTML/MobileJp/Filter.pm';

requires 'Moose';
requires 'Moose::Role';
requires 'Class::Trigger';
requires 'Class::MOP';
requires 'HTTP::MobileAgent';

requires 'Encode';
requires 'Encode::JP::Mobile';
requires 'Encode::JP::Mobile::Charnames';
requires 'HTML::DoCoMoCSS';
requires 'HTML::StickyQuery::DoCoMoGUID';
requires 'HTML::Entities::ConvertPictogramMobileJp';
requires 'YAML';

build_requires 'Test::More';
build_requires 'Test::Base';
build_requires 'HTTP::MobileAgent';

use_test_base;
auto_include;

WriteAll;
