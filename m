From: Luca Tettamanti <kronos.it@gmail.com>
Subject: [PATCH] Enable legacy support for serial ports when SERIAL_8250_PNP is disabled
Date: Sun, 8 Jul 2007 01:33:00 +0200
Message-ID: <20070707233300.GA3267@dreamland.darkstar.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.171]:30662 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752312AbXGGXdH (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 7 Jul 2007 19:33:07 -0400
Received: by ug-out-1314.google.com with SMTP id j3so936917ugf
        for <linux-serial@vger.kernel.org>; Sat, 07 Jul 2007 16:33:06 -0700 (PDT)
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Bjorn,
your patch:

commit 7e92b4fc345f5b6f57585fbe5ffdb0f24d7c9b26
Author: Bjorn Helgaas <bjorn.helgaas@hp.com>
Date:   Tue May 8 00:36:07 2007 -0700

    x86, serial: convert legacy COM ports to platform devices

disables probing using legacy code in favour of ACPI/PNP to avoid double
discovery.

However if SERIAL_8250_PNP is not enabled the user is left without
serial ports (been there, done that - my kernel config suddenly wasn't
working anymore). So:

Enable probing of serial ports using legacy code when PNP code
(SERIAL_8250_PNP) is not enabled.

Signed-off-by: Luca Tettamanti <kronos.it@gmail.com>

---

 arch/i386/kernel/legacy_serial.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/i386/kernel/legacy_serial.c b/arch/i386/kernel/legacy_serial.c
index 2151011..457d307 100644
--- a/arch/i386/kernel/legacy_serial.c
+++ b/arch/i386/kernel/legacy_serial.c
@@ -48,7 +48,11 @@ static struct platform_device x86_com_device = {
 	},
 };
 
+#ifndef CONFIG_SERIAL_8250_PNP
+static int force_legacy_probe = 1;
+#else
 static int force_legacy_probe;
+#endif
 module_param_named(force, force_legacy_probe, bool, 0);
 MODULE_PARM_DESC(force, "Force legacy serial port probe");
 


Luca
-- 
La vispa candela bruciava l'erbetta
creando un'essenza alquanto sospetta;
sembrava l'odore di una sacrestia
ma presto mi accorsi che era maria.
