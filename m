From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: serial: add PNP ID for Davicom ISA 33.6K modem
Date: Wed, 7 Nov 2007 15:43:33 -0600
Message-ID: <200711071443.34291.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from palrel10.hp.com ([156.153.255.245]:52880 "EHLO palrel10.hp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759461AbXKGWCv (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 7 Nov 2007 17:02:51 -0500
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-serial@vger.kernel.org, Russell King <rmk+serial@arm.linux.org.uk>, Alan Cox <alan@lxorguk.ukuu.org.uk>, vavilov@ihep.ru

This should resolve these bug reports of the modem not working:
    http://bugzilla.kernel.org/show_bug.cgi?id=4355
    http://www.linuxquestions.org/questions/linux-newbie-8/connect-script-failed-on-ppp-go-123975/

I don't have hardware to test this, but the initial report in the kernel
bugzilla indicates that this change fixed the problem.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Index: w/drivers/serial/8250_pnp.c
===================================================================
--- w.orig/drivers/serial/8250_pnp.c	2007-11-06 10:27:52.000000000 -0700
+++ w/drivers/serial/8250_pnp.c	2007-11-06 10:30:16.000000000 -0700
@@ -69,6 +69,8 @@
 	{	"CTL3001",		0	},
 	/* Creative Labs Modem Blaster 28.8 DSVD PnP Voice */
 	{	"CTL3011",		0	},
+	/* Davicom ISA 33.6K Modem */
+	{	"DAV0336",		0	},
 	/* Creative */
 	/* Creative Modem Blaster Flash56 DI5601-1 */
 	{	"DMB1032",		0	},
