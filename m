From: "Antti S. Lankila" <alankila@bel.fi>
Subject: Individual Computers' Catweasel card incorrectly detected by serial
 driver
Date: Sat, 08 Dec 2007 17:08:17 +0200
Message-ID: <475AB361.5010404@bel.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from zeus.bel.fi ([83.145.195.130]:54623 "EHLO zeus.bel.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751473AbXLHQCn (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Sat, 8 Dec 2007 11:02:43 -0500
Received: from bacchus.bel.fi ([83.145.195.129] helo=[192.168.10.30])
	by zeus.bel.fi with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.67)
	(envelope-from <alankila@bel.fi>)
	id 1J11Jp-0007kC-GA
	for linux-serial@vger.kernel.org; Sat, 08 Dec 2007 17:10:22 +0200
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Hi everyone,

Individual Computers is basically a single-man company, which 
manufacturers some boards for old Amiga and C64 enthusiasts. There are a 
few hundred of these boards in circulation.

The board I have, the Catweasel Mk4, has PCI ID e159:0001. (This 
unfortunately belongs to TigerJet 300 ISDN device, because the 
Individual Computers is not registered.) It has ports for things like 
Amiga mice and keyboards, and I'm guessing these may be serial in 
nature. Whatever the reason, it classes itself as a serial 
communications controller.

I have a custom driver for this hardware, which used to work some half a 
year ago, probably on 2.6.20. It seems that with 2.6.22, the custom 
driver does not probe the Catweasel card any longer. Upon investigation, 
I found out that the serial driver has claimed it: it contains a 
guessing logic that will claim almost any serial communications 
controller for itself.

I'm looking for a way to make serial driver give that one device up. 
Which one of these solutions would seem most acceptable, on the level 
that a small patch could be placed in 8250_pci.c or elsewhere:

1) during generic probe, immediately return if the dev->vendor == 
PCI_VENDOR_ID_TIGERJET and dev->device == PCI_VENDOR_ID_TIGERJET_300 
with comment that explains that this really targets Individual 
Computer's Catweasel line of cards. There should be no harm to TigerJet 
300 because it is an ISDN device with its own driver.

2) have a kernel commandline option or module option that says "do not 
attempt generic serial probe on this system". This could be defensible 
on the grounds that generic probes can't always work, so there should be 
a way to fix things up when they don't.

3) Some userland way to make the driver give up particular device. Rmmod 
doesn't work for me, because the driver is linked in the kernel on 
Ubuntu G, but if there could be a way to somehow deregister the driver, 
that could be quite useful to me. Blacklisting? Command line parameter 
to tell kernel to skip "serial" driver completely? Anything at all?

As possibility 3) implies, I can live without the serial driver. I'm 
unfortunately somewhat ignorant about available ways to accomplish this.

3) also results in a side question: how does the kernel resolve 
situations where two drivers look capable of driving the same hardware? 
Does it priorize the drivers by insertion order, alphabetic sorting by 
name, or by most specific match in the pci id table, or any other 
explicit rule like that which I could exploit?

With regards,
Antti
