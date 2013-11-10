define dns::record (
  $zone,
  $host,
  $data,
  $record = 'A',
  $dns_class = 'IN',
  $ttl = '',
  $preference = false,
  $order = 9
) {

  $zone_file = "${dns::server::params::cfg_dir}/zones/db.${zone}"

  concat::fragment{"db.${zone}.${name}.record":
    target  => $zone_file,
    order   => $order,
    content => template("${module_name}/zone_record.erb")
  }

}
