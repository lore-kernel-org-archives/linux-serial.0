From: "Lee Howard" <lee.howard@mainpine.com>
Subject: RE: Mainpine IQ Express Rev3 problems beginning 2.6.36
Date: Tue, 14 Dec 2010 11:49:34 -0800
Message-ID: <E2D1FFBE046E485284F82CC8135FD901@callisto>
References: <4D001AF1.80902@mainpine.com> <20101209064259.GA10714@kroah.com> <9BEA64D1D71A4BCFA22E0ECE7A4B3A01@callisto> <20101212165201.GB14184@kroah.com>
Reply-To: <lee.howard@mainpine.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from pandora.howardsilvan.com ([216.235.106.114]:49433 "EHLO
	mail.mainpine.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756853Ab0LNTtf (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 14 Dec 2010 14:49:35 -0500
In-Reply-To: <20101212165201.GB14184@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: 'Greg KH' <greg@kroah.com>
Cc: linux-serial@vger.kernel.org

> -----Original Message-----
> From: Greg KH [mailto:greg@kroah.com] 
> Sent: Sunday, December 12, 2010 8:52 AM

> As for build issues, try to make a minimal working config for 
> your system, using 'make localmodconfig'.  That will speed up 
> your build time immensely as well as reduce your chances of 
> build and runtime problems with the intermediate kernels.

Thank-you, that did help immensely.

Here's the 'git bisect' result...

--------------
7a56aa45982bb87bfca98a2832b5ae782c03364a is the first bad commit 
commit 7a56aa45982bb87bfca98a2832b5ae782c03364a
Author: Yegor Yefremov <yegor_sub1@visionsystems.de>
Date:   Wed Jun 16 16:29:55 2010 +0200

    serial: add UART_CAP_EFR and UART_CAP_SLEEP flags to 16C950 UARTs
definition
    
    Adding UART_CAP_EFR and UART_CAP_SLEEP flags will enable sleep mode
    and automatic CTS flow control for 16C950 UARTs. It will also avoid
    capabilities detection warning like this:
    
    "ttyS0: detected caps 00000700 should be 00000100"
    
    Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
    Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

:040000 040000 1776ca8d5c653834363c0778b5b404ee52bd2d69
b81cfe4f302a674935181bd248641873820517e5 M      drivers
--------------

Indeed, if I remove the UART_CAP_EFR flag from later kernel revisions there
is no problem.

Here is the 'dmesg' output for 8250 after removing UART_CAP_EFR...

--------------
[    0.980209] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
[    1.245280] serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
[    1.266813] 00:09: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
[    1.266936] serial 0000:02:00.0: PCI INT A -> GSI 18 (level, low) -> IRQ
18
[    1.266954] 1 ports detected on Oxford PCI Express device
[    1.267029] ttyS4: detected caps 00000700 should be 00000500
[    1.267043] 0000:02:00.0: ttyS4 at MMIO 0xfd5fd000 (irq = 18) is a
16C950/954
[    1.267095] serial 0000:03:00.0: PCI INT A -> GSI 16 (level, low) -> IRQ
16
[    1.267105] 4 ports detected on Oxford PCI Express device
[    1.267175] ttyS5: detected caps 00000700 should be 00000500
[    1.267180] 0000:03:00.0: ttyS5 at MMIO 0xfc9fd000 (irq = 16) is a
16C950/954
[    1.267269] ttyS6: detected caps 00000700 should be 00000500
[    1.267274] 0000:03:00.0: ttyS6 at MMIO 0xfc9fd200 (irq = 16) is a
16C950/954
[    1.267362] ttyS7: detected caps 00000700 should be 00000500
[    1.267366] 0000:03:00.0: ttyS7 at MMIO 0xfc9fd400 (irq = 16) is a
16C950/954
[    1.267454] ttyS8: detected caps 00000700 should be 00000500
[    1.267459] 0000:03:00.0: ttyS8 at MMIO 0xfc9fd600 (irq = 16) is a
16C950/954
[    1.267505] serial 0000:04:00.0: PCI INT A -> GSI 18 (level, low) -> IRQ
18
[    1.267514] 2 ports detected on Oxford PCI Express device
[    1.267583] ttyS9: detected caps 00000700 should be 00000500
[    1.267588] 0000:04:00.0: ttyS9 at MMIO 0xfcffd000 (irq = 18) is a
16C950/954
[    1.267678] ttyS10: detected caps 00000700 should be 00000500
[    1.267683] 0000:04:00.0: ttyS10 at MMIO 0xfcffd200 (irq = 18) is a
16C950/954
[    1.267723] serial 0000:06:00.0: PCI INT A -> GSI 19 (level, low) -> IRQ
19
[    1.288452] 0000:06:00.0: ttyS11 at I/O 0xcf00 (irq = 19) is a 16550A
[    1.309208] 0000:06:00.0: ttyS12 at I/O 0xcf08 (irq = 19) is a 16550A
[    1.329963] 0000:06:00.0: ttyS13 at I/O 0xcf10 (irq = 19) is a 16550A
[    1.350723] 0000:06:00.0: ttyS14 at I/O 0xcf18 (irq = 19) is a 16550A
--------------

00:09 is the on-board serial controller, so that's ttyS1

0000:02:00.0 is a 1-port Rev3 IQ Express, that's ttyS4

0000:03:00.0 is a 4-port Rev3 IQ Express, that's ttyS5-ttyS8

0000:04:00.0 is a 2-port Rev3 IQ Express, that's ttyS9-ttyS10

0000:06:00.0 is a 4-port Rev2 IQ Express, that's ttyS11-ttyS14  (these had
no problem).

Thanks,

Lee.

