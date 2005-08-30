From: malk@sidehack.sat.gweep.net
Subject: Exar XR17D158 UART on PCI versus 16550 ISA bus performance
Date: Tue, 30 Aug 2005 16:59:47 -0400 (EDT)
Message-ID: <20050830205947.98199.qmail@sidehack.sat.gweep.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from sidehack.sat.gweep.net ([204.145.148.154]:5863 "HELO
	sidehack.sat.gweep.net") by vger.kernel.org with SMTP
	id S932468AbVH3U7s (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 30 Aug 2005 16:59:48 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: malk@gweep.net

Hi Ted and linux-serial list:

I've seen your name around linux since 1993 and I know you're the serial
driver designer, so I was hoping you could shed some light on a question.

I've got a PC104 computer w/ an 8 port RS422/232 serial board (on the ISA
bus) built on 2 x Exar 16654 UARTS (4 channels each) that have port
addresses they occupy w/ the standard 8 bytes of registers per port.

For testing I've connected ports 1 & 2, 3 & 4, 5 & 6, and 7 & 8 together
w/ null modems.

I have my kernel ticking w/ HZ at 1000 to get 1ms select() timeouts in my
app.  If I send 16 byte messages every millisecond down each port and read
them back on the opposing port, I can run 4 senders and 4 receivers and
things work pretty well.  More than 4 ports in use (both directions)
causes things to get sluggish.  I'm running the ports at 460 kbps and I've
got the low_latency setting active in the driver.  The FIFO triggers are
at 56 bytes on the receive side and 8 bytes on the transmit side.  I'm
using a 2.4.29 kernel and it's a uclibc based embedded setup.

I found the bottleneck seems to be the time it takes to read a register
from a port.  i.e. reading the LSR and RHR each take about 2 microsends
per read.  To determine this I wrote a small kernel module that just does
this in the module_init:

do_gettimeofday(starttime)

for(i=0; i<1000; i++)
{
   x = inb(0x105);  /* first port LSR */
   y = inb(0x100);  /* first port RHR */
}

do_gettimeofday(endtime)
printk(delta endtime - starttime)

It takes about 4000 microseconds for the above to complete.

What I was hoping is if I migrate to another board that is PCI based (with
exar XR17D158 UART), the above would be much faster since the PCI port reads
should be quicker than the ISA bus reads.  The XR17D158 have PCI config
space and the ability to do memory mapped I/O.  It also has this nice
feature of doing bursts by extended registers that give the rx and tx
fifo counts and 64 bytes of memory mapped area to read in 8, 16, or 32
bit chunks.  I'm hoping just the stock 2.4 serial driver (possibly 
tweeked a bit to use the memory mapped I/O and tell the driver where
all the registers are) doing normal 16550 backward compatible accesses
will be enough to do 8 ports.

The CPU board I've got has a macphyter ethernet natsemi DP83815 that is a
PCI device.  It's registers can be accessed via memory mapped I/O (the
driver does this) or via port addresses (in this case it sits at i/o port
0x1000).

If I have the same code above read a status register from port 0x1004, it
takes less than 1000 microseconds to do all the reads (about 0.2
microseconds per read).

Do you think the PCI based serial board will be able to read LSR and RHR
regs much quicker yielding the ability to possibly use all 8 ports w/o
saturating the board?  If the PCI serial board does 0.2 microsecond reads
in stead of the 2 microsecnd reads the ISA version does, then it's a
10-fold improvement and therefore ten times better performance of reading
chars off the UART at softirq port servicing time.

Granted there's a lot of interrupts happening when exercising the ports,
but I would think spending less time per interrupt would make things
better.  If the UART somehow will still make reads take 2 microseconds
even though it's on a faster bus, it won't improve -- I just don't know as
I don't have hardware to try it with.

The CPU is 400mhz VIA 686 class processor.

Any thoughts would be greatly appreciated.

Thanks,

-Eric Malkowski
