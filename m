Return-Path: <SRS0=XS4C=B5=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EB2BC433E1
	for <linux-serial@archiver.kernel.org>; Wed, 19 Aug 2020 15:29:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 755B5208A9
	for <linux-serial@archiver.kernel.org>; Wed, 19 Aug 2020 15:29:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=puresoftware-com.20150623.gappssmtp.com header.i=@puresoftware-com.20150623.gappssmtp.com header.b="ZrJY90o9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726570AbgHSP3r (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 19 Aug 2020 11:29:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726751AbgHSP3q (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 19 Aug 2020 11:29:46 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 950C4C061757
        for <linux-serial@vger.kernel.org>; Wed, 19 Aug 2020 08:29:46 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id 17so11853687pfw.9
        for <linux-serial@vger.kernel.org>; Wed, 19 Aug 2020 08:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=puresoftware-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=Qo8ONY6C/+vbuQ0fAu9BGy9iWCpAninMHmbDqKmqwYs=;
        b=ZrJY90o9DyooqUqPA/R5WUhd+6aL2Z/32143t/G8vfEWbRbT2FqGDeU7avsykx+9qu
         oQrKFi9qQvrsSZ2saFXV9tv++/xG5AKWRQ8zuKV0a4xLQUWhLRRXaVyj+TY9t4hLUb2h
         ZwJ+H1ZUqJt8QGlQExtjIiGfuFqcy65sdawcE937MNihT7DjcXC+5Vvtd/mq2BJnEf2p
         WbaG86S7r3R5DdGJa9AKRmPbYcJ8wbBsj3mW/xRBVRKr1qu+6QP+EcNXoSKJTN5jH8lv
         FoJFezw32gSFv5HmzaLemtTJctzuHrq2QH4gsxzFcikisNA6uQHl8RibdtRlUHgwbWjN
         i+lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Qo8ONY6C/+vbuQ0fAu9BGy9iWCpAninMHmbDqKmqwYs=;
        b=YtctUVrdrnB38D4mUTdBsz9m98YFOgAvMbpQmjo8Lb9RD4tFZQ/hFjD9hNS613aigG
         Dg5SrvSTHEc+ugZ62Q0BROitxiw6cv8m89kdP9ian56paqXb4YVeFRmksHhNh7erVgRm
         h2Krmm2wvkZVELmIjxMu/yCjArvc3rikfY0vPkC5VY1vMAFBH2kxAfkyBpNQxjcfH+MU
         R/5cUyGyzfjxT0D9C9NvVEzEZk5AQN5ni6YHEhd7p4M00Ews7O+zXQJyXVwR8fMZKPtq
         qmgwWER4JkvtSktrO/qeX+vZ+TxOlEwmcu1RBZITga/XNfFciU5IaAdTVMTUqkxOjkhq
         +umA==
X-Gm-Message-State: AOAM530oX7ohrO3qVwQ6nk/8FuZ/7jH6j2s+GqYh8om+zgYbMBIk4v0Y
        //kl0xTphoaNciKok/nJZuyvpA==
X-Google-Smtp-Source: ABdhPJzu7Vcvo09VzgePIfYhIa4VooTkbenzLws//Do/msjVTMJtUe9CkYTFxi4jKXpxUQMtyEwRxg==
X-Received: by 2002:aa7:9ace:: with SMTP id x14mr15895559pfp.216.1597850985977;
        Wed, 19 Aug 2020 08:29:45 -0700 (PDT)
Received: from DESKTOP-C4AMQCQ.domain.name ([106.215.106.193])
        by smtp.gmail.com with ESMTPSA id ez7sm3414678pjb.10.2020.08.19.08.29.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2020 08:29:45 -0700 (PDT)
From:   kuldip dwivedi <kuldip.dwivedi@puresoftware.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        linux-serial@vger.kernel.org
Cc:     Vabhav Sharma <vabhav.sharma@nxp.com>,
        Pankaj Bansal <pankaj.bansal@nxp.com>,
        Varun Sethi <V.Sethi@nxp.com>,
        kuldip dwivedi <kuldip.dwivedi@puresoftware.com>
Subject: [PATCH] serial: 8250_fsl: Add ACPI support
Date:   Wed, 19 Aug 2020 20:59:35 +0530
Message-Id: <20200819152935.3182-1-kuldip.dwivedi@puresoftware.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

This adds support for ACPI enumerated FSL 16550 UARTs.

Signed-off-by: kuldip dwivedi <kuldip.dwivedi@puresoftware.com>
---
 drivers/tty/serial/8250/8250_fsl.c | 147 +++++++++++++++++++++++++----
 1 file changed, 131 insertions(+), 16 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_fsl.c b/drivers/tty/serial/8250/8250_fsl.c
