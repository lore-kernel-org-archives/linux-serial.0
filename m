From: "Manjunathappa, Prakash" <prakash.pm@ti.com>
Subject: [PATCH 4/4] ARM: davinci: da8xx: remove da8xx_uart_clk_enable
Date: Tue, 9 Apr 2013 18:01:04 +0530
Message-ID: <1365510664-1394-5-git-send-email-prakash.pm@ti.com>
References: <1365510481-32129-1-git-send-email-prakash.pm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:57474 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935235Ab3DIMak (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 9 Apr 2013 08:30:40 -0400
In-Reply-To: <1365510481-32129-1-git-send-email-prakash.pm@ti.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: davinci-linux-open-source@linux.davincidsp.com, linux-serial@vger.kernel.org
Cc: nsekhar@ti.com, grant.likely@secretlab.ca, rob.herring@calxeda.com, linux@arm.linux.org.uk, hs@denx.de, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org, "Manjunathappa, Prakash" <prakash.pm@ti.com>

Serial clocks are enabled from of_platform_serial_setup:of_serial.c,
so remove davinci_serial_setup_clk from here.

Signed-off-by: Manjunathappa, Prakash <prakash.pm@ti.com>
---
 arch/arm/mach-davinci/da8xx-dt.c |    8 --------
 1 files changed, 0 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-davinci/da8xx-dt.c b/arch/arm/mach-davinci/da8xx-dt.c
index fff78a1..219126b 100644
--- a/arch/arm/mach-davinci/da8xx-dt.c
+++ b/arch/arm/mach-davinci/da8xx-dt.c
@@ -20,13 +20,6 @@
 
 #define DA8XX_NUM_UARTS	3
 
-void __init da8xx_uart_clk_enable(void)
-{
-	int i;
-	for (i = 0; i < DA8XX_NUM_UARTS; i++)
-		davinci_serial_setup_clk(i, NULL);
-}
-
 static struct of_device_id da8xx_irq_match[] __initdata = {
 	{ .compatible = "ti,cp-intc", .data = cp_intc_of_init, },
 	{ }
@@ -53,7 +46,6 @@ static void __init da850_init_machine(void)
 	of_platform_populate(NULL, of_default_bus_match_table,
 			     da850_auxdata_lookup, NULL);
 
-	da8xx_uart_clk_enable();
 }
 
 static const char *da850_boards_compat[] __initdata = {
-- 
1.7.4.1

