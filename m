From: "Stuart MacDonald" <stuartm@connecttech.com>
Subject: Re: UART not generating MSR-change (or any) interrupt
Date: Tue, 25 Jun 2002 09:01:28 -0400
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <003b01c21c48$6b543920$294b82ce@connecttech.com>
References: <200206242137.12029.u.hertlein@sandbox.in-berlin.de>
Return-path: <linux-serial-owner@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org
To: Ulrich Hertlein <u.hertlein@sandbox.in-berlin.de>, linux-serial@vger.kernel.org

From: "Ulrich Hertlein" <u.hertlein@sandbox.in-berlin.de>
> UART of the requested port. For I/O base and IRQ 'setserial' reports the
> expected standard values (COM1=0x3f8,IRQ=4 COM2=0x2f8,IRQ=3 ...) and I'm
[snip]
> IRQ=3,COM2.

Motherboard serial ports are generally still handled as ISA devices;
they cannot share interrupts. I suspect that your uart is generating
interrupts that are getting caught by the serial driver, which is
ignoring them since it doesn't know about your hardware. Try
# setserial uart none /dev/ttyS1
(synatx may be off slightly), to remove the conflict.

..Stu


