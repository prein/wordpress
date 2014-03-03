#
#
#

wp_databag_secret = Chef::EncryptedDataBagItem.load_secret(node['wordpress']['secretpath'])
config = Chef::EncryptedDataBagItem.load(node['wordpress']['configuration-data-bag'], node['fqdn'], wp_databag_secret)

node.default['wordpress']['parent_dir'] = "/var/www/vhosts/#{config['domain']}"
node.default['wordpress']['dir'] = "/var/www/vhosts/#{config['domain']}/public_html"

wp_conf = config['wp']
wp_conf.each do |param, value|  
  node.default['wordpress'][param] = value 
end

mysql_conf = config['mysql']
mysql_conf.each do |param, value|  
  node.set['mysql'][param] = value 
end
