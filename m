Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 398B3C433EF
	for <linux-serial@archiver.kernel.org>; Sat, 12 Feb 2022 08:41:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232819AbiBLIll (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 12 Feb 2022 03:41:41 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232817AbiBLIll (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 12 Feb 2022 03:41:41 -0500
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5BA572613A;
        Sat, 12 Feb 2022 00:41:38 -0800 (PST)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 7528492009C; Sat, 12 Feb 2022 09:41:36 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 7220E92009B;
        Sat, 12 Feb 2022 08:41:36 +0000 (GMT)
Date:   Sat, 12 Feb 2022 08:41:36 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] serial: 8250: Correct Kconfig help text for blacklisted
 PCI devices
In-Reply-To: <alpine.DEB.2.21.2202052214360.34636@angie.orcam.me.uk>
Message-ID: <alpine.DEB.2.21.2202062121260.34636@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2202052214360.34636@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Correct the Kconfig help text for SERIAL_8250_LPSS, SERIAL_8250_MID and 
SERIAL_8250_PERICOM configuration options for dedicated PCI UART drivers 
that have been blacklisted in the generic PCI 8250 UART driver and as 
from commit a13e19cf3dc10 ("serial: 8250_lpss: split LPSS driver to 
separate module"), commit d9eda9bab2372 ("serial: 8250_pci: Intel MID 
UART support to its own driver"), and commit fcfd3c09f4078 ("serial: 
8250_pci: Split out Pericom driver") respectively are not handled by 
said driver anymore (rather than for extra features only, as the current 
text indicates), and therefore require the respective dedicated drivers 
to work at all.

Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
---
 drivers/tty/serial/8250/Kconfig |   16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

linux-serial-8250-pci-blacklist-help.diff
Index: linux-macro/drivers/tty/serial/8250/Kconfig
===================================================================
--- linux-macro.orig/drivers/tty/serial/8250/Kconfig
+++ linux-macro/drivers/tty/serial/8250/Kconfig
@@ -479,11 +479,12 @@ config SERIAL_8250_LPSS
 	select DW_DMAC_PCI if (SERIAL_8250_DMA && X86_INTEL_LPSS)
 	select RATIONAL
 	help
-	  Selecting this option will enable handling of the extra features
-	  present on the UART found on various Intel platforms such as:
+	  Selecting this option will enable handling of the UART found on
+	  various Intel platforms such as:
 	    - Intel Baytrail SoC
 	    - Intel Braswell SoC
 	    - Intel Quark X1000 SoC
+	  that are not covered by the more generic SERIAL_8250_PCI option.
 
 config SERIAL_8250_MID
 	tristate "Support for serial ports on Intel MID platforms"
@@ -494,17 +495,18 @@ config SERIAL_8250_MID
 	select HSU_DMA_PCI if (HSU_DMA && X86_INTEL_MID)
 	select RATIONAL
 	help
-	  Selecting this option will enable handling of the extra features
-	  present on the UART found on Intel Medfield SOC and various other
-	  Intel platforms.
+	  Selecting this option will enable handling of the UART found on
+	  Intel Medfield SOC and various other Intel platforms that is not
+	  covered by the more generic SERIAL_8250_PCI option.
 
 config SERIAL_8250_PERICOM
 	tristate "Support for Pericom and Acces I/O serial ports"
 	default SERIAL_8250
 	depends on SERIAL_8250 && PCI
 	help
-	  Selecting this option will enable handling of the extra features
-	  present on the Pericom and Acces I/O UARTs.
+	  Selecting this option will enable handling of the Pericom and Acces
+	  I/O UARTs that are not covered by the more generic SERIAL_8250_PCI
+	  option.
 
 config SERIAL_8250_PXA
 	tristate "PXA serial port support"
