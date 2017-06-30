<?php

$tmp = new Memcached();
//$tmp->addServer('memcached', 11211);
$tmp->addServer('tarantool', 11311);

$tmp->flush();

$key = md5(1567899);
$val = serialize(array_fill(0, 10000, $key));

//exit();

$time = microtime(true);
$cnt = 1;
$cnt2 = 0;
$prev = '';
for ($ii=0; $ii<60000; $ii++) {
    $key = md5($ii);
//    if (!$tmp->get($key)) {
//        $cnt2++;
//    }
    if (!$tmp->set($key, $val)) {
        $cnt++;
    } else {
        $prev = $key;
    }
//    usleep(600);
}
print $tmp->getResultMessage() ."\n";
print 'Set time: '. (microtime(true) - $time) ."\n";
print 'Fail set: '. ($cnt-1) ."\n";
//print 'Fail get: '. ($cnt2-1);

exit;
$cnt = 1;
$time = microtime(true);
for ($ii=0; $ii<100000; $ii++) {
    $key = md5($ii);
    if (!$tmp->get($key)) {
        $cnt++;
    }
}
print 'Get time: '. (microtime(true) - $time) ."\n";
print 'Miss count: '. ($cnt-1);