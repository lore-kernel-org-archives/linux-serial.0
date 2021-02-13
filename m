Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A764AC4332B
	for <linux-serial@archiver.kernel.org>; Sat, 13 Feb 2021 11:59:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FC1E64E43
	for <linux-serial@archiver.kernel.org>; Sat, 13 Feb 2021 11:59:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbhBML7S (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 13 Feb 2021 06:59:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbhBML7Q (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 13 Feb 2021 06:59:16 -0500
Received: from mail.kapsi.fi (mail.kapsi.fi [IPv6:2001:67c:1be8::25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCB6FC061574;
        Sat, 13 Feb 2021 03:58:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
         s=20161220; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject
        :Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=XLP55EATsSO4oRJZjhOd8usd4mNT0ulbG8E51An8HnI=; b=BU3GnddsLCGvq0a0oc79kjsc6z
        aLy9XFRpygGDBY7jDMPvPibG6D17Kkf/MWy7mQHBE0OtstIQE7cNLqwOWmRHc68vkaR0VybPoRrbN
        ZYAgZ78fgxLjB+odGcwoVFmXe8Dwvw0Yg8oGyeUR7J4KQlcVWI6p4e+ykjHe+/RKCV6yGpxO/BHTb
        4YJ1Bq387cwK7lc0OouamY+BME8IbwSCghnWujdd1+L6/9s+U3j+QjDEnV4x/3AjXTt9asNFOk9YE
        hXc5jvjp2Q+o2jBEFsKKBc3n6F1KHFfC4/MzITOaAn9aKrvH35KabwITw0CxxG7jN6900KuznkPnB
        ZreqbEcQ==;
Received: from dsl-hkibng22-54f986-236.dhcp.inet.fi ([84.249.134.236] helo=toshino.localdomain)
        by mail.kapsi.fi with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <mperttunen@nvidia.com>)
        id 1lAtZF-0004O8-3c; Sat, 13 Feb 2021 13:58:29 +0200
From:   Mikko Perttunen <mperttunen@nvidia.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-tegra@vger.kernel.org,
        Mikko Perttunen <mperttunen@nvidia.com>
Subject: [PATCH] tty: serial: Add earlycon driver for Tegra Combined UART
Date:   Sat, 13 Feb 2021 13:58:24 +0200
Message-Id: <20210213115824.3306965-1-mperttunen@nvidia.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 84.249.134.236
X-SA-Exim-Mail-From: mperttunen@nvidia.com
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Add an earlycon driver for platforms with TCU, namely Tegra194.
The driver is compatible with boot parameters passed by NVIDIA
boot chains.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 drivers/tty/serial/Kconfig              | 12 +++++
 drivers/tty/serial/Makefile             |  1 +
 drivers/tty/serial/tegra-tcu-earlycon.c | 72 +++++++++++++++++++++++++
 3 files changed, 85 insertions(+)
 create mode 100644 drivers/tty/serial/tegra-tcu-earlycon.c

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 34a2899e69c0..d941785e3f46 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -331,6 +331,18 @@ config SERIAL_TEGRA_TCU_CONSOLE
 
 	  If unsure, say Y.
 
+config SERIAL_TEGRA_TCU_EARLYCON
+	bool "Earlycon on NVIDIA Tegra Combined UART"
+	depends on ARCH_TEGRA || COMPILE_TEST
+	select SERIAL_EARLYCON
+	select SERIAL_CORE_CONSOLE
+	default y if SERIAL_TEGRA_TCU_CONSOLE
+	help
+	  If you say Y here, TCU output will be supported during the earlycon
+	  phase of the boot.
+
+	  If unsure, say Y.
+
 config SERIAL_MAX3100
 	tristate "MAX3100 support"
 	depends on SPI
diff --git a/drivers/tty/serial/Makefile b/drivers/tty/serial/Makefile
index b85d53f9e9ff..408144326fed 100644
--- a/drivers/tty/serial/Makefile
+++ b/drivers/tty/serial/Makefile
@@ -72,6 +72,7 @@ obj-$(CONFIG_SERIAL_XILINX_PS_UART) += xilinx_uartps.o
 obj-$(CONFIG_SERIAL_SIRFSOC) += sirfsoc_uart.o
 obj-$(CONFIG_SERIAL_TEGRA) += serial-tegra.o
 obj-$(CONFIG_SERIAL_TEGRA_TCU) += tegra-tcu.o
+obj-$(CONFIG_SERIAL_TEGRA_TCU_EARLYCON) += tegra-tcu-earlycon.o
 obj-$(CONFIG_SERIAL_AR933X)   += ar933x_uart.o
 obj-$(CONFIG_SERIAL_EFM32_UART) += efm32-uart.o
 obj-$(CONFIG_SERIAL_ARC)	+= arc_uart.o
diff --git a/drivers/tty/serial/tegra-tcu-earlycon.c b/drivers/tty/serial/tegra-tcu-earlycon.c
new file mode 100644
index 000000000000..9decfbced0a7
--- /dev/null
+++ b/drivers/tty/serial/tegra-tcu-earlycon.c
@@ -0,0 +1,72 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2017-2021, NVIDIA CORPORATION.  All rights reserved.
+ */
+
+#include <linux/console.h>
+#include <linux/io.h>
+#include <linux/serial_core.h>
+
+#define NUM_BYTES_FIELD_BIT	24
+#define FLUSH_BIT		26
+#define INTR_TRIGGER_BIT	31
+
+static u32 update_and_send_mbox(u8 __iomem *addr, u32 mbox_val, char c)
+{
+	int bytes = bytes = (mbox_val >> NUM_BYTES_FIELD_BIT) & 0x3;
+
+	mbox_val |= BIT(INTR_TRIGGER_BIT);
+	mbox_val |= c << (bytes * 8);
+	bytes++;
+	mbox_val = (mbox_val & ~(3 << NUM_BYTES_FIELD_BIT)) |
+		(bytes << NUM_BYTES_FIELD_BIT);
+
+	if (bytes == 3) {
+		/* Send current packet to SPE */
+		while (readl(addr) & BIT(INTR_TRIGGER_BIT))
+			cpu_relax();
+		writel(mbox_val, addr);
+		mbox_val = BIT(INTR_TRIGGER_BIT);
+	}
+
+	return mbox_val;
+}
+
+/*
+ * This function splits the string to be printed (const char *s) into multiple
+ * packets. Each packet contains a max of 3 characters. Packets are sent to the
+ * SPE-based combined UART server for printing. Communication with SPE is done
+ * through mailbox registers which can generate interrupts for SPE.
+ */
+static void early_tcu_write(struct console *console, const char *s, unsigned int count)
+{
+	struct earlycon_device *device = console->data;
+	u8 __iomem *addr = device->port.membase;
+	u32 mbox_val = BIT(INTR_TRIGGER_BIT);
+	unsigned int i;
+
+	/* Loop for processing each 3 char packet */
+	for (i = 0; i < count; i++) {
+		if (s[i] == '\n')
+			mbox_val = update_and_send_mbox(addr, mbox_val, '\r');
+		mbox_val = update_and_send_mbox(addr, mbox_val, s[i]);
+	}
+
+	if ((mbox_val >> NUM_BYTES_FIELD_BIT) & 0x3) {
+		while (readl(addr) & BIT(INTR_TRIGGER_BIT))
+			cpu_relax();
+		writel(mbox_val, addr);
+	}
+}
+
+int __init early_tegra_combined_uart_setup(struct earlycon_device *device, const char *options)
+{
+	if (!(device->port.membase))
+		return -ENODEV;
+
+	device->con->write = early_tcu_write;
+
+	return 0;
+}
+
+EARLYCON_DECLARE(tegra_comb_uart, early_tegra_combined_uart_setup);
-- 
2.30.0

