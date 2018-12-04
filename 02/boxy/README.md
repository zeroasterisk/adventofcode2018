# Boxy

```
$ mix boxy_1 test.txt
Found 4 w/ 2 & 3 w/ 3
4 * 3 = 12

$ mix boxy_1 input.txt
Found 247 w/ 2 & 26 w/ 3
247 * 26 = 6422

$ mix boxy_2 test2.txt
Found fgij

$ mix boxy_2 input.txt
Found qcslyvphgkrmdawljuefotxbh
```

I did this on day 4, just to catch up.

In part 2, I cheated like a mofo and used `String.myers_difference`
for calculating string delta, and compared the results.
