From: Russell Shaw <rjshaw@netspace.net.au>
Subject: NetMos Technology PCI 9835
Date: Sat, 05 Feb 2005 23:48:56 +1100
Message-ID: <4204C0B8.5000507@netspace.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Received: from thunder.netspace.net.au ([203.10.110.71]:26120 "EHLO
	mail.netspace.net.au") by vger.kernel.org with ESMTP
	id S263751AbVBEMly (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Sat, 5 Feb 2005 07:41:54 -0500
Received: from [192.168.1.11] (220-253-27-139.VIC.netspace.net.au [220.253.27.139])
	by mail.netspace.net.au (Postfix) with ESMTP id EE77E431E5
	for <linux-serial@vger.kernel.org>; Sat,  5 Feb 2005 23:41:49 +1100 (EST)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Hi,
I compiled in the parport and serial port options in menuconfig for the above dual serial card. 
kernel 2.6.10 on debian-sid, athlon MB.

It still won't work:(

lspci -vv -s 0:b.0 shows:

0000:00:0b.0 Serial controller: NetMos Technology PCI 9835 Multi-I/O Controller (rev 01) (prog-if 02 
[16550])
         Subsystem: LSI Logic / Symbios Logic 2S (16C550 UART)
         Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- 
<PERR-
         Interrupt: pin A routed to IRQ 19
         Region 0: I/O ports at cc00 [size=8]
         Region 1: I/O ports at d000 [size=8]
         Region 2: I/O ports at d400 [size=8]
         Region 3: I/O ports at d800 [size=8]
         Region 4: I/O ports at dc00 [size=8]
         Region 5: I/O ports at e000 [size=16]

Is that IRQ 19 real or bogus?

I tried: setserial /dev/ttyS2 port 0xdc00 uart 16550 irq 19
then: cat test > /dev/ttyS2

with various port and irq settings, but the command blocks for 10secs
then returns.
