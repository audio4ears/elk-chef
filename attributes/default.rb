# java
default['java']['package'] = 'java-1.8.0-openjdk-devel'
default['java']['java_home'] = '/usr/lib/jvm/java-1.8.0'

# elasticsearch
default['elasticsearch']['version'] = '2.3.2'
default['elasticsearch']['hosts'] = []

# logstash
default['logstash']['version'] = '2.3.2'
default['logstash']['hosts'] = []
default['logstash']['plugins'] = [ 'logstash-input-beats' ]
default['logstash']['configs'] = [ 'logstash-filebeat' ]

# kibana
default['kibana']['version'] = '4.5.0'

# beats
default['beats']['install_list'] = [ 'filebeat' ]
default['beats']['filebeat']['version'] = '1.2.2'
default['beats']['filebeat']['prospectors'] = [ 'linux' ]
