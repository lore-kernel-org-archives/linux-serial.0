From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [patch 2/5] PNP: workaround HP BIOS defect that leaves SMCF010 device partly enabled
Date: Wed, 04 Apr 2007 16:45:38 -0600
Message-ID: <20070404224608.613840000@ldl.fc.hp.com>
References: <20070404224536.337573000@ldl.fc.hp.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from atlrel9.hp.com ([156.153.255.214]:47107 "EHLO atlrel9.hp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752433AbXDDWqX (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 4 Apr 2007 18:46:23 -0400
Content-Disposition: inline; filename=hp-smcf010-quirk.patch
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Keith Owens <kaos@ocs.com.au>, Len Brown <lenb@kernel.org>, Adam Belay <ambx1@neo.rr.com>, Matthieu CASTET <castet.matthieu@free.fr>, Jean Tourrilhes <jt@hpl.hp.com>, Matthew Garrett <mjg59@srcf.ucam.org>, Ville Syrjala <syrjala@sci.fi>, Russell King <rmk+serial@arm.linux.org.uk>, linux-serial@vger.kernel.org, Samuel Ortiz <samuel@sortiz.org>, linux-kernel@vger.kernel.org

Some HP/Compaq firmware reports via ACPI that the SMCF010 IR device is
enabled, but in fact, it leaves the device partly disabled.

HP nw8240 BIOS 68DTV Ver. F.0F, released 9/15/2005 is one BIOS that has
this problem.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Index: w/drivers/pnp/quirks.c
===================================================================
--- w.orig/drivers/pnp/quirks.c	2007-03-29 14:24:51.000000000 -0600
+++ w/drivers/pnp/quirks.c	2007-03-29 14:42:54.000000000 -0600
@@ -16,6 +16,7 @@
 #include <linux/string.h>
 #include <linux/slab.h>
 #include <linux/pnp.h>
+#include <linux/io.h>
 #include "base.h"
 
 
@@ -106,6 +107,34 @@
 	return;
 }
 
+static void quirk_smc_enable(struct pnp_dev *dev)
+{
+	unsigned int firbase;
+
+	if (!dev->active || !pnp_port_valid(dev, 1))
+		return;
+
+	/*
+	 * On the HP/Compaq nw8240 (and probably other similar machines),
+	 * there is an SMCF010 device with two I/O port regions:
+	 *
+	 *	0x3e8-0x3ef SIR
+	 *	0x100-0x10f FIR
+	 *
+	 * _STA reports the device is enabled, but in fact, the BIOS
+	 * neglects to enable the FIR range.  Fortunately, it does fully
+	 * enable the device if we call _SRS.
+	 */
+	firbase = pnp_port_start(dev, 1);
+	if (inb(firbase + 0x7 /* IRCC_MASTER */) == 0xff) {
+		pnp_err("%s (%s) enabled but not responding, disabling and "
+			"re-enabling", dev->dev.bus_id, pnp_dev_name(dev));
+		pnp_disable_dev(dev);
+		pnp_activate_dev(dev);
+	}
+}
+
+
 /*
  *  PnP Quirks
  *  Cards or devices that need some tweaking due to incomplete resource info
@@ -126,6 +155,7 @@
 	{ "CTL0043", quirk_sb16audio_resources },
 	{ "CTL0044", quirk_sb16audio_resources },
 	{ "CTL0045", quirk_sb16audio_resources },
+	{ "SMCf010", quirk_smc_enable },
 	{ "" }
 };
 

--
