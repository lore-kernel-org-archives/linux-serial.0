From: Erwin Volz <erwvolz@bluewin.ch>
Subject: ttyS4 to ttyS7 take over addresses from parallel port on VScom 210L
Date: Sat, 31 Dec 2005 12:45:51 +0100
Message-ID: <200512311245.52634.erwvolz@bluewin.ch>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail16.bluewin.ch ([195.186.19.63]:50398 "EHLO
	mail16.bluewin.ch") by vger.kernel.org with ESMTP id S1751078AbVLaLp1
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Sat, 31 Dec 2005 06:45:27 -0500
Received: from vserv.lokales-netz.de (83.77.173.185) by mail16.bluewin.ch (Bluewin 7.2.069.1)
        id 43926165005DE161 for linux-serial@vger.kernel.org; Sat, 31 Dec 2005 11:45:26 +0000
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Hello

My box is equiped with a Titan Electronics VScom 210L card, which contains 2 
serial ports and one parallel port. Now I was unable to use the parallel port, 
because serial had already taken over all resources from the parallel port on 
the card.

First some information about the card, gained with lspci --vv:

00:0d.0 Serial controller: Titan Electronics Inc VScom 210L 2 port serial and 
1 port parallel adaptor (prog-if 02 [16550])
        Subsystem: Titan Electronics Inc VScom 210L 2 port serial and 1 port 
parallel adaptor
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 5
        Region 0: I/O ports at b400 [size=8]
        Region 1: I/O ports at b800 [size=8]
        Region 2: I/O ports at bc00 [size=8]
        Region 3: I/O ports at c000 [size=8]
        Region 4: Memory at dc004000 (32-bit, non-prefetchable) [size=64]

The ports at b400 and b800 are serial ports, whereas the bc00 and c000 are the 
two (low, high) address of the parallel port.

In /var/log/boot.msg I found the following information:

***********snip**********************
<6>isapnp: Scanning for PnP cards...
<6>isapnp: No Plug & Play device found
<6>Real Time Clock Driver v1.12
<6>PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
<6>serio: i8042 AUX port at 0x60,0x64 irq 12
<6>serio: i8042 KBD port at 0x60,0x64 irq 1
<6>Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing enabled
<4>ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
<4>ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
<4>ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
<4>ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
<4>ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 5
<4>PCI: setting IRQ 5 as level-triggered
<6>ACPI: PCI Interrupt 0000:00:0d.0[A] -> Link [LNKA] -> GSI 5 (level, low) -> 
IRQ 5
<4>ttyS4 at I/O 0xb400 (irq = 5) is a 8250
<6>io scheduler noop registered
***********snip**********************

Actually there are 4 serial ports on the box: first the two standard one's at 
3f8 and 2f8 and then the two at b400 and b800 on the VScom-card.
Now I was able to but things right for the serial ports that are really there, 
using setserial:

setserial -g /dev/ttyS*
/dev/ttyS0, UART: 16550A, Port: 0x03f8, IRQ: 4
/dev/ttyS1, UART: 16550A, Port: 0x02f8, IRQ: 3
/dev/ttyS2, UART: 16550A, Port: 0xb400, IRQ: 5, Flags: Fourport
/dev/ttyS3, UART: 16550A, Port: 0xb800, IRQ: 5, Flags: Fourport
/dev/ttyS4, UART: 8250, Port: 0xb400, IRQ: 5
/dev/ttyS5, UART: unknown, Port: 0xb800, IRQ: 5
/dev/ttyS6, UART: unknown, Port: 0xbc00, IRQ: 5
/dev/ttyS7, UART: unknown, Port: 0xc000, IRQ: 5

The devices from ttyS0 to ttyS3 are correct and really there, but I wonder 
about ttyS4, which already appeared in boot.msg.
Especially ttyS6 and ttyS7 are strange, because the have taken the addresses 
belonging to the parallel port. Therefore parport is unable to get his ports 
on the card.

In /proc I found similar information as from setserial:
cat /proc/tty/driver/serial
serinfo:1.0 driver revision:
0: uart:16550A port:000003F8 irq:4 tx:0 rx:0
1: uart:16550A port:000002F8 irq:3 tx:0 rx:0
2: uart:16550A port:0000B400 irq:5 tx:0 rx:0
3: uart:16550A port:0000B800 irq:5 tx:0 rx:0 DSR
4: uart:8250 port:0000B400 irq:5 tx:0 rx:0
5: uart:unknown port:0000B800 irq:5
6: uart:unknown port:0000BC00 irq:5
7: uart:unknown port:0000C000 irq:5

Personally I have found a solution that works with my box: I just used 
setserial again to change ttyS4 ... ttyS7, so they don't use the addresses 
belonging to the parallel port. (I was unable just to get rid of them.) Now 
the output of setserial looks like this:

setserial -g /dev/ttyS*
/dev/ttyS0, UART: 16550A, Port: 0x03f8, IRQ: 4
/dev/ttyS1, UART: 16550A, Port: 0x02f8, IRQ: 3
/dev/ttyS2, UART: 16550A, Port: 0xb400, IRQ: 5, Flags: Fourport
/dev/ttyS3, UART: 16550A, Port: 0xb800, IRQ: 5, Flags: Fourport
/dev/ttyS4, UART: unknown, Port: 0x0000, IRQ: 3
/dev/ttyS5, UART: unknown, Port: 0x0000, IRQ: 3
/dev/ttyS6, UART: unknown, Port: 0x0000, IRQ: 3
/dev/ttyS7, UART: unknown, Port: 0x0000, IRQ: 3

As I'm not using ttyS4 ... ttyS7 I hope this should be no problem. But I don't 
like the look of it, but at least in this way I'm able to use the parallel 
port. 

Is there a more intelligent way to solve this problem?

Erwin

NB. Im using a 2.6.13-Kernel

