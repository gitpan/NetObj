use ExtUtils::MakeMaker;

WriteMakefile (
    NAME => 'NetObj',
    DISTNAME => 'NetObj',
    VERSION_FROM => 'NetObj.pm',
    'dist' => {COMPRESS=>'gzip',SUFFIX=>'gz'}
);
