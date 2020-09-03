Return-Path: <SRS0=JhiI=CM=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A003AC433E2
	for <linux-serial@archiver.kernel.org>; Thu,  3 Sep 2020 11:34:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 635AE2071B
	for <linux-serial@archiver.kernel.org>; Thu,  3 Sep 2020 11:34:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=puresoftware-com.20150623.gappssmtp.com header.i=@puresoftware-com.20150623.gappssmtp.com header.b="Zk45BSDy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728642AbgICLeo (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 3 Sep 2020 07:34:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728654AbgICLef (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 3 Sep 2020 07:34:35 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59E2AC061244
        for <linux-serial@vger.kernel.org>; Thu,  3 Sep 2020 04:34:29 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id w186so1895218pgb.8
        for <linux-serial@vger.kernel.org>; Thu, 03 Sep 2020 04:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=puresoftware-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=GIhAtDHSULkq9UDDEn8D18f6PauihL6g4buDiUdIhiI=;
        b=Zk45BSDyeliENA4BeJgI6ttldqZ2tJAaUtHTpayIdFr2kLECFIARHDTcKRIjabe6GH
         JFH5XKKHSoxu7+Jc8ObCb5oS6cJwALOT42EgmP6UYX7PS5bz8EkoUaZxqF1cLC1ewsI7
         TA7NIV4fCehd0To3n+FkU5sDKV9SGQTe+huxIjPDW9eyYRy8TmixvSi/zpP38rbfUBER
         rGwqNf4GLwM9vvxLrneKj6+dGYMZLVsQ+m5cyCGemUctOHILVzHgIVcbDG4HwGs7txed
         dDyKWlacBiWWlmFBPhBJI8BxqwTA2S3XF9oECEDajR+0XNjpbBeionXx0HtEY/nUvv31
         cRbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=GIhAtDHSULkq9UDDEn8D18f6PauihL6g4buDiUdIhiI=;
        b=Da+EO9tCa3+AntX2QgA9RC1hvWrQcmvzv4rh6eN5xu944phjKZZWFsrLEwMToNOPR/
         hluVpAskjhZ7gI8ot9+hHTMnC8768R9PFo1pQhYXUnazX6Xxbax/7jyl5kS8ARZoLvjo
         V6yBaCWyN93JbNZq/hra10NkmWZV2trJjXtbVoj74FPBYiv/+Ty98ewIhfVZovO2uxCy
         V/zn90e9BqviKd3fK/aKo4MRE/FLmM8NMdFzJjw2xmBn2adTk5SZ97cDae+nch773ZDf
         oD3xzcD7a+x+60ufiP23y4EOiTm8bJidP33Hqvf3uM7roRsl0Tw1Y7BftkaLiQv4SpVP
         XTWg==
X-Gm-Message-State: AOAM530Tf1LXT/dSVkOyghBCV35/0KiJYXujWsE2I8XIEOgL5TBq7DX1
        lPfE7U/85ab1HXYe8ZsG1eoAJw==
X-Google-Smtp-Source: ABdhPJzoROqfcAWA7yLZfQ0igxJMsNdrSE8oIpaONQFPHlZpVYqVFcXCvZeAxdjb9H0mdXZUpBz+Jg==
X-Received: by 2002:a63:2b50:: with SMTP id r77mr2505656pgr.244.1599132868276;
        Thu, 03 Sep 2020 04:34:28 -0700 (PDT)
Received: from DESKTOP-C4AMQCQ.domain.name ([122.177.62.139])
        by smtp.gmail.com with ESMTPSA id n67sm2290071pgn.14.2020.09.03.04.34.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2020 04:34:27 -0700 (PDT)
From:   kuldip dwivedi <kuldip.dwivedi@puresoftware.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        linux-serial@vger.kernel.org
Cc:     Vabhav Sharma <vabhav.sharma@nxp.com>,
        Pankaj Bansal <pankaj.bansal@nxp.com>,
        Varun Sethi <V.Sethi@nxp.com>,
        Arokia Samy <arokia.samy@nxp.com>,
        kuldip dwivedi <kuldip.dwivedi@puresoftware.com>
Subject: [PATCH v4] serial: 8250_fsl: Add ACPI support
Date:   Thu,  3 Sep 2020 17:04:02 +0530
Message-Id: <20200903113402.12371-1-kuldip.dwivedi@puresoftware.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

