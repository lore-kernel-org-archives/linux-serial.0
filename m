From: Sergei Organov <osv@javad.com>
Subject: [PATCH] tty: Char: mxser, add support for CP114EL
Date: Tue, 02 Mar 2010 17:09:14 +0300
Message-ID: <874okyerxx.fsf@osv.gnss.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from javad.com ([205.178.136.214]:57540 "EHLO 02aef2d.netsolvps.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753171Ab0CBOQe (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 2 Mar 2010 09:16:34 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Jiri Slaby <jirislaby@gmail.com>
Cc: linux-serial@vger.kernel.org

Add support for MOXA:0x1144 pci device. It's a 4-port device and
differs in no way from the others. So this turns out to be a trivial
pci_device_id change.

Increase also the version number.

Signed-off-by: Sergei Organov <osv@javad.com>
---
 drivers/char/mxser.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/drivers/char/mxser.c b/drivers/char/mxser.c
index 3d92306..a7147c3 100644
--- a/drivers/char/mxser.c
+++ b/drivers/char/mxser.c
@@ -47,7 +47,7 @@
 
 #include "mxser.h"
 
-#define	MXSER_VERSION	"2.0.5"		/* 1.14 */
+#define	MXSER_VERSION	"2.0.6"
 #define	MXSERMAJOR	 174
 
 #define MXSER_BOARDS		4	/* Max. boards */
@@ -71,6 +71,7 @@
 #define PCI_DEVICE_ID_CP112UL	0x1120
 #define PCI_DEVICE_ID_CB114	0x1142
 #define PCI_DEVICE_ID_CP114UL	0x1143
+#define PCI_DEVICE_ID_CP114EL	0x1144
 #define PCI_DEVICE_ID_CB134I	0x1341
 #define PCI_DEVICE_ID_CP138U	0x1380
 
@@ -141,6 +142,7 @@ static const struct mxser_cardinfo mxser_cards[] = {
 	{ "CP-114UL series",	4, },
 /*30*/	{ "CP-102UF series",	2, },
 	{ "CP-112UL series",	2, },
+	{ "CP-114EL series",	4, },
 };
 
 /* driver_data correspond to the lines in the structure above
@@ -172,6 +174,7 @@ static struct pci_device_id mxser_pcibrds[] = {
 	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_CP114UL),	.driver_data = 29 },
 	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_CP102UF),	.driver_data = 30 },
 	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_CP112UL),	.driver_data = 31 },
+	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_CP114EL),	.driver_data = 32 },
 	{ }
 };
 MODULE_DEVICE_TABLE(pci, mxser_pcibrds);
-- 
1.7.0

