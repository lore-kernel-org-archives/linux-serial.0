From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [SERIAL] Claim Wacom tablet device on HP tc1100 tablet
Date: Fri, 11 Nov 2005 16:55:22 -0700
Message-ID: <200511111655.22637.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from atlrel8.hp.com ([156.153.255.206]:55739 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id S1750758AbVKKXzi (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 11 Nov 2005 18:55:38 -0500
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Russell King <rmk+serial@arm.linux.org.uk>
Cc: linux-serial@vger.kernel.org, Andrew Morton <akpm@osdl.org>, David Ludlow <dave@adsllc.com>, Christopher Kemp <ck231@cam.ac.uk>

Claim the WACF005 device.  This is the pen display pointing device on
the HP Compaq tc1100 Tablet PC.  More information about using this
device, including using it as an X pointer device:

    http://www.theory.bham.ac.uk/staff/schofield/linux/tc1100/

Christopher Kemp <ck231@cam.ac.uk> did the legwork of determining that
the WACF005 is really just a plain old UART and doing an initial ACPI
driver (before we had PNPACPI), and David Ludlow <dave@adsllc.com>
confirmed that PNPACPI + the attached patch is now sufficient:

    pnp: Device 00:05 activated.
    ttyS4 at I/O 0x300 (irq = 4) is a 16550A

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Index: work-mm1/drivers/serial/8250_pnp.c
===================================================================
--- work-mm1.orig/drivers/serial/8250_pnp.c	2005-11-08 15:57:32.000000000 -0700
+++ work-mm1/drivers/serial/8250_pnp.c	2005-11-11 16:34:02.000000000 -0700
@@ -323,6 +323,8 @@
 	{	"USR9180",		0	},
 	/* U.S. Robotics 56K Voice INT PnP*/
 	{	"USR9190",		0	},
+	/* HP Compaq Tablet PC tc1100 Wacom tablet */
+	{	"WACF005",		0	},
 	/* Rockwell's (PORALiNK) 33600 INT PNP */
 	{	"WCI0003",		0	},
 	/* Unkown PnP modems */
