From: Geoff Levand <geoffrey.levand@am.sony.com>
Subject: pmac serial_pci_guess_board problem
Date: Fri, 04 Nov 2005 13:27:05 -0800
Message-ID: <436BD229.3090401@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-red.bigfish.com ([216.148.222.61]:64049 "EHLO
	mail18-red-R.bigfish.com") by vger.kernel.org with ESMTP
	id S1750917AbVKDV1I (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 4 Nov 2005 16:27:08 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: rmk+serial@arm.linux.org.uk
Cc: linux-serial@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>

Russell,

I found that the serial port probe code in drivers/serial/8250_pci.c 
no longer works properly for PowerMac G5 in 2.6.14.  It seems some new
code now takes the PCI device info directly from the G5's Open 
Firmware.  The trouble is that OF sets the address length to 16 bytes, 
not the expected 8 bytes.

Here's a fix, but I'd be interested to hear your comments.

-Geoff


Index: linux-2.6.14/drivers/serial/8250_pci.c
===================================================================
--- linux-2.6.14.orig/drivers/serial/8250_pci.c	2005-11-04 11:41:09.000000000 -0800
+++ linux-2.6.14/drivers/serial/8250_pci.c	2005-11-04 11:44:21.000000000 -0800
@@ -1478,7 +1478,11 @@
 	num_port = 0;
 	for (i = 0; i < PCI_NUM_BAR_RESOURCES; i++) {
 		if (pci_resource_flags(dev, i) & IORESOURCE_IO &&
+#if defined(CONFIG_PPC_PMAC64)
+		    pci_resource_len(dev, i) == 16 &&
+#else
 		    pci_resource_len(dev, i) == 8 &&
+#endif
 		    (first_port == -1 || (first_port + num_port) == i)) {
 			num_port++;
 			if (first_port == -1)



-------- Original Message --------
Subject: Re: pci_resource_end() changed problem with 2.6.14
Date: Fri, 04 Nov 2005 17:56:09 +1100
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Geoff Levand <geoffrey.levand@am.sony.com>
CC: linuxppc64-dev@ozlabs.org
References: <436ADBA7.7030706@am.sony.com>

On Thu, 2005-11-03 at 19:55 -0800, Geoff Levand wrote:
> I found that the serial port probe code in drivers/serial/8250_pci.c 
> no longer works properly for ppc64 in 2.6.14.  It seems the value 
> returned by pci_resource_len() on ppc64 changed from 8 to 16 since 
> 2.6.13.  I tested on a PC and pci_resource_len() returns 8 as 
> expected.
> 
> Any help on on where to look for the problem would be appreciated.
> 
> Here's the code that hits the problem:
> 
> 		if (pci_resource_flags(dev, i) & IORESOURCE_IO &&
> 		    pci_resource_len(dev, i) == 8 &&
> 
> And here are some test results:

Interesting... What does an lspci -vv shows for the BARs of the PCI
card ? Also, what do you have in /proc/device-tree  ? What is the
machine precisely ?

2.6.14 now uses the OF device-tree to generate the linux PCI tree
instead of going directly to PCI probing. It's possible that this is
causing your problem if for some reason, the BAR sizing done by OF ends
up being different than what the kernel does ...

Ben.






