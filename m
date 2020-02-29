Return-Path: <SRS0=2m+P=4R=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72325C3F2C6
	for <linux-serial@archiver.kernel.org>; Sat, 29 Feb 2020 23:20:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D29E24688
	for <linux-serial@archiver.kernel.org>; Sat, 29 Feb 2020 23:20:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z/oYm6iz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727254AbgB2XUr (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 29 Feb 2020 18:20:47 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:39997 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726786AbgB2XUr (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 29 Feb 2020 18:20:47 -0500
Received: by mail-lj1-f195.google.com with SMTP id 143so7539798ljj.7
        for <linux-serial@vger.kernel.org>; Sat, 29 Feb 2020 15:20:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Zh6dM3X3Hj4sRAbtG5NhxuLtJ3eLiUC7wlZGAVOLhN8=;
        b=Z/oYm6izWe+LTCoSmC4XaIyrJSerI6gHfjvTDxufKKbADEZ3gWA6PrpHNfKwoSq1Qp
         lAMg6seqJP+jEdbuzGUu3UMl3grcxE9w9GaKi/49avTjmzNrklK+18YSxMTsnIqFOiw3
         WDEmUQnlaBaqOHOrEauWBMYv8X264Hlw7Rn7LeFxE6MUOrCoiusudQvXrnEvF5yVmc33
         Q15OHgyp0bfAVTqXMM71UKmNrrmT/nxPM4Nt+NUf5qIESzI7gHcxbSjeA/k7LUbswdQG
         KyB+RlPQ/YGaGBHClnnFK4TKUunKaroSVN+pygF/uwa9C7N1YyBGHARu4dJkJBphT2Lg
         IcXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Zh6dM3X3Hj4sRAbtG5NhxuLtJ3eLiUC7wlZGAVOLhN8=;
        b=ImLqZCyu3YIhxZOyo9ypraNCGcnPcjh+I/3mDS703kkv0bcwRRDF/UPrJpysqO1rHZ
         PM4NGUpag25URZ5MVRtHYKdnxlChOXTgxD8F0FFPPTZ0jx9hBD24EMSEtcu+VpeVV6Rd
         ga7Wnh3DSNOefMFufFmRqRa3X2tPZSUKPcVp1IhvBBtB1SWLhhb5P4wh/OmVVzmIssuY
         nUuR6dzLp2SbH8w0pCQhD0RCm3i9c4tx2bUX08awdXZLWeYNsqTI/PKfQJC7VlTagDMi
         /aufZzGlAi/B0+dchyKs4+e3k264v1wiuENIEfxjWO2lyDs93Dwe9VnIF13l6AuV/kLd
         6fkQ==
X-Gm-Message-State: ANhLgQ3B5P0uLaHyNCsXHJ/Iuvnrj1uXnKD68KFLCrjzg2weAuBAK5fl
        G/0U3pnnovhi+uD8OURjIF4w3DYVtNU=
X-Google-Smtp-Source: ADFU+vuXukib4miwxLAfR0yvkY40XSeLFPnz706rjCNMfmiAcdPeHzqrUdkFAefOLw15S/Hh7s0vKA==
X-Received: by 2002:a2e:3608:: with SMTP id d8mr7051871lja.152.1583018445104;
        Sat, 29 Feb 2020 15:20:45 -0800 (PST)
Received: from localhost.localdomain (c-5ac9225c.014-348-6c756e10.bbcust.telenor.se. [92.34.201.90])
        by smtp.gmail.com with ESMTPSA id z8sm8695796ljc.44.2020.02.29.15.20.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Feb 2020 15:20:44 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] tty: serial: cpm_uart: Convert to use GPIO descriptors
Date:   Sun,  1 Mar 2020 00:18:42 +0100
Message-Id: <20200229231842.247563-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The CPM UART (PowerPC) has an open coded GPIO modem control
handling. Since I can't test this I can't just migrate it to
the serial mctrl GPIO helper library though I wish I could.
I do second best and convert it to GPIO descriptors at least.

Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Christophe Leroy <christophe.leroy@c-s.fr>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
NB: only compile tested, that much works.
---
 drivers/tty/serial/cpm_uart/cpm_uart.h      |  4 +-
 drivers/tty/serial/cpm_uart/cpm_uart_core.c | 48 +++++++++------------
 2 files changed, 24 insertions(+), 28 deletions(-)

diff --git a/drivers/tty/serial/cpm_uart/cpm_uart.h b/drivers/tty/serial/cpm_uart/cpm_uart.h
index 9f175a92fb5d..f775b042457a 100644
--- a/drivers/tty/serial/cpm_uart/cpm_uart.h
+++ b/drivers/tty/serial/cpm_uart/cpm_uart.h
@@ -13,6 +13,8 @@
 #include <linux/platform_device.h>
 #include <linux/fs_uart_pd.h>
 
+struct gpio_desc;
+
 #if defined(CONFIG_CPM2)
 #include "cpm_uart_cpm2.h"
 #elif defined(CONFIG_CPM1)
@@ -80,7 +82,7 @@ struct uart_cpm_port {
 	int			wait_closing;
 	/* value to combine with opcode to form cpm command */
 	u32			command;
-	int			gpios[NUM_GPIOS];
+	struct gpio_desc	*gpios[NUM_GPIOS];
 };
 
 extern int cpm_uart_nr;
diff --git a/drivers/tty/serial/cpm_uart/cpm_uart_core.c b/drivers/tty/serial/cpm_uart/cpm_uart_core.c
index 19d5a4cf29a6..f3c52d204f34 100644
--- a/drivers/tty/serial/cpm_uart/cpm_uart_core.c
+++ b/drivers/tty/serial/cpm_uart/cpm_uart_core.c
@@ -30,8 +30,7 @@
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
-#include <linux/gpio.h>
-#include <linux/of_gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/clk.h>
 
 #include <asm/io.h>
@@ -88,11 +87,11 @@ static void cpm_uart_set_mctrl(struct uart_port *port, unsigned int mctrl)
 	struct uart_cpm_port *pinfo =
 		container_of(port, struct uart_cpm_port, port);
 
-	if (pinfo->gpios[GPIO_RTS] >= 0)
-		gpio_set_value(pinfo->gpios[GPIO_RTS], !(mctrl & TIOCM_RTS));
+	if (pinfo->gpios[GPIO_RTS])
+		gpiod_set_value(pinfo->gpios[GPIO_RTS], !(mctrl & TIOCM_RTS));
 
-	if (pinfo->gpios[GPIO_DTR] >= 0)
-		gpio_set_value(pinfo->gpios[GPIO_DTR], !(mctrl & TIOCM_DTR));
+	if (pinfo->gpios[GPIO_DTR])
+		gpiod_set_value(pinfo->gpios[GPIO_DTR], !(mctrl & TIOCM_DTR));
 }
 
 static unsigned int cpm_uart_get_mctrl(struct uart_port *port)
