class repo ($repo = 'none') {

  $repopkgtrue  = hiera('repopkgtrue')
  $repopackage  = hiera('repopackage')    
  $repotitle    = hiera('repotitle')
  $reponame     = hiera('reponame')
  $repobaseurl  = hiera('repobaseurl')
  $repogpgcheck = hiera('repogpgcheck')
  $repogpgkey   = hiera('repogpgkey')

  File {
    ensure => file,
    mode   => '644',
    owner  => root,
    group  => root,
  }
  if $repo == 'none' {
    fail('Called without repo to install')
  }

  elsif $repopkgtrue == true {
    package { "$repopackage":
      ensure => present,
    }
  }

  elsif $::operatingsystem == 'centos' {
    file { "/etc/yum.repos.d/$repotitle.repo":
      content => template('repo/el.repo.erb'),
    }
  }
  else {
    fail('Not supported')
  }
}
