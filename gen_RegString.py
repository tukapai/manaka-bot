#!/usr/bin/env python
# -*- coding: utf-8 -*-

#import csv
import numpy as np

d_Len = 254;


def out_reg_str():
   x = d_Len;
   list = [];
   num = 0;
   for i in range (x):
      list.append(num) if num > 10 else num = 0

print out_reg_str();