index 0d0c80905c58..49e5987e538b 100644
--- a/drivers/tty/serial/8250/8250_fsl.c
+++ b/drivers/tty/serial/8250/8250_fsl.c
@@ -1,24 +1,50 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0+
+//
+// Freescale 16550 UART "driver"
+//
+// Copyright (C) 2011 Paul Gortmaker.
+// Copyright 2020 NXP
+// Copyright 2020 Puresoftware Ltd
+//
+// This isn't a full driver; it just provides an alternate IRQ
+// handler to deal with an errata.  Everything else is just
+// using the bog standard 8250 support.
+//
+// We follow code flow of serial8250_default_handle_irq() but add
+// a check for a break and insert a dummy read on the Rx for the
+// immediately following IRQ event.
+//
+// We re-use the already existing "bug handling" lsr_saved_flags
+// field to carry the "what we just did" information from the one
+// IRQ event to the next one.
+
+#include <linux/acpi.h>
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_irq.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/reset.h>
+#include <linux/slab.h>
+
 #include <linux/serial_reg.h>
 #include <linux/serial_8250.h>
 
+
+#include <asm/byteorder.h>
+
 #include "8250.h"
 
-/*
- * Freescale 16550 UART "driver", Copyright (C) 2011 Paul Gortmaker.
- *
- * This isn't a full driver; it just provides an alternate IRQ
- * handler to deal with an errata.  Everything else is just
- * using the bog standard 8250 support.
- *
- * We follow code flow of serial8250_default_handle_irq() but add
- * a check for a break and insert a dummy read on the Rx for the
- * immediately following IRQ event.
- *
- * We re-use the already existing "bug handling" lsr_saved_flags
- * field to carry the "what we just did" information from the one
- * IRQ event to the next one.
- */
+#define DRIVER_NAME "fsl-ns16550-uart"
+
+struct fsl8250_data {
+	int			line;
+};
 
 int fsl8250_handle_irq(struct uart_port *port)
 {
@@ -79,3 +105,92 @@ int fsl8250_handle_irq(struct uart_port *port)
 	return 1;
 }
 EXPORT_SYMBOL_GPL(fsl8250_handle_irq);
+
+static int fsl8250_acpi_probe(struct platform_device *pdev)
+{
+	struct fsl8250_data *data;
+	struct uart_8250_port port8250;
+	struct device *dev = &pdev->dev;
+	struct resource *regs;
+
+	int ret, irq;
+
+	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!regs) {
+		dev_err(dev, "no registers defined\n");
+		return -EINVAL;
+	}
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0) {
+		if (irq != -EPROBE_DEFER)
+			dev_err(dev, "cannot get irq\n");
+		return irq;
+	}
+
+	memset(&port8250, 0, sizeof(port8250));
+
+	ret = device_property_read_u32(dev, "clock-frequency",
+					&port8250.port.uartclk);
+	if (ret)
+		return ret;
+
+	spin_lock_init(&port8250.port.lock);
+
+	port8250.port.mapbase		= regs->start;
+	port8250.port.irq		= irq;
+	port8250.port.handle_irq	= fsl8250_handle_irq;
+	port8250.port.type		= PORT_16550A;
+	port8250.port.flags		= UPF_SHARE_IRQ | UPF_BOOT_AUTOCONF
+						| UPF_FIXED_PORT | UPF_IOREMAP
+						| UPF_FIXED_TYPE;
+	port8250.port.dev		= dev;
+	port8250.port.mapsize		= resource_size(regs);
+	port8250.port.iotype		= UPIO_MEM;
+	port8250.port.irqflags		= IRQF_SHARED;
+
+	port8250.port.membase = devm_ioremap(dev,  port8250.port.mapbase,
+						port8250.port.mapsize);
+	if (!port8250.port.membase)
+		return -ENOMEM;
+
+	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->line = serial8250_register_8250_port(&port8250);
+	if (data->line < 0)
+		ret = data->line;
+
+	platform_set_drvdata(pdev, data);
+	return 0;
+}
+
+static int fsl8250_acpi_remove(struct platform_device *pdev)
+{
+	struct fsl8250_data *data = platform_get_drvdata(pdev);
+
+	serial8250_unregister_port(data->line);
+	return 0;
+}
+
+static const struct acpi_device_id fsl8250_acpi_match[] = {
+	{ "NXP0018", 0 },
+	{ },
+};
+MODULE_DEVICE_TABLE(acpi, fsl8250_acpi_match);
+
+static struct platform_driver fsl8250_platform_driver = {
+	.driver = {
+		.name			= "fsl-16550-uart",
+		.acpi_match_table	= ACPI_PTR(fsl8250_acpi_match),
+	},
+	.probe			= fsl8250_acpi_probe,
+	.remove			= fsl8250_acpi_remove,
+};
+
+module_platform_driver(fsl8250_platform_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("FSL 8250 serial port driver");
+MODULE_ALIAS("platform:" DRIVER_NAME);
-- 
2.17.1

