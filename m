From: "Eric Malkowski" <eric@bvwireless.net>
Subject: Sysbas 16C1052 PCI single chip UART
Date: Wed, 1 Dec 2010 23:19:55 -0500 (EST)
Message-ID: <57523.76.118.81.154.1291263595.squirrel@slice.bvwireless.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from slice.bvwireless.net ([173.45.243.123]:54792 "EHLO
	slice.bvwireless.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756854Ab0LBEZk (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 1 Dec 2010 23:25:40 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: eric@bvwireless.net

Hi all-

The mini-pci boards I've been using from Artila with genuine Oxsemi 16C950 quad
UART to get 2 x RS-422 ports capable of 460800 bps (and 2 x RS232 I don't use)
have gone end of life and I'm struggling with getting a board I found from a
supplier in the UK that has a Sysbas 16C1052PCI UART yielding 2 x RS422 that can
do up to 921600 bps.

This board is a single chip w/ PCI and uarts all in one that is essentially the
16C1052 chip and 2 RS422/485 transceivers and that's it -- very simple.

They have a CD that comes with 2.4 and 2.6 kernel source that is GPL -- it's a
deal where they basically clone the existing serial driver to build their own
kernel module w/ separate data structures and supporting modified standard linux
serial driver code (not the best -- I would rather see them get the standard
driver working or keep a patch against the standard driver).  I built up the 2.4
driver against a 2.4.29 target I have (a bit old but stable) on x86 hardware and
it compiles clean, goes in, but test code I write shows chars transmitting
according to /proc/tty/driver/multiport (their version of
/proc/tty/driver/serial) but nothing on a scope monitoring the differntial
between Tx+ and Tx- on two scope channels.

I also have a newer 2.6.28.4 target and tried building their 2.6 driver.  That
driver was based on 2.6.19 ish serial driver code where the uart_port structure
was moved a level deeper in an interim struct (I think), so I had to change a
bunch of pointers to be compatible with the data structure changes.  Then I
found some locking (the BUG_ON(!kernel_locked()); code in ioctl, break_ctl
functions and friends were removed between 2.6.19 and 2.6.28.4 -- these were
causing a seg fault panic when the BUG_ON would execute upon ioctl to setup a
port, so I removed those in doing a comparison in the standard serial_core code.
 The driver would insert fine and show the ttys and custom SB16C1050 UART listed
along with /proc/tty/driver/multiport, but with this one it wouldn't even show
chars as being accounted as transmitted in the /proc/tty/driver/multiport tx
count listing.

So I broke down and put the card in a windows laptop to at least see if the
hardware works, and it works fine with a 4 wire RS-422 null setup between the
two ports on the card at 460800 bps.

My questions are -- does anyone here have any experience with any sysbas UARTs?
-- especially in convincing the standard serial driver to work.  It's 16550
compatible with many of the extensions that look like oxsemi 950 with the
"pages" of registers where you write a special key to the LCR I think or
something to that effect.  It's got at PCI BAR0 a set of 16 registers that are
the 8 standard 16550 compatible regs for ports 1 and 2 each.  Then at PCI BAR1
there are "option registers" that have convenience things to read the speed of
the oscillator (14.7452 mhz for this one to do up to 921600 bps) and to read how
many ports and the revision of it.  Also it can read the status of jumpers that
select 485 or 422 and some global IRQ source data and IRQ enable/disable IIRC. 
Lastly, the PCI BARs identify the UART regs and option regs as I/O port
addresses, not MMIO.  I think I get 0x1440 for the 2 x 8 regs for the UARTs and
0x1480 for the option regs.

The datasheet can be acquired from their website:

http://eng.sysbas.com/e-support/default.asp?sNum=downloads&category=51

In case any of you are curious.
I think you have to be a "member" to download the reference drivers they have. 
The UK manufacturer that made the board (note they didn't put a serial eeprom to
customize the PCI configuration space -- it's just the sysbas chip and 2
transceivers and various caps/resistors to put it on a mini-pci card!) sent a CD
with Linux 2.4, 2.6 source of their IMHO hacked serial drivers and some windows
drivers.  I have to give them credit for at least distributing the linux driver
as sourcecode -- it's just that neither worked for me!  I can make the
sourcecode available if anyone here wants to look.

I will probably spend some time with datasheet and standard serial driver source
and see if I can get it working that way.  If I have success I will post
results.  The usual adding of PCI vendor/device ID to the list with proper
pbn_b0_2_921600 entry detects them as ST16650 but my testing reveals no IRQs
occur so it doesn't know about tx empty to get the data going out off the IRQ
handler.  Their 2.4 driver was showing IRQs happening at least in
/proc/interrupts when the ports were open and stats showing tx count going up,
but nothing on my scope.  So it's close, but still not working.

Any thoughts or especially experiences with these UARTs shared would be
appreciated.

--
Eric Malkowski

