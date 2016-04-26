import time
import math

nb = 3000

def do_sin(nb=3000):
        for x in range(1,nb):
                a = math.sin(x)

def test():
        start = time.clock()
        for i in range(1000):
                do_sin(50000)
        end = time.clock()
        t_total = (end-start)/1000
        print "Time : %s " % t_total

if __name__ == "__main__":
        for x in range(1,5):
                test()

