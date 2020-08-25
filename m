Return-Path: <SRS0=bk4J=CD=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 901A6C433E1
	for <linux-serial@archiver.kernel.org>; Tue, 25 Aug 2020 13:31:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 624642075F
	for <linux-serial@archiver.kernel.org>; Tue, 25 Aug 2020 13:31:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=puresoftware-com.20150623.gappssmtp.com header.i=@puresoftware-com.20150623.gappssmtp.com header.b="IqzhAx/7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbgHYNbv (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 25 Aug 2020 09:31:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbgHYNbq (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 25 Aug 2020 09:31:46 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44BB4C061574
        for <linux-serial@vger.kernel.org>; Tue, 25 Aug 2020 06:31:46 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id k1so524646pfu.2
        for <linux-serial@vger.kernel.org>; Tue, 25 Aug 2020 06:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=puresoftware-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=reVyZcjfjFRKhdIEu7BZa746KxQSU4C7yl+ue/7rtb8=;
        b=IqzhAx/7Q7ccnPnw2barejPJw9Z+fddOu8kiPesw9S/jOV95G6gni/VZYkxVp3FiqA
         bOAEDRWfQ34vJPSV31SbLzHcWOSFDrTv9c8nCEl4FuVMH3lZGdlCaVuGs1l0b3E5oKDD
         RDNNkjsyy0f8J3mlVmk4jmHLpbpk9xEOFp8XcEw1MWgjcbMuO7knkD09wDjGBLzBQdzE
         K7j+ZYsMNhojSzy3lfx00GXD9/d6vEpn5VLYuVvxi0zrgQTE7vuaZ6nw/C5plfWWYlrP
         ybGXhs9SxlgLuRhDvHSRVnqw0T0Qqyw9IgbGD/Bv9FablPDAsQxCg+zZzl0Jtb1pSQDV
         eTbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=reVyZcjfjFRKhdIEu7BZa746KxQSU4C7yl+ue/7rtb8=;
        b=JYAhB5XsE3GXdpdcfFGk3kP1dtqqtCQTuO0oki/0ScDMtsApvo+YU/OFo52JUN2u2c
         o9WCrtEAHczjCNHJZ29yjgKMzlSgyqXm5TbcJ/ftBm6bzChKhPvYupDOXc/hBNkyc+he
         lZRowtvj2w6GZh96BPCx33ZHA8EiGMJj12FZiYxajR/VR0om+GamelU+JyRMcYIuPxKI
         6YLaMi4A0O/UCL++pvt1QrD+Grx0NDC/Yt2mAEW+xdrzhq2IWtE0krRUfAVWpWEFE6Hi
         Yq0S7YvYZODapmT2WscLUjL62xlQgZ5XKc/3B5hoBfwFZvONJKd57uWdMxJ/RrRsLH4g
         envw==
X-Gm-Message-State: AOAM531wbnSOy1jPqJNeN7/fdjTq2c3GUuNwbyHaDi+JaAafunCrmCXA
        I0+W2hyQSk7gNq0lDw//ZCvOQpl89tGEUhnE
X-Google-Smtp-Source: ABdhPJzpEAI3x6ccvhnQdl3fDacaB0nQk3ydMpmOTsJbSGH6nw05XURjy0vvwTH1+iVGKhrhoPrngw==
X-Received: by 2002:a62:14c4:: with SMTP id 187mr7787353pfu.164.1598362305650;
        Tue, 25 Aug 2020 06:31:45 -0700 (PDT)
Received: from DESKTOP-C4AMQCQ.domain.name ([122.177.131.241])
        by smtp.gmail.com with ESMTPSA id q16sm16277636pfg.153.2020.08.25.06.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 06:31:45 -0700 (PDT)
From:   kuldip dwivedi <kuldip.dwivedi@puresoftware.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        linux-serial@vger.kernel.org
Cc:     Vabhav Sharma <vabhav.sharma@nxp.com>,
        Pankaj Bansal <pankaj.bansal@nxp.com>,
        Varun Sethi <V.Sethi@nxp.com>,
        kuldip dwivedi <kuldip.dwivedi@puresoftware.com>
Subject: [PATCH v2] serial: 8250_fsl: Add ACPI support
Date:   Tue, 25 Aug 2020 19:01:35 +0530
Message-Id: <20200825133135.807-1-kuldip.dwivedi@puresoftware.com>
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
    1. revert the license change from v1
    2. revert the file header format change from v1
    3. remove extra headers from v1
    4. this is tested on layerscape platform LS1046A
       with the firmware having ACPI support.
    
       This will be built as object file if config " SERIAL_8250_FSL"
       is enabled which depends on config " SERIAL_8250_CONSOLE ".
       this driver will be probed if firmware has exposed HID " NXP0018" in DSDT table

 drivers/tty/serial/8250/8250_fsl.c | 98 ++++++++++++++++++++++++++++++
 1 file changed, 98 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_fsl.c b/drivers/tty/serial/8250/8250_fsl.c
index 0d0c80905c58..62e5e2d33f69 100644
--- a/drivers/tty/serial/8250/8250_fsl.c
+++ b/drivers/tty/serial/8250/8250_fsl.c
@@ -1,11 +1,16 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <linux/acpi.h>
 #include <linux/serial_reg.h>
 #include <linux/serial_8250.h>
 
 #include "8250.h"
 
+#define DRIVER_NAME		"fsl-ns16550-uart"
+
 /*
  * Freescale 16550 UART "driver", Copyright (C) 2011 Paul Gortmaker.
+ * Copyright 2020 NXP
+ * Copyright 2020 Puresoftware Ltd.
  *
  * This isn't a full driver; it just provides an alternate IRQ
  * handler to deal with an errata.  Everything else is just
@@ -20,6 +25,10 @@
  * IRQ event to the next one.
  */
 
+struct fsl8250_data {
+	int	line;
+};
+
 int fsl8250_handle_irq(struct uart_port *port)
 {
 	unsigned char lsr, orig_lsr;
@@ -79,3 +88,92 @@ int fsl8250_handle_irq(struct uart_port *port)
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
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("FSL 8250 serial port driver");
+MODULE_ALIAS("platform:" DRIVER_NAME);
-- 
2.17.1

