From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Subject: Very strange data loss with jsm driver
Date: Fri, 29 Jul 2011 12:04:16 -0400
Message-ID: <20110729160416.GK8562@caffeine.csclub.uwaterloo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Len Sorensen <lsorense@csclub.uwaterloo.ca>, linux-kernel@vger.kernel.org, Breno Leitao <leitao@linux.vnet.ibm.com>
List-Id: linux-serial@vger.kernel.org

I discovered a strange situation where the jsm driver discards the
majority of transmit data.

I have two text files.

The first file consists of 9100 lines of:
0123456789<newline>
Total 100100 bytes.

The second file consists of 100 lines of:
01234567890123456789.....0123456789<newline> (1000 character line)
Total 100100 bytes.

The first file transmits instantly, with the receiving end getting
approximately 100 bytes of the data.

The second file sends in about 1 minute and 40 seconds at 9600 baud
(the speed doesn't affect the behaviour in any noticeable way) as one
would expect, and the other end sees all the data.

The trigger point appears to be lines of up to 14 bytes, followed by
a newline.  With 15 bytes or more per line it seems to be OK.

Anyone got a clue?

I was testing on 3.0.0.  Same on 2.6.32.

3.0.0 unfortunately no longer has port statistics on the jsm driver in
/proc/tty/driver/jsm making it hard to see what the driver believes is
going on, it seems 2.6.37 broke that with some serial cleanup.
I am cleaning up a patch to fix that.

-- 
Len Sorensen
