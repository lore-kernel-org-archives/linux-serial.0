From: =?ISO-8859-1?Q?Richard_R=F6jfors?=
	<richard.rojfors@mocean-labs.com>
Subject: [PATCH] uartlite: Allow to be built for timberdale MFD
Date: Tue, 22 Sep 2009 14:39:07 +0200
Message-ID: <4AB8C56B.1050303@mocean-labs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from av9-2-sn3.vrr.skanova.net ([81.228.9.186]:59914 "EHLO
	av9-2-sn3.vrr.skanova.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755860AbZIVMjU (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 22 Sep 2009 08:39:20 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: alan@lxorguk.ukuu.org.uk, Andrew Morton <akpm@linux-foundation.org>

Some configurations of the Timberdale FPGA has the uartlite
included.

Signed-off-by: Richard R=F6jfors <richard.rojfors@mocean-labs.com>
---
diff --git a/drivers/serial/Kconfig b/drivers/serial/Kconfig
index 037c1e0..e067989 100644
--- a/drivers/serial/Kconfig
+++ b/drivers/serial/Kconfig
@@ -855,7 +855,7 @@ config SERIAL_IMX_CONSOLE

 config SERIAL_UARTLITE
 	tristate "Xilinx uartlite serial port support"
-	depends on PPC32 || MICROBLAZE
+	depends on PPC32 || MICROBLAZE || MFD_TIMBERDALE
 	select SERIAL_CORE
 	help
 	  Say Y here if you want to use the Xilinx uartlite serial controller=
=2E
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
