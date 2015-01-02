From: James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Re: serial console problem with kernel 3.18.0-rc4
Date: Thu, 01 Jan 2015 23:26:11 -0800
Message-ID: <1420183571.2078.3.camel@HansenPartnership.com>
References: <54625FCD.3070008@gmx.de>
	  <1420076022.2085.12.camel@HansenPartnership.com>
	  <54A4D388.7040008@hurleysoftware.com>
	  <1420102329.2085.15.camel@HansenPartnership.com>
	 <1420150015.2085.3.camel@HansenPartnership.com>
	 <54A62DDF.2000506@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-parisc-owner@vger.kernel.org>
In-Reply-To: <54A62DDF.2000506@gmail.com>
Sender: linux-parisc-owner@vger.kernel.org
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: Peter Hurley <peter@hurleysoftware.com>, Helge Deller <deller@gmx.de>, linux-serial@vger.kernel.org, linux-parisc <linux-parisc@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-serial@vger.kernel.org

On Fri, 2015-01-02 at 11:04 +0530, Sudip Mukherjee wrote:
> On Friday 02 January 2015 03:36 AM, James Bottomley wrote:
> > On Thu, 2015-01-01 at 00:52 -0800, James Bottomley wrote:
> >> On Wed, 2014-12-31 at 23:56 -0500, Peter Hurley wrote:
> >>> On 12/31/2014 08:33 PM, James Bottomley wrote:
> >>>> On Tue, 2014-11-11 at 20:13 +0100, Helge Deller wrote:
> >>>>> While testing kernel 3.18-rc4 I'm facing a problem with serial console.
> >>>>>
> >>>>> I'm seeing at bootup this message:
> >>>>> [   17.724000] console [ttyS0] disabled
> >>>>> after that it's just hanging.
> >>>>>
> >>>>> It seems as if ttyS0 is somehow being reprogrammed which then disturbs the
> >>>>> serial ports on the receiver side (in my case a HP PCI Diva Serial [GSP] Multiport UART).
> >>>>> Any idea what changed between 3.17 and 3.18 which have caused this behavior ?
> >>>>> Full log below.
> >>>>>
> >>>>> Helge
> >>> I apologize that I did not see this email back in November; I was having some
> >>> email trouble at the time.
> >>>
> >>>>> serial driver: drivers/tty/serial/8250/8250_pci.c
> >>>>>
> >>>>> PCI info:
> >>>>> 00:04.1 Serial controller: Hewlett-Packard Company Diva Serial [GSP] Multiport UART (rev 03) (prog-if 02 [16550])
> >>>>>           Subsystem: Hewlett-Packard Company Device 1283
> >>>>>           Flags: medium devsel, IRQ 70
> >>>>>           Memory at ffffffff80000000 (32-bit, non-prefetchable) [size=4K]
> >>>>>           I/O ports at 0040 [size=64]
> >>>>>           Capabilities: [48] Power Management version 2
> >>>>>           Kernel driver in use: serial
> >>>>>
> >>>>>
> >>>>> dmesg after bootup:
> >>>>>
> >>>>> [   17.708000] Serial: 8250/16550 driver, 8 ports, IRQ sharing enabled
> >>>>> [   17.724000] serial 0000:00:04.1: enabling device (0142 -> 0143)
> >>>>> [   17.724000] console [ttyS0] disabled
> >>>>> [   17.880000] serial 0000:00:04.1: ttyS0 at MMIO 0xffffffff80000000 (irq = 70, base_baud = 115200) is a 16550A
> >>>>> [   17.996000] console [ttyS0] enabled
> >>>>> [   38.888000] INFO: rcu_sched detected stalls on CPUs/tasks: { 3} (detected by 1, t=5252 jiffies, g=-290, c=-291, q=2)
> >>>>> [   38.888000] Task dump for CPU 3:
> >>>>> [   38.888000] swapper/0       R  running task        0     1      0 0x00000004
> >>>>> [   38.888000] Backtrace:
> >>>>> [   38.888000]  [<0000000040200848>] vprintk_emit+0x570/0x5f8
> >>>>> [   38.888000]  [<0000000040200bdc>] printk+0x64/0x78
> >>>>> [   38.888000]  [<0000000040201fc0>] register_console+0x438/0x550
> >>>>> [   38.888000]  [<0000000040688bb8>] uart_add_one_port+0x400/0x5d0
> >>>>> [   38.888000]  [<000000004068e6d4>] serial8250_register_8250_port+0x3e4/0x448
> >>>>> [   38.888000]  [<0000000040695f44>] pciserial_init_ports+0x22c/0x2c8
> >>>>> [   38.888000]  [<0000000040696628>] pciserial_init_one+0x250/0x2e0
> >>>>> [   38.888000]  [<00000000405f3880>] pci_device_probe+0xb0/0x150
> >>>>> [   38.888000]  [<00000000406a8244>] driver_probe_device+0x204/0x570
> >>>>> [   38.888000]  [<00000000406a8728>] __driver_attach+0xe0/0x158
> >>>>> [   38.888000]  [<00000000406a4558>] bus_for_each_dev+0xd0/0x128
> >>>>> [   38.888000]  [<00000000406a76f8>] driver_attach+0x48/0x60
> >>>>> [   38.888000]  [<00000000406a6de8>] bus_add_driver+0x268/0x460
> >>>>> [   38.888000]  [<00000000406a915c>] driver_register+0x124/0x1d0
> >>>>> [   38.888000]  [<00000000405f336c>] __pci_register_driver+0x64/0x78
> >>>>> [   38.888000]  [<00000000401375e4>] serial_pci_driver_init+0x44/0x58
> >>>>>
> >>>>> [   59.084000] timer_interrupt(CPU 3): delayed! cycles 85EBC4C7D rem 2BAF83  next/now 2765C08677/276594D6F4
> >>>>> [   59.140000] bootconsole [ttyB0] disabled
> >>>>> [   59.144000] serial 0000:00:04.1: ttyS1 at MMIO 0xffffffff80000008 (irq = 70, base_baud = 115200) is a 16450
> >>>>> [   59.164000] serial 0000:00:04.1: ttyS2 at MMIO 0xffffffff80000010 (irq = 70, base_baud = 115200) is a 16550A
> >>>> I confirm this behaviour on the Mako system as well.  In my case, 3.18
> >>>> so royally screws up the serial port that even a power cycle won't
> >>>> recover the console connection to the MP (a sort of parisc equivalent of
> >>>> a BMC) and I have to go down to the machine room to physically yank the
> >>>> power from the system to power down the MP and get the console back.
> >>>> I've added a cc to linux-serial.  It looks like there are 20 non merge
> >>>> commits between 3.17 and 3.18.  I'm betting because of the MP problem
> >>>> it's got to be somewhere in the serial driver:
> >>>>
> >>>> cd92208 tty: serial: 8250_mtk: Fix quot calculation
> >>>> 716e115 serial: 8250_pci: remove rts_n override from Baytrail quirk
> >>>> 1ede7dc serial: 8250: Add Quark X1000 to 8250_pci.c
> >>>> 9137568 tty: serial: 8250_core: remove UART_IER_RDI in
> >>>> serial8250_stop_rx()
> >>>
> >>>> 59b3e89 tty: serial: 8250_core: use the ->line argument as a hint in
> >>>> serial8250_find_match_or_unused()
> >>> ^^^^^^^^^
> >>> This commit would be my first guess, but a complete dmesg up to boot
> >>> failure would be helpful in narrowing down the problem. There are about
> >>> 50 ways to initialize the 8250 port (which is part of the problem).
> >> Well, bisection says it's not this one.  Unfortunately, we crap out at
> >> this one:
> >>
> >> ae14a79 tty: serial: 8250_core: provide a function to export
> >> uart_8250_port
> >>
> >>    CC      drivers/tty/serial/8250/8250_core.o
> >> drivers/tty/serial/8250/8250_core.c: In function 'serial8250_ioctl':
> >> drivers/tty/serial/8250/8250_core.c:2857: error: 'TIOCSRS485' undeclared
> >> (first use in this function)
> >> drivers/tty/serial/8250/8250_core.c:2857: error: (Each undeclared
> >> identifier is reported only once
> >> drivers/tty/serial/8250/8250_core.c:2857: error: for each function it
> >> appears in.)
> >> drivers/tty/serial/8250/8250_core.c:2858: error: implicit declaration of
> >> function 'copy_from_user'
> >> drivers/tty/serial/8250/8250_core.c:2869: error: 'TIOCGRS485' undeclared
> >> (first use in this function)
> >> drivers/tty/serial/8250/8250_core.c:2870: error: implicit declaration of
> >> function 'copy_to_user'
> >> make[4]: *** [drivers/tty/serial/8250/8250_core.o] Error 1
> >> make[3]: *** [drivers/tty/serial/8250] Error 2
> >> make[2]: *** [drivers/tty/serial] Error 2
> >> make[1]: *** [drivers/tty] Error 2
> >>
> >> I'll work out how to fix it in the morning ... but really, having a
> >> bisectable tree is supposed to be the first rule of a maintainer.
> > OK, I managed to bisect the rest of the tree compensating for the build
> > failure.  This is the failing commit (cc's added):
> >
> > commit 2f2dafe77df2c78e189a9fa6b1879dffd06ae5a1
> > Author: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
> > Date:   Mon Sep 1 20:49:43 2014 +0530
> >
> >      serial: serial_core.c: printk replacement
> >   
> > I've confirmed by reverting against 3.19-rc2 and the system boots again.
> > This looks like a symptom of underlying problems within the dev_ print
> > helper accessors, so I'll dig further, but we'll need this reverted in
> > the meantime.
> Sure.
> can dev_print hang the machine? if dev is NULL, it will just print using 
> printk.
> in vprintk_emit(), there is an Ouch for printk recursing into itself. 
> can that be the cause?
> and, can i help you somehow to find out the root cause of this ?

It's definitely to do with dev_printk having a different call path from
printk.  I suspect one of the called functions overruns its stack.
Unless you have a stack grows up machine, there's probably no way to
reproduce (if the stack overrun suspicion is correct).  Visual
inspection might turn up a clue: it's probably an array written beyond
bounds somewhere in the call chain.

James


