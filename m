From: "Stoltenberg, Matthew" <matthew.stoltenberg@tektronix.com>
Subject: trouble with interrupts on 16C
Date: Mon, 23 Apr 2012 06:45:40 -0700
Message-ID: <E97054E47C03F64193126754E05C1C14E47C7ACF89@us-bv-m12.global.tektronix.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from ch1ehsobe002.messaging.microsoft.com ([216.32.181.182]:3370
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753786Ab2DWNpr convert rfc822-to-8bit
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 23 Apr 2012 09:45:47 -0400
Received: from mail200-ch1 (localhost [127.0.0.1])	by
 mail200-ch1-R.bigfish.com (Postfix) with ESMTP id A6CAAC015D	for
 <linux-serial@vger.kernel.org>; Mon, 23 Apr 2012 13:45:47 +0000 (UTC)
Received: from CH1EHSMHS017.bigfish.com (snatpool3.int.messaging.microsoft.com
 [10.43.68.226])	by mail200-ch1.bigfish.com (Postfix) with ESMTP id
 CD0634602B0	for <linux-serial@vger.kernel.org>; Mon, 23 Apr 2012 13:45:45
 +0000 (UTC)
Received: from tektronix.tek.com (tektronix.tek.com [128.181.6.43])	by
 igate.tek.com (8.13.8+Sun/8.13.8) with ESMTP id q3NDjh2Z021196	for
 <linux-serial@vger.kernel.org>; Mon, 23 Apr 2012 06:45:43 -0700 (PDT)
Received: from us-bv-m04.global.tektronix.net (us-bv-m04.global.tektronix.net
 [128.181.2.117])	by tektronix.tek.com (8.13.8+Sun/8.13.8) with SMTP id
 q3NDjckL018052	for <linux-serial@vger.kernel.org>; Mon, 23 Apr 2012 06:45:42
 -0700 (PDT)
Content-Language: en-US
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>

I'm having trouble with an Oxford Semiconductor UART with the part number OXPCIe952.  This is a PCI-E uart which we're using to connect to another device on our board.  The CPU we're using is based on an ARM11 MPCORE.

Here's the output from lspci:
# lspci -s 05:00.1 -v
05:00.1 Serial controller: Oxford Semiconductor Ltd Device c13d (prog-if 02 [16550])
        Subsystem: Oxford Semiconductor Ltd Device c13d
        Flags: fast devsel, IRQ 77
        Memory at 20300000 (32-bit, non-prefetchable) [size=16K]
        Memory at 20600000 (32-bit, non-prefetchable) [size=2M]
        Memory at 20800000 (32-bit, non-prefetchable) [size=2M]
        Capabilities: [40] Power Management version 3
        Capabilities: [70] Express Endpoint, MSI 00
        Capabilities: [b0] MSI-X: Enable- Count=16 Masked-
        Capabilities: [100] Power Budgeting <?>
        Kernel driver in use: serial


>From the kernel when I modprobe 8250_pci:
 [236954.361000] 1 ports detected on Oxford PCI Express device
 [236954.361000] Setup PCI port: port 0, irq 77, type 2
 [236954.365000] ttyS1: detected caps 00000700 should be 00000500
 [236954.365000] 0000:05:00.1: ttyS1 at MMIO 0x20301000 (irq = 77) is a 16C950/954


The problem I'm having is that I almost never seem to get an interrupt when there is data ready to be read.  I added a custom interrupt handler that does a printk of the iir, ier, and lsr registers after each valid interrupt.  It's very rare that I see the status register say that there is data ready to be read.  The other end is essentially a shell that echoes back every character as well as the results of a command with an error string for an invalid command.  The only data I ever get back is a small part of the error string.

We've had some luck in uboot just polling the status register as opposed to using the interrupt.  Apart from writing my own driver from scratch, is there an easy way to poll that register using the 8250 driver?

Thanks
Matt

