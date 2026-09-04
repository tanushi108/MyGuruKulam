#!/bin/bash

if(($1%15 ==0))
then
echo "tomcat"
elif (($1%3==0))
then
echo "tom"
elif (($1%5==0))
then
echo "cat"
else
echo "This number is not divisible by 3,5 and 15."
fi
