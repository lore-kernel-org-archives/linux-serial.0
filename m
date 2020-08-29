Return-Path: <SRS0=6ZGZ=CH=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4B38C433E6
	for <linux-serial@archiver.kernel.org>; Sat, 29 Aug 2020 14:42:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A45D720757
	for <linux-serial@archiver.kernel.org>; Sat, 29 Aug 2020 14:42:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=puresoftware-com.20150623.gappssmtp.com header.i=@puresoftware-com.20150623.gappssmtp.com header.b="FZT5VVxG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728012AbgH2Oms (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 29 Aug 2020 10:42:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727772AbgH2Omq (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 29 Aug 2020 10:42:46 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53C75C061236
        for <linux-serial@vger.kernel.org>; Sat, 29 Aug 2020 07:42:46 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id g207so2159123pfb.1
        for <linux-serial@vger.kernel.org>; Sat, 29 Aug 2020 07:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=puresoftware-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=HCgmVljL1Wo4qAwdUnk2VqI636YB8nMi5exWiiGudxo=;
        b=FZT5VVxG3F/c9V9VzemFzmwb+gdj42JsHmubt00I35yZeNkPy6vRZLjHL3L4VCb95N
         0MqbKBSX1uqF7nGcBwZcfqZZ75gVf1xuDIyHg2GPQOPIs0FxWzm+Bk927dRgKpQ+eBMg
         LaFoKdImFQKdWfU8pq+7m5GL4FZC7wXOueKhLgMWNeJhiOs4r9H1jj+k7VHzHAVdFVR8
         nKu2pSbVn7uqUEb8CchQ30lbg4rb52jVNVZNlgi2RnkJTOogy6o+txMewNpZ5UtcY8f9
         I6+c8PIGuD+kpu/StWvlb8GDPxWwMMFgZBsBwGsyscMJKdmp1q7ZY0leiRVOMb/3PEsH
         Kmsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=HCgmVljL1Wo4qAwdUnk2VqI636YB8nMi5exWiiGudxo=;
        b=r3Su9/rWoXvKYCPX3Dg9SgzTjZ740hyIYuK5zkOS4WVahisUsDAoNoHgswGHOrJiut
         WbnHNgt3Hh5QEsn+9tr5biFE5KysMb+MbjOM85exeY7jtXo01z4s2fWRvqXrp9Oj8J1L
         5WjVTOcPWJW327wztjDWuiMxLUnuy8PyUZiDTAmmWBYewwOgfS+z+n2KLogc00R83lpv
         1+QDHjBVnna5y/IuXm+UEDeRKDyRhsW8GTgmL7PoIyC59eMfATn85GMa3nDTLOw4Jg5f
         kvhON+zYvZ4nuM77Pc6x4Mgj0mOOtPScLEgNMkSRWT0JhXiAy+36DY/UzrWl8cV3jt3O
         Qqow==
X-Gm-Message-State: AOAM530+ZF4N9hnJEGzmAn84ExURxPJ/P/tmp9YULAaut4wcRZe/B+LK
        +uyUMS8O7AwlMxtDiCnE4Yc85A==
X-Google-Smtp-Source: ABdhPJzJnCZf1XCJCPKrcjvffE9sjB6kVxBJYh6NCVL5DHadr/L0lEbNouL6ll8Ry34qisBuN8FN/w==
X-Received: by 2002:a63:f00a:: with SMTP id k10mr2733097pgh.76.1598712165648;
        Sat, 29 Aug 2020 07:42:45 -0700 (PDT)
Received: from DESKTOP-C4AMQCQ.domain.name ([223.235.86.156])
        by smtp.gmail.com with ESMTPSA id 1sm2945334pfe.70.2020.08.29.07.42.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Aug 2020 07:42:44 -0700 (PDT)
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
Subject: [PATCH v3] serial: 8250_fsl: Add ACPI support
Date:   Sat, 29 Aug 2020 20:13:16 +0530
Message-Id: <20200829144316.18360-1-kuldip.dwivedi@puresoftware.com>
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

 drivers/tty/serial/8250/8250_fsl.c | 108 +++++++++++++++++++++++++++--
 1 file changed, 101 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_fsl.c b/drivers/tty/serial/8250/8250_fsl.c
index 0d0c80905c58..68bfbf392281 100644
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

