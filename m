From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH] SERIAL: discover PNP ports before PCI, etc
Date: Wed, 09 Feb 2005 13:12:47 -0700
Message-ID: <1107979967.27371.42.camel@eeyore>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Received: from atlrel8.hp.com ([156.153.255.206]:13213 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id S261925AbVBIUMz (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 9 Feb 2005 15:12:55 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: rmk+serial@arm.linux.org.uk
Cc: linux-serial@vger.kernel.org, shaohua.li@intel.com, ambx1@neo.rr.com

PNP ports tend to be built-in, and discovering them after
PCI ports means the names of the built-in ports can change
if you add or remove PCI ports.

(And yes, we should look at getting rid of 8250_acpi.c
now that we have PNPACPI, but that's for another patch.)

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

===== drivers/serial/Makefile 1.42 vs edited =====
--- 1.42/drivers/serial/Makefile	2005-02-03 07:42:40 -07:00
+++ edited/drivers/serial/Makefile	2005-02-09 12:58:23 -07:00
@@ -6,9 +6,9 @@
 
 serial-8250-y :=
 serial-8250-$(CONFIG_SERIAL_8250_ACPI) += 8250_acpi.o
+serial-8250-$(CONFIG_PNP) += 8250_pnp.o
 serial-8250-$(CONFIG_GSC) += 8250_gsc.o
 serial-8250-$(CONFIG_PCI) += 8250_pci.o
-serial-8250-$(CONFIG_PNP) += 8250_pnp.o
 serial-8250-$(CONFIG_HP300) += 8250_hp300.o
 
 obj-$(CONFIG_SERIAL_CORE) += serial_core.o


