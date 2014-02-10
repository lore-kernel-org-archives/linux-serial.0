From: Alexander Shiyan <shc_work@mail.ru>
Subject: [PATCH 6/8] serial: max310x: Driver cleanup
Date: Mon, 10 Feb 2014 22:18:35 +0400
Message-ID: <1392056316-13844-7-git-send-email-shc_work@mail.ru>
References: <1392056316-13844-1-git-send-email-shc_work@mail.ru>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from fallback2.mail.ru ([94.100.176.87]:41153 "EHLO
	fallback2.mail.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752213AbaBJSsH (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 10 Feb 2014 13:48:07 -0500
Received: from smtp32.i.mail.ru (smtp32.i.mail.ru [94.100.177.92])
	by fallback2.mail.ru (mPOP.Fallback_MX) with ESMTP id 629C2FE036E4
	for <linux-serial@vger.kernel.org>; Mon, 10 Feb 2014 22:19:15 +0400 (MSK)
In-Reply-To: <1392056316-13844-1-git-send-email-shc_work@mail.ru>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Alexander Shiyan <shc_work@mail.ru>

This patch removes some unused definitions from driver code and
sort #includes alphabetically.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 drivers/tty/serial/max310x.c | 34 +++++-----------------------------
 1 file changed, 5 insertions(+), 29 deletions(-)

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index 090f25d..e273854 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -13,17 +13,17 @@
  *  (at your option) any later version.
  */
 
-#include <linux/module.h>
-#include <linux/delay.h>
-#include <linux/device.h>
 #include <linux/bitops.h>
 #include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/gpio.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
 #include <linux/serial_core.h>
 #include <linux/serial.h>
 #include <linux/tty.h>
 #include <linux/tty_flip.h>
-#include <linux/regmap.h>
-#include <linux/gpio.h>
 #include <linux/spi/spi.h>
 
 #define MAX310X_NAME			"max310x"
@@ -160,10 +160,6 @@
 /* IRDA register bits */
 #define MAX310X_IRDA_IRDAEN_BIT		(1 << 0) /* IRDA mode enable */
 #define MAX310X_IRDA_SIR_BIT		(1 << 1) /* SIR mode enable */
-#define MAX310X_IRDA_SHORTIR_BIT	(1 << 2) /* Short SIR mode enable */
-#define MAX310X_IRDA_MIR_BIT		(1 << 3) /* MIR mode enable */
-#define MAX310X_IRDA_RXINV_BIT		(1 << 4) /* RX logic inversion enable */
-#define MAX310X_IRDA_TXINV_BIT		(1 << 5) /* TX logic inversion enable */
 
 /* Flow control trigger level register masks */
 #define MAX310X_FLOWLVL_HALT_MASK	(0x000f) /* Flow control halt level */
@@ -219,26 +215,6 @@
 						  *       XOFF2
 						  */
 
-/* GPIO configuration register bits */
-#define MAX310X_GPIOCFG_GP0OUT_BIT	(1 << 0) /* GPIO 0 output enable */
-#define MAX310X_GPIOCFG_GP1OUT_BIT	(1 << 1) /* GPIO 1 output enable */
-#define MAX310X_GPIOCFG_GP2OUT_BIT	(1 << 2) /* GPIO 2 output enable */
-#define MAX310X_GPIOCFG_GP3OUT_BIT	(1 << 3) /* GPIO 3 output enable */
-#define MAX310X_GPIOCFG_GP0OD_BIT	(1 << 4) /* GPIO 0 open-drain enable */
-#define MAX310X_GPIOCFG_GP1OD_BIT	(1 << 5) /* GPIO 1 open-drain enable */
-#define MAX310X_GPIOCFG_GP2OD_BIT	(1 << 6) /* GPIO 2 open-drain enable */
-#define MAX310X_GPIOCFG_GP3OD_BIT	(1 << 7) /* GPIO 3 open-drain enable */
-
-/* GPIO DATA register bits */
-#define MAX310X_GPIODATA_GP0OUT_BIT	(1 << 0) /* GPIO 0 output value */
-#define MAX310X_GPIODATA_GP1OUT_BIT	(1 << 1) /* GPIO 1 output value */
-#define MAX310X_GPIODATA_GP2OUT_BIT	(1 << 2) /* GPIO 2 output value */
-#define MAX310X_GPIODATA_GP3OUT_BIT	(1 << 3) /* GPIO 3 output value */
-#define MAX310X_GPIODATA_GP0IN_BIT	(1 << 4) /* GPIO 0 input value */
-#define MAX310X_GPIODATA_GP1IN_BIT	(1 << 5) /* GPIO 1 input value */
-#define MAX310X_GPIODATA_GP2IN_BIT	(1 << 6) /* GPIO 2 input value */
-#define MAX310X_GPIODATA_GP3IN_BIT	(1 << 7) /* GPIO 3 input value */
-
 /* PLL configuration register masks */
 #define MAX310X_PLLCFG_PREDIV_MASK	(0x3f) /* PLL predivision value */
 #define MAX310X_PLLCFG_PLLFACTOR_MASK	(0xc0) /* PLL multiplication factor */
-- 
1.8.3.2

