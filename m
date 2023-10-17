Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0691ECDB474
	for <linux-serial@archiver.kernel.org>; Tue, 17 Oct 2023 13:05:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233940AbjJQNF4 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 17 Oct 2023 09:05:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234143AbjJQNFx (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 17 Oct 2023 09:05:53 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DF69ED
        for <linux-serial@vger.kernel.org>; Tue, 17 Oct 2023 06:05:49 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8D5A0E0005;
        Tue, 17 Oct 2023 13:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1697547947;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=7kp7KOQIeK3Tz5MUAMJMilNVGP28Xk/V+JDDymnN9pU=;
        b=fAQkLYzY3S1qDjGHfQ+x67rGYhIrcSP7KoSFj4042USYCAvY3CZHwhFJOpzXkCV08M1MDl
        0B7qz2S/JJkrp0yahZZscjtgsGXRMooMUhPSQ+eRzNxBuxe09Xl23vQipB5QvfXTDufRYU
        QMf4u1WkAJR/UagbY3dtRJEgDFlb67IzpAqknmROJP+XXO9X84ja4KPJ1Ecdj0SW9QM6id
        8HAxyod+lPWoX0Z8DxQV+oYFxcnoaOyjOFmEZDkHeiILGEmON7LCCB9f1PxdV3zME5PgyO
        EhhUbQMQu0tB9PrTZ4Ed1thNUOyWJNO6aFCRQ6oIxSj9GpWqXCarYRHalgZFbA==
From:   Thomas Richard <thomas.richard@bootlin.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org, tony@atomide.com
Cc:     linux-serial@vger.kernel.org, gregory.clement@bootlin.com,
        u-kumar1@ti.com, d-gole@ti.com, thomas.petazzoni@bootlin.com,
        Thomas Richard <thomas.richard@bootlin.com>
Subject: [PATCH] serial: 8250_omap: Set the console genpd always on if no console suspend
Date:   Tue, 17 Oct 2023 15:05:40 +0200
Message-Id: <20231017130540.1149721-1-thomas.richard@bootlin.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: thomas.richard@bootlin.com
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

If the console suspend is disabled, the genpd of the console shall not
be powered-off during suspend.
Set the flag GENPD_FLAG_ALWAYS_ON to the corresponding genpd during
suspend, and restore the original value during the resume.

Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
---
 drivers/tty/serial/8250/8250_omap.c | 33 ++++++++++++++++++++++++-----
 1 file changed, 28 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index ca972fd37725..91a483dc460c 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -27,6 +27,7 @@
 #include <linux/pm_wakeirq.h>
 #include <linux/dma-mapping.h>
 #include <linux/sys_soc.h>
+#include <linux/pm_domain.h>
 
 #include "8250.h"
 
@@ -114,6 +115,12 @@
 /* RX FIFO occupancy indicator */
 #define UART_OMAP_RX_LVL		0x19
 
+/*
+ * Copy of the genpd flags for the console.
+ * Only used if console suspend is disabled
+ */
+static unsigned int genpd_flags_console;
+
 struct omap8250_priv {
 	void __iomem *membase;
 	int line;
@@ -1617,6 +1624,7 @@ static int omap8250_suspend(struct device *dev)
 {
 	struct omap8250_priv *priv = dev_get_drvdata(dev);
 	struct uart_8250_port *up = serial8250_get_port(priv->line);
+	struct generic_pm_domain *genpd = pd_to_genpd(dev->pm_domain);
 	int err = 0;
 
 	serial8250_suspend_port(priv->line);
@@ -1627,8 +1635,19 @@ static int omap8250_suspend(struct device *dev)
 	if (!device_may_wakeup(dev))
 		priv->wer = 0;
 	serial_out(up, UART_OMAP_WER, priv->wer);
-	if (uart_console(&up->port) && console_suspend_enabled)
-		err = pm_runtime_force_suspend(dev);
+	if (uart_console(&up->port)) {
+		if (console_suspend_enabled)
+			err = pm_runtime_force_suspend(dev);
+		else {
+			/*
+			 * The pd shall not be powered-off (no console suspend).
+			 * Make copy of genpd flags before to set it always on.
+			 * The original value is restored during the resume.
+			 */
+			genpd_flags_console = genpd->flags;
+			genpd->flags |= GENPD_FLAG_ALWAYS_ON;
+		}
+	}
 	flush_work(&priv->qos_work);
 
 	return err;
@@ -1638,12 +1657,16 @@ static int omap8250_resume(struct device *dev)
 {
 	struct omap8250_priv *priv = dev_get_drvdata(dev);
 	struct uart_8250_port *up = serial8250_get_port(priv->line);
+	struct generic_pm_domain *genpd = pd_to_genpd(dev->pm_domain);
 	int err;
 
 	if (uart_console(&up->port) && console_suspend_enabled) {
-		err = pm_runtime_force_resume(dev);
-		if (err)
-			return err;
+		if (console_suspend_enabled) {
+			err = pm_runtime_force_resume(dev);
+			if (err)
+				return err;
+		} else
+			genpd->flags = genpd_flags_console;
 	}
 
 	serial8250_resume_port(priv->line);
-- 
2.39.2

