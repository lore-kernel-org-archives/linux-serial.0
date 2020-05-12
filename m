Return-Path: <SRS0=eb60=62=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ABF4C54E4A
	for <linux-serial@archiver.kernel.org>; Tue, 12 May 2020 14:02:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0ACE4206CC
	for <linux-serial@archiver.kernel.org>; Tue, 12 May 2020 14:02:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729519AbgELOCz (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 12 May 2020 10:02:55 -0400
Received: from mga12.intel.com ([192.55.52.136]:62365 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728085AbgELOCz (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 12 May 2020 10:02:55 -0400
IronPort-SDR: +6AklzIjm13DuzQdvcQ8xBor2r9qF41QATGN0R8rResG6vQ3X4g8bPAm/nMXqsxVbe48cJzI0d
 af8hje5WKfPA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2020 07:02:54 -0700
IronPort-SDR: j1ExeGs2KceIGrXSd6PgKm1EqylmuOIrRBlZ/giVM4KXESM/iUocVMPAvA9Uv8g23zTB640Rii
 /YEUV/3pke4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,384,1583222400"; 
   d="scan'208";a="409306729"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 12 May 2020 07:02:53 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 86A95101; Tue, 12 May 2020 17:02:52 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] serial: 8250_exar: Make use of PCI_DEVICE_DATA() macro
Date:   Tue, 12 May 2020 17:02:52 +0300
Message-Id: <20200512140252.67631-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Since PCI core provides a generic PCI_DEVICE_DATA() macro,
replace contents of EXAR_DEVICE() with former one.

No functional change intended.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/8250/8250_exar.c | 65 ++++++++++++++---------------
 1 file changed, 31 insertions(+), 34 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
index 885c282c3c7979..1774e9b0f44bda 100644
--- a/drivers/tty/serial/8250/8250_exar.c
+++ b/drivers/tty/serial/8250/8250_exar.c
@@ -25,13 +25,13 @@
 
 #include "8250.h"
 
-#define PCI_DEVICE_ID_ACCES_COM_2S		0x1052
-#define PCI_DEVICE_ID_ACCES_COM_4S		0x105d
-#define PCI_DEVICE_ID_ACCES_COM_8S		0x106c
-#define PCI_DEVICE_ID_ACCES_COM232_8		0x10a8
-#define PCI_DEVICE_ID_ACCES_COM_2SM		0x10d2
-#define PCI_DEVICE_ID_ACCES_COM_4SM		0x10db
-#define PCI_DEVICE_ID_ACCES_COM_8SM		0x10ea
+#define PCI_DEVICE_ID_ACCESSIO_COM_2S		0x1052
+#define PCI_DEVICE_ID_ACCESSIO_COM_4S		0x105d
+#define PCI_DEVICE_ID_ACCESSIO_COM_8S		0x106c
+#define PCI_DEVICE_ID_ACCESSIO_COM232_8		0x10a8
+#define PCI_DEVICE_ID_ACCESSIO_COM_2SM		0x10d2
+#define PCI_DEVICE_ID_ACCESSIO_COM_4SM		0x10db
+#define PCI_DEVICE_ID_ACCESSIO_COM_8SM		0x10ea
 
 #define PCI_DEVICE_ID_COMMTECH_4224PCI335	0x0002
 #define PCI_DEVICE_ID_COMMTECH_4222PCI335	0x0004
@@ -743,9 +743,7 @@ static const struct exar8250_board pbn_exar_XR17V8358 = {
 		(kernel_ulong_t)&bd					\
 	}
 
-#define EXAR_DEVICE(vend, devid, bd) {					\
-	PCI_VDEVICE(vend, PCI_DEVICE_ID_##devid), (kernel_ulong_t)&bd	\
-	}
+#define EXAR_DEVICE(vend, devid, bd) { PCI_DEVICE_DATA(vend, devid, &bd) }
 
 #define IBM_DEVICE(devid, sdevid, bd) {			\
 	PCI_DEVICE_SUB(					\
@@ -757,14 +755,13 @@ static const struct exar8250_board pbn_exar_XR17V8358 = {
 	}
 
 static const struct pci_device_id exar_pci_tbl[] = {
-	EXAR_DEVICE(ACCESSIO, ACCES_COM_2S, acces_com_2x),
-	EXAR_DEVICE(ACCESSIO, ACCES_COM_4S, acces_com_4x),
-	EXAR_DEVICE(ACCESSIO, ACCES_COM_8S, acces_com_8x),
-	EXAR_DEVICE(ACCESSIO, ACCES_COM232_8, acces_com_8x),
-	EXAR_DEVICE(ACCESSIO, ACCES_COM_2SM, acces_com_2x),
-	EXAR_DEVICE(ACCESSIO, ACCES_COM_4SM, acces_com_4x),
-	EXAR_DEVICE(ACCESSIO, ACCES_COM_8SM, acces_com_8x),
-
+	EXAR_DEVICE(ACCESSIO, COM_2S, acces_com_2x),
+	EXAR_DEVICE(ACCESSIO, COM_4S, acces_com_4x),
+	EXAR_DEVICE(ACCESSIO, COM_8S, acces_com_8x),
+	EXAR_DEVICE(ACCESSIO, COM232_8, acces_com_8x),
+	EXAR_DEVICE(ACCESSIO, COM_2SM, acces_com_2x),
+	EXAR_DEVICE(ACCESSIO, COM_4SM, acces_com_4x),
+	EXAR_DEVICE(ACCESSIO, COM_8SM, acces_com_8x),
 
 	CONNECT_DEVICE(XR17C152, UART_2_232, pbn_connect),
 	CONNECT_DEVICE(XR17C154, UART_4_232, pbn_connect),
@@ -782,24 +779,24 @@ static const struct pci_device_id exar_pci_tbl[] = {
 	IBM_DEVICE(XR17C152, SATURN_SERIAL_ONE_PORT, pbn_exar_ibm_saturn),
 
 	/* Exar Corp. XR17C15[248] Dual/Quad/Octal UART */
-	EXAR_DEVICE(EXAR, EXAR_XR17C152, pbn_exar_XR17C15x),
-	EXAR_DEVICE(EXAR, EXAR_XR17C154, pbn_exar_XR17C15x),
-	EXAR_DEVICE(EXAR, EXAR_XR17C158, pbn_exar_XR17C15x),
+	EXAR_DEVICE(EXAR, XR17C152, pbn_exar_XR17C15x),
+	EXAR_DEVICE(EXAR, XR17C154, pbn_exar_XR17C15x),
+	EXAR_DEVICE(EXAR, XR17C158, pbn_exar_XR17C15x),
 
 	/* Exar Corp. XR17V[48]35[248] Dual/Quad/Octal/Hexa PCIe UARTs */
-	EXAR_DEVICE(EXAR, EXAR_XR17V352, pbn_exar_XR17V35x),
-	EXAR_DEVICE(EXAR, EXAR_XR17V354, pbn_exar_XR17V35x),
-	EXAR_DEVICE(EXAR, EXAR_XR17V358, pbn_exar_XR17V35x),
-	EXAR_DEVICE(EXAR, EXAR_XR17V4358, pbn_exar_XR17V4358),
-	EXAR_DEVICE(EXAR, EXAR_XR17V8358, pbn_exar_XR17V8358),
-	EXAR_DEVICE(COMMTECH, COMMTECH_4222PCIE, pbn_exar_XR17V35x),
-	EXAR_DEVICE(COMMTECH, COMMTECH_4224PCIE, pbn_exar_XR17V35x),
-	EXAR_DEVICE(COMMTECH, COMMTECH_4228PCIE, pbn_exar_XR17V35x),
-
-	EXAR_DEVICE(COMMTECH, COMMTECH_4222PCI335, pbn_fastcom335_2),
-	EXAR_DEVICE(COMMTECH, COMMTECH_4224PCI335, pbn_fastcom335_4),
-	EXAR_DEVICE(COMMTECH, COMMTECH_2324PCI335, pbn_fastcom335_4),
-	EXAR_DEVICE(COMMTECH, COMMTECH_2328PCI335, pbn_fastcom335_8),
+	EXAR_DEVICE(EXAR, XR17V352, pbn_exar_XR17V35x),
+	EXAR_DEVICE(EXAR, XR17V354, pbn_exar_XR17V35x),
+	EXAR_DEVICE(EXAR, XR17V358, pbn_exar_XR17V35x),
+	EXAR_DEVICE(EXAR, XR17V4358, pbn_exar_XR17V4358),
+	EXAR_DEVICE(EXAR, XR17V8358, pbn_exar_XR17V8358),
+	EXAR_DEVICE(COMMTECH, 4222PCIE, pbn_exar_XR17V35x),
+	EXAR_DEVICE(COMMTECH, 4224PCIE, pbn_exar_XR17V35x),
+	EXAR_DEVICE(COMMTECH, 4228PCIE, pbn_exar_XR17V35x),
+
+	EXAR_DEVICE(COMMTECH, 4222PCI335, pbn_fastcom335_2),
+	EXAR_DEVICE(COMMTECH, 4224PCI335, pbn_fastcom335_4),
+	EXAR_DEVICE(COMMTECH, 2324PCI335, pbn_fastcom335_4),
+	EXAR_DEVICE(COMMTECH, 2328PCI335, pbn_fastcom335_8),
 	{ 0, }
 };
 MODULE_DEVICE_TABLE(pci, exar_pci_tbl);
-- 
2.26.2

