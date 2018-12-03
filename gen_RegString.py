#!/usr/bin/env python
# -*- coding: utf-8 -*-

d_Len = 254;


def out_reg_str():
   x = d_Len
   list = []
   num = 0
   for i in range(x):
       if num < 10:
        list.append(num)
        num += 1
        print num
       else:
        num = 0
        print num
        list.append(num)

    map(str,list)
    reg_str = ','.join(list)
    print reg_str

print out_reg_str();
