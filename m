From: Joachim Buermann <jbuermann@zes.com>
Subject: Fw: Delivery unsuccesful: Delivery problems
Date: Tue, 18 Feb 2003 12:06:32 +0100
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <20030218120632.3ac769bb.jbuermann@zes.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from inv1253.zes.com (217.0.55.175)
          by websrvnt02 with MERCUR-SMTP/POP3/IMAP4-Server (v3.10.18 AS-0098309)
          for <linux-serial@vger.kernel.org>; Tue, 18 Feb 2003  12:11:18 +0100
Received: from inv1253.zes.com (localhost [127.0.0.1])
	by inv1253.zes.com (Postfix) with ESMTP id CE2E61F3B1
	for <linux-serial@vger.kernel.org>; Tue, 18 Feb 2003 12:06:33 +0100 (CET)
Received: from inv1428.zes.com (inv1428.zes.com [192.168.2.28])
	by inv1253.zes.com (Postfix) with SMTP id 306341F3A8
	for <linux-serial@vger.kernel.org>; Tue, 18 Feb 2003 12:06:33 +0100 (CET)
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Hallo all,

I`m using linux mandrake kernel 2.4.19 on a 2 GHz Pentium 4 with 128
MByte RAM. The serial port /dev/cua0 is connected to a external device
and receives data with 115200 Baud.

Unfortunatelly I get a lot of fifo overruns. I have unmasked the hda
interrupts with:

hdparm -u1 /dev/hda

also set the low_latency flag in the serial driver. The harddisk dma
couldn't disabled.

I'm wonder at this behaviour, because with a lower machine (Pentium I
120 MHz, Kernel 2.2.13) I get overruns only once in a blue moon. And I
expected, that a 2 GHz machine should be quick enough, to responds to
the serial interrupts.

Additional to this I tried a PCI card with a 16950 (128 Byte fifo!) and
set the uart with the setserial command. But also here a lot of
overruns!!!

>From a embedded linux project (ELAN SC520 133MHz, kernel 2.2.19) I know,
that the harddisk type influence the serial communication. So I got
overruns after I changed the original drive with a newer one (the first
was a old IBM with 500MByte, the newer a IBM with 20GByte). Last not
least I must replace the linux kernel with a realtime linux (rtlinux)
and do the serial communication in a realtime handler.

Because I didn't want to replace my desktop machine with a realtime
linux, I'm looking for some hints to solve this problems.

What's about irqtune? I'm know this tool only with kernels up to 2.2.x.
Is there a bug in the serial driver (I didn't found any hints in the
mailing list or with google)?

Should I change the PCI interrupts in the BIOS to set the interrupt
priority?

I don't know anymore. Please help.

Many thanks in advance and sorry for my bad english

Joachim