This adds support for ACPI enumerated FSL 16550 UARTs.
For supporting ACPI, I added a wrapper so that this driver
can be used if firmware has exposed the HID "NXP0018" in
DSDT table.

This will be built as object file if config "SERIAL_8250_FSL"
is enabled which depends on config "SERIAL_8250_CONSOLE".

Signed-off-by: kuldip dwivedi <kuldip.dwivedi@puresoftware.com>
---

Notes:
    1. Move Copyright and File description at top of the file
    2. Add ACPI wrapper code within CONFIG_ACPI macro
    3. this change is tested with DT and ACPI boot on LS1046A platform
    4. add return code if serial8250_register_8250_port fails

 drivers/tty/serial/8250/8250_fsl.c | 108 +++++++++++++++++++++++++++--
 1 file changed, 101 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_fsl.c b/drivers/tty/serial/8250/8250_fsl.c
index 0d0c80905c58..c3582d8938d6 100644
--- a/drivers/tty/serial/8250/8250_fsl.c
+++ b/drivers/tty/serial/8250/8250_fsl.c
@@ -1,15 +1,12 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <linux/serial_reg.h>
-#include <linux/serial_8250.h>
-
-#include "8250.h"
-
 /*
  * Freescale 16550 UART "driver", Copyright (C) 2011 Paul Gortmaker.
+ * Copyright 2020 NXP
+ * Copyright 2020 Puresoftware Ltd.
  *
  * This isn't a full driver; it just provides an alternate IRQ
- * handler to deal with an errata.  Everything else is just
- * using the bog standard 8250 support.
+ * handler to deal with an errata and provide ACPI wrapper.
+ * Everything else is just using the bog standard 8250 support.
  *
  * We follow code flow of serial8250_default_handle_irq() but add
  * a check for a break and insert a dummy read on the Rx for the
@@ -20,6 +17,16 @@
  * IRQ event to the next one.
  */
 
+#include <linux/acpi.h>
+#include <linux/serial_reg.h>
+#include <linux/serial_8250.h>
+
+#include "8250.h"
+
+struct fsl8250_data {
+	int	line;
+};
+
 int fsl8250_handle_irq(struct uart_port *port)
 {
 	unsigned char lsr, orig_lsr;
@@ -79,3 +86,90 @@ int fsl8250_handle_irq(struct uart_port *port)
 	return 1;
 }
 EXPORT_SYMBOL_GPL(fsl8250_handle_irq);
+
+#ifdef CONFIG_ACPI
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
+	port8250.port.mapbase           = regs->start;
+	port8250.port.irq               = irq;
+	port8250.port.handle_irq        = fsl8250_handle_irq;
+	port8250.port.type              = PORT_16550A;
+	port8250.port.flags             = UPF_SHARE_IRQ | UPF_BOOT_AUTOCONF
+						| UPF_FIXED_PORT | UPF_IOREMAP
+						| UPF_FIXED_TYPE;
+	port8250.port.dev               = dev;
+	port8250.port.mapsize           = resource_size(regs);
+	port8250.port.iotype            = UPIO_MEM;
+	port8250.port.irqflags          = IRQF_SHARED;
+
+	port8250.port.membase = devm_ioremap(dev,  port8250.port.mapbase,
+							port8250.port.mapsize);
+	if (!port8250.port.membase)
+		return -ENOMEM;
+
+	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->line = serial8250_register_8250_port(&port8250);
+	if (data->line < 0)
+		return data->line;
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
+static const struct acpi_device_id fsl_8250_acpi_id[] = {
+	{ "NXP0018", 0 },
+	{ },
+};
+MODULE_DEVICE_TABLE(acpi, fsl_8250_acpi_id);
+
+static struct platform_driver fsl8250_platform_driver = {
+	.driver = {
+		.name			= "fsl-16550-uart",
+		.acpi_match_table	= ACPI_PTR(fsl_8250_acpi_id),
+	},
+	.probe			= fsl8250_acpi_probe,
+	.remove			= fsl8250_acpi_remove,
+};
+
+module_platform_driver(fsl8250_platform_driver);
+#endif
-- 
2.17.1

