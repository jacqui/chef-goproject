name             'goproject'
maintainer       'Jacqui Maher, The New York Times'
maintainer_email 'jacqui.maher@nytimes.com'
license          'Apache'
description      'installs a goproject along with any dependencies using git'
depends         'apt'
depends         'build-essential'
depends         'git'
depends       'golang'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.4'
