class repo {
  
  $repotitle   = hiera('repotitle')
  $reponame    = hiera('reponame')
  $repobaseurl = hiera('repobaseurl')
  $repogpgkey  = hiera('repogpgkey')

  File {
    ensure => file,
    mode   => '644',
    owner  => root,
    group  => root,
  }

  if ::operatingsystem == 'centos' {
    file { "/etc/yum.repo.d/$repotitle.repo":
      content => repo/el.repo.erb,
  }
  else {
    fail('Not supported')
  }
