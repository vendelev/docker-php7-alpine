<?php

function test($server, $keys, $value, $withSet=true) {
    print "Test ". $server['host'] ." start \n";
    $tmp = new Memcached();
    $tmp->addServer($server['host'], $server['port']);

    if ($withSet) {
//        $tmp->flush();

        $cnt = 0;
        $time = microtime(true);
        foreach ($keys as $key) {
            if (!$tmp->set($key, $value, 3600)) {
                $cnt++;
            }
        }
        if ($cnt) {
            print 'Error: ' . $tmp->getResultMessage() . "\n";
        }
        print 'Set time: ' . (microtime(true) - $time) . "\n";
        print 'Fail set: ' . $cnt . "\n";
    }

    $cnt  = 0;
    $time = microtime(true);
    foreach ($keys as $key) {
        if (!$tmp->get($key)) {
            $cnt++;
        }
    }
    if ($cnt) {
        print 'Error: '.$tmp->getResultMessage() . "\n";
    }
    print 'Get time: '. (microtime(true) - $time) ."\n";
    print 'Fail get: '. $cnt ."\n";
}

if (!is_file('./keys.php')) {
    $keys = [];
    for ($ii = 0; $ii < 100000; $ii++) {
        $keys[] = md5(microtime());
    }

    file_put_contents('./keys.php', '<?php return '. var_export($keys, true) .';');
} else {
    $keys = require './keys.php';
}

$value = serialize(array_fill(0, 2200, '*@Y$RmU@HR*h1n837h8f716n87ch4r8n71h238h74182c3h4zm1h3'));

//test(['host' => 'memcached', 'port' => 11211], $keys, $value, false);
//test(['host' => 'tarantool', 'port' => 11311], $keys, $value, false);
test(['host' => 'memcached', 'port' => 11211], $keys, $value);
test(['host' => 'tarantool', 'port' => 11311], $keys, $value);
