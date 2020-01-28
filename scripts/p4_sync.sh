#!/bin/bash
# Script to sync perforce path by taking path as an argument

user=$P4USER
p4path=/usr/bin/p4
pass=$P4PASSWD

encoding=$P4CHARSET
server=$P4PORT
client=$P4CLIENT

timestart=$(date +%T)

printf $pass | $p4path -u $user -p $server -C $encoding login

# check if file path is legit
pathtest=$($p4path -u $user -p $server -C $encoding files -m 1 $1 2>&1)

if grep -q "no such file" <<<$pathtest; then
  exit 1
fi

# if legit, p4 sync -N to get some stats since last sync
update=$($p4path -u $user -c $client -C $encoding -p $server -Zproxyload sync -N $1 2>&1)

#echo update:$update
echo p4 proxy caching: $1
echo $update

result=$($p4path -u $user -c $client -C $encoding -p $server -Zproxyload sync -q -p $1 2>&1)

echo Result: $result
echo Time Start: $timestart
echo Time End:   $(date +%T)
