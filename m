Return-Path: <SRS0=EpC2=5K=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 718B3C2D0E8
	for <linux-serial@archiver.kernel.org>; Wed, 25 Mar 2020 23:15:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54B0A20772
	for <linux-serial@archiver.kernel.org>; Wed, 25 Mar 2020 23:15:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727670AbgCYXOn (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 25 Mar 2020 19:14:43 -0400
Received: from gloria.sntech.de ([185.11.138.130]:40178 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727530AbgCYXOm (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 25 Mar 2020 19:14:42 -0400
Received: from ip5f5a5d2f.dynamic.kabel-deutschland.de ([95.90.93.47] helo=phil.sntech)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1jHFEI-0007ug-Gs; Thu, 26 Mar 2020 00:14:34 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     gregkh@linuxfoundation.org
Cc:     jslaby@suse.com, andriy.shevchenko@linux.intel.com,
        matwey.kornilov@gmail.com, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, heiko@sntech.de, lukas@wunner.de,
        christoph.muellner@theobroma-systems.com,
        giulio.benetti@micronovasrl.com,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
Subject: [PATCH v2 4/7] serial: 8250: Handle implementations not having TEMT interrupt using em485
Date:   Thu, 26 Mar 2020 00:14:19 +0100
Message-Id: <20200325231422.1502366-5-heiko@sntech.de>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200325231422.1502366-1-heiko@sntech.de>
References: <20200325231422.1502366-1-heiko@sntech.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Giulio Benetti <giulio.benetti@micronovasrl.com>

Some 8250 ports have a TEMT interrupt but it's not a part of the 8250
standard, instead only available on some implementations.

The current em485 implementation does not work on ports without it.
The only chance to make it work is to loop-read on LSR register.

So add UART_CAP_TEMT to mark 8250 uarts having this interrupt,
update all current em485 users with that capability and make
the stop_tx function loop-read on uarts not having it.

Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
[moved to use added UART_CAP_TEMT, use readx_poll_timeout]
Signed-off-by: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
---
 drivers/tty/serial/8250/8250.h            |  1 +
 drivers/tty/serial/8250/8250_bcm2835aux.c |  2 +-
 drivers/tty/serial/8250/8250_of.c         |  2 ++
 drivers/tty/serial/8250/8250_omap.c       |  2 +-
 drivers/tty/serial/8250/8250_port.c       | 25 +++++++++++++++++++----
 5 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
index 52bb21205bb6..770eb00db497 100644
--- a/drivers/tty/serial/8250/8250.h
+++ b/drivers/tty/serial/8250/8250.h
@@ -82,6 +82,7 @@ struct serial8250_config {
 #define UART_CAP_MINI	(1 << 17)	/* Mini UART on BCM283X family lacks:
 					 * STOP PARITY EPAR SPAR WLEN5 WLEN6
 					 */
+#define UART_CAP_TEMT	(1 << 18)	/* UART has TEMT interrupt */
 
 #define UART_BUG_QUOT	(1 << 0)	/* UART has buggy quot LSB */
 #define UART_BUG_TXEN	(1 << 1)	/* UART has buggy TX IIR status */
diff --git a/drivers/tty/serial/8250/8250_bcm2835aux.c b/drivers/tty/serial/8250/8250_bcm2835aux.c
index 12d03e678295..3881242424ca 100644
--- a/drivers/tty/serial/8250/8250_bcm2835aux.c
+++ b/drivers/tty/serial/8250/8250_bcm2835aux.c
@@ -91,7 +91,7 @@ static int bcm2835aux_serial_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	/* initialize data */
-	up.capabilities = UART_CAP_FIFO | UART_CAP_MINI;
+	up.capabilities = UART_CAP_FIFO | UART_CAP_MINI | UART_CAP_TEMT;
 	up.port.dev = &pdev->dev;
 	up.port.regshift = 2;
 	up.port.type = PORT_16550;
diff --git a/drivers/tty/serial/8250/8250_of.c b/drivers/tty/serial/8250/8250_of.c
index 65e9045dafe6..841f6fcb2878 100644
--- a/drivers/tty/serial/8250/8250_of.c
+++ b/drivers/tty/serial/8250/8250_of.c
@@ -225,6 +225,8 @@ static int of_platform_serial_probe(struct platform_device *ofdev)
 			&port8250.overrun_backoff_time_ms) != 0)
 		port8250.overrun_backoff_time_ms = 0;
 
+	port8250.capabilities |= UART_CAP_TEMT;
+
 	ret = serial8250_register_8250_port(&port8250);
 	if (ret < 0)
 		goto err_dispose;
diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index dd69226ce918..d29d5b0cf8c1 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -1140,7 +1140,7 @@ static int omap8250_probe(struct platform_device *pdev)
 	up.port.regshift = 2;
 	up.port.fifosize = 64;
 	up.tx_loadsz = 64;
-	up.capabilities = UART_CAP_FIFO;
+	up.capabilities = UART_CAP_FIFO | UART_CAP_TEMT;
 #ifdef CONFIG_PM
 	/*
 	 * Runtime PM is mostly transparent. However to do it right we need to a
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 47c059987538..41ad7db6a31e 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -15,6 +15,7 @@
 #include <linux/moduleparam.h>
 #include <linux/ioport.h>
 #include <linux/init.h>
+#include <linux/iopoll.h>
 #include <linux/console.h>
 #include <linux/sysrq.h>
 #include <linux/delay.h>
@@ -1520,6 +1521,11 @@ static inline void __do_stop_tx(struct uart_8250_port *p)
 		serial8250_rpm_put_tx(p);
 }
 
+static inline int __get_lsr(struct uart_8250_port *p)
+{
+	return serial_in(p, UART_LSR);
+}
+
 static inline void __stop_tx(struct uart_8250_port *p)
 {
 	struct uart_8250_em485 *em485 = p->em485;
@@ -1529,11 +1535,22 @@ static inline void __stop_tx(struct uart_8250_port *p)
 		/*
 		 * To provide required timeing and allow FIFO transfer,
 		 * __stop_tx_rs485() must be called only when both FIFO and
-		 * shift register are empty. It is for device driver to enable
-		 * interrupt on TEMT.
+		 * shift register are empty. If 8250 port supports it,
+		 * it is for device driver to enable interrupt on TEMT.
+		 * Otherwise must loop-read until TEMT and THRE flags are set.
 		 */
-		if ((lsr & BOTH_EMPTY) != BOTH_EMPTY)
-			return;
+		if (p->capabilities & UART_CAP_TEMT) {
+			if ((lsr & BOTH_EMPTY) != BOTH_EMPTY)
+				return;
+		} else {
+			int lsr;
+
+			if (readx_poll_timeout(__get_lsr, p, lsr,
+					(lsr & BOTH_EMPTY) == BOTH_EMPTY,
+					0, 10000) < 0)
+				pr_warn("%s: timeout waiting for fifos to empty\n",
+					p->port.name);
+		}
 
 		__stop_tx_rs485(p);
 	}
-- 
2.24.1