@@ -101,23 +100,23 @@ static unsigned int cpm_uart_get_mctrl(struct uart_port *port)
 		container_of(port, struct uart_cpm_port, port);
 	unsigned int mctrl = TIOCM_CTS | TIOCM_DSR | TIOCM_CAR;
 
-	if (pinfo->gpios[GPIO_CTS] >= 0) {
-		if (gpio_get_value(pinfo->gpios[GPIO_CTS]))
+	if (pinfo->gpios[GPIO_CTS]) {
+		if (gpiod_get_value(pinfo->gpios[GPIO_CTS]))
 			mctrl &= ~TIOCM_CTS;
 	}
 
-	if (pinfo->gpios[GPIO_DSR] >= 0) {
-		if (gpio_get_value(pinfo->gpios[GPIO_DSR]))
+	if (pinfo->gpios[GPIO_DSR]) {
+		if (gpiod_get_value(pinfo->gpios[GPIO_DSR]))
 			mctrl &= ~TIOCM_DSR;
 	}
 
-	if (pinfo->gpios[GPIO_DCD] >= 0) {
-		if (gpio_get_value(pinfo->gpios[GPIO_DCD]))
+	if (pinfo->gpios[GPIO_DCD]) {
+		if (gpiod_get_value(pinfo->gpios[GPIO_DCD]))
 			mctrl &= ~TIOCM_CAR;
 	}
 
-	if (pinfo->gpios[GPIO_RI] >= 0) {
-		if (!gpio_get_value(pinfo->gpios[GPIO_RI]))
+	if (pinfo->gpios[GPIO_RI]) {
+		if (!gpiod_get_value(pinfo->gpios[GPIO_RI]))
 			mctrl |= TIOCM_RNG;
 	}
 
@@ -1139,6 +1138,7 @@ static int cpm_uart_init_port(struct device_node *np,
 {
 	const u32 *data;
 	void __iomem *mem, *pram;
+	struct device *dev = pinfo->port.dev;
 	int len;
 	int ret;
 	int i;
@@ -1211,29 +1211,23 @@ static int cpm_uart_init_port(struct device_node *np,
 	}
 
 	for (i = 0; i < NUM_GPIOS; i++) {
-		int gpio;
+		struct gpio_desc *gpiod;
 
-		pinfo->gpios[i] = -1;
+		pinfo->gpios[i] = NULL;
 
-		gpio = of_get_gpio(np, i);
+		gpiod = devm_gpiod_get_index(dev, NULL, i, GPIOD_ASIS);
 
-		if (gpio_is_valid(gpio)) {
-			ret = gpio_request(gpio, "cpm_uart");
-			if (ret) {
-				pr_err("can't request gpio #%d: %d\n", i, ret);
-				continue;
-			}
+		if (gpiod) {
 			if (i == GPIO_RTS || i == GPIO_DTR)
-				ret = gpio_direction_output(gpio, 0);
+				ret = gpiod_direction_output(gpiod, 0);
 			else
-				ret = gpio_direction_input(gpio);
+				ret = gpiod_direction_input(gpiod);
 			if (ret) {
 				pr_err("can't set direction for gpio #%d: %d\n",
 					i, ret);
-				gpio_free(gpio);
 				continue;
 			}
-			pinfo->gpios[i] = gpio;
+			pinfo->gpios[i] = gpiod;
 		}
 	}
 
-- 
2.24.1

