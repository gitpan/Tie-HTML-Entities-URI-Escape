use ExtUtils::MakeMaker;

WriteMakefile(
    'PM' => {
       'Entities.pm'  => '$(INST_LIBDIR)/Tie/HTML/Entities.pm',
       'Escape.pm'    => '$(INST_LIBDIR)/Tie/URI/Escape.pm',
     },
    'NAME'		=> 'Tie-HTML-Entities+URI-Escape',
    'VERSION_FROM'	=> 'Entities.pm',
    'PREREQ_PM'		=> {
      'HTML::Entities'  => 0,
      'URI::Escape'     => 0,
    },
);
