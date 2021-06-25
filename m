Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3932C2B9F4
	for <linux-serial@archiver.kernel.org>; Fri, 25 Jun 2021 09:30:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B71DB61423
	for <linux-serial@archiver.kernel.org>; Fri, 25 Jun 2021 09:30:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231386AbhFYJcr (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 25 Jun 2021 05:32:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231381AbhFYJcq (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 25 Jun 2021 05:32:46 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73BD7C061574
        for <linux-serial@vger.kernel.org>; Fri, 25 Jun 2021 02:30:26 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id e20so7143243pgg.0
        for <linux-serial@vger.kernel.org>; Fri, 25 Jun 2021 02:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B5/oZGer8z5llG7kA1s3RFiUGt8mNtbrQeoljIIbpM0=;
        b=C6Pf5xqE2qhEn0usRBvS1HOV7IaButDuMXQ/f2Q0THQxNE00gjW9bId1VBYem3QDbV
         I4OnBJY6W1fomXX6cvcbeao7p+1SfT93nLtB+p1C4Lo3HPXokE99oaGJn/wHNdnjrgqt
         ZnTjaXxarTmqU/v5Tp1OKImVfjkRcOQERlZ1yOEuT7FolGo6P4vDmnuuY0WofKcapUU3
         01jxbgFcDeiV1JodV91Tp0FAXOLpI34iV9+numro+mPrktqF8nJX7brBkICae8yn1AvW
         SF0XETznRXIRw9/nibZmY1baGwerdP7hj8yrZDRi+Nsx/9kn/StoA75DYWJ9wSSnGHyy
         VgZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B5/oZGer8z5llG7kA1s3RFiUGt8mNtbrQeoljIIbpM0=;
        b=WbtsQZfRyDzdVKMQ2uxE+Qg5F/8nxjblnFsfugI5qUeFt03Sw0VJsk1b13xapraVif
         MhDWldA9hsy24UhspHS77JIKANPDFcubY2eARO8DbHOEzRHDzuPxyzk41pkAbDhVi5ZZ
         ugY6z6JQv3ovsn71bECnOzeKZ1bK7GPRKUNi9RBsSlVefDx5Kx2Am74cy5rWnKU53E5B
         SCJTHhsCQpmlwvdEh+lnlUhnW7T+d6WpaFPdG7LXlqWTNL/akC7Z/q4kN7S5Ch4yaOpB
         HpusFOx2xAunOooxBuLBQIIkKK7S6GBKj+qbJ9tP9uWZTPh1Thkj6iwQkp3SAJwjWQdB
         ekGw==
X-Gm-Message-State: AOAM530Ejl7x7Og014BAlHCDoCB8pdvYtUg0/ZGlz7Ig/2X9SB1vp3yF
        qHEGhb+PDYlzFLe4r3J+UVQ=
X-Google-Smtp-Source: ABdhPJyiX7AADbscZGXFxxeBuO/FLESFz5bPDgN7aVweDcgPTHSSx8scerSokk/vma0buk4m9qoYXw==
X-Received: by 2002:a05:6a00:1983:b029:2fe:bc09:3042 with SMTP id d3-20020a056a001983b02902febc093042mr9915441pfl.72.1624613425984;
        Fri, 25 Jun 2021 02:30:25 -0700 (PDT)
Received: from test-System-Product-Name.sunix.com.tw (61-220-142-250.HINET-IP.hinet.net. [61.220.142.250])
        by smtp.gmail.com with ESMTPSA id z23sm5071091pjn.2.2021.06.25.02.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jun 2021 02:30:25 -0700 (PDT)
From:   Moriis Ku <saumah@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, jason_lee@sunix.com,
        taian.chen@sunix.com, morris_ku@sunix.com, edward.lee@sunix.com,
        Morris Ku <saumah@gmail.com>, Edward Lee <Edward.lee@sunix.com>
Subject: [PATCH] SUNIX SDC serial port driver
Date:   Fri, 25 Jun 2021 17:30:11 +0800
Message-Id: <20210625093011.12659-1-saumah@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Morris Ku <saumah@gmail.com>

Add support for SUNIX SDC serial port

Cc: Taian Chen <taian.chen@sunix.com>
Cc: Morris Ku <morris_ku@sunix.com>
Cc: Edward Lee <Edward.lee@sunix.com>
Signed-off-by: Morris Ku <saumah@gmail.com>
---
 8250_sdc.c | 410 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 410 insertions(+)
 create mode 100644 8250_sdc.c

diff --git a/8250_sdc.c b/8250_sdc.c
new file mode 100644
index 0000000..3ec9ce7
--- /dev/null
+++ b/8250_sdc.c
@@ -0,0 +1,410 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * SUNIX SDC serial port driver.
+ *
+ * Copyright (C) 2021, SUNIX Co., Ltd.
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/pm_runtime.h>
+#include <linux/of_platform.h>
+#include <linux/io.h>
+#include <linux/debugfs.h>
+#include <linux/serial_8250.h>
+
+#define DRIVER_NAME		"8250_sdc"
+
+struct sdc8250_port_data {
+	u32 board_id;
+	u8 chl_number;
+	u8 version;
+	u16 tx_fifo_size;
+	u16 rx_fifo_size;
+	u32 significand;
+	u8 exponent;
+	u32 capability;
+
+	int line;
+};
+
+#define SDC_UART_UMR				0x0e
+
+#define SDC_UART_RS232				BIT(0)
+#define SDC_UART_RS422				BIT(1)
+#define SDC_UART_RS485				BIT(2)
+#define SDC_UART_MODE_MASK			GENMASK(2, 0)
+#define SDC_UART_AHDC				BIT(3)
+#define SDC_UART_CS					BIT(4)
+#define SDC_UART_AUTO_RS422485		BIT(5)
+#define SDC_UART_RS422_TERMINATION	BIT(6)
+#define SDC_UART_RS485_TERMINATION	BIT(7)
+
+struct sdc8250_data {
+	struct sdc8250_port_data data;
+	struct uart_8250_port uart;
+	struct device *dev;
+	struct resource *res;
+	int fifosize;
+	unsigned long long clk_rate;
+	u8 umr_suspend;
+};
+
+static inline struct sdc8250_data *to_sdc8250_data(
+				struct sdc8250_port_data *data)
+{
+	return container_of(data, struct sdc8250_data, data);
+}
+
+static void sdc8250_do_pm(struct uart_port *p, unsigned int state,
+				unsigned int old)
+{
+	if (!state)
+		pm_runtime_get_sync(p->dev);
+
+	serial8250_do_pm(p, state, old);
+
+	if (state)
+		pm_runtime_put_sync_suspend(p->dev);
+}
+
+static int sdc8250_rs485_config(struct uart_port *p,
+				struct serial_rs485 *rs485)
+{
+	struct sdc8250_data *data = to_sdc8250_data(p->private_data);
+	u32 flags = rs485->flags;
+	int ret;
+	u8 umr;
+
+	if (!(flags & SER_RS485_ENABLED)) {
+		if (!(data->data.capability & SDC_UART_RS232)) {
+			dev_err(data->dev, "no RS232 cap.\n");
+			ret = -EINVAL;
+			goto err_out;
+		}
+		umr = SDC_UART_RS232;
+
+	} else if ((flags & SER_RS485_ENABLED) &&
+				(flags & SER_RS485_RX_DURING_TX)) {
+		if (!(data->data.capability & SDC_UART_RS422)) {
+			dev_err(data->dev, "no RS422 cap.\n");
+			ret = -EINVAL;
+			goto err_out;
+		}
+		umr = SDC_UART_RS422;
+
+		if (flags & SER_RS485_TERMINATE_BUS) {
+			if (!(data->data.capability &
+					SDC_UART_RS422_TERMINATION)) {
+				dev_err(data->dev, "no RS422 termination cap.\n");
+				ret = -EINVAL;
+				goto err_out;
+			}
+			umr |= SDC_UART_RS422_TERMINATION;
+		}
+
+	} else if (flags & SER_RS485_ENABLED) {
+		if (!(data->data.capability & SDC_UART_RS485)) {
+			dev_err(data->dev, "no RS485 cap.\n");
+			ret = -EINVAL;
+			goto err_out;
+		}
+		umr = SDC_UART_RS485;
+
+		if (data->data.capability & SDC_UART_AHDC)
+			umr |= SDC_UART_AHDC;
+
+		if (data->data.capability & SDC_UART_CS)
+			umr |= SDC_UART_CS;
+
+		if (flags & SER_RS485_TERMINATE_BUS) {
+			if (!(data->data.capability &
+					SDC_UART_RS485_TERMINATION)) {
+				dev_err(data->dev, "no RS485 termination cap.\n");
+				ret = -EINVAL;
+				goto err_out;
+			}
+			umr |= SDC_UART_RS485_TERMINATION;
+		}
+
+	} else {
+		ret = -EINVAL;
+		goto err_out;
+	}
+
+	outb(umr, p->iobase + SDC_UART_UMR);
+	p->rs485 = *rs485;
+	return 0;
+
+err_out:
+	return ret;
+}
+
+static int sdc8250_read_property(struct sdc8250_port_data *data,
+				struct device *dev)
+{
+	int ret;
+
+	ret = device_property_read_u32(dev, "board_id", &data->board_id);
+	if (ret < 0)
+		return -EINVAL;
+	ret = device_property_read_u8(dev, "chl_number", &data->chl_number);
+	if (ret < 0)
+		return -EINVAL;
+	ret = device_property_read_u8(dev, "version", &data->version);
+	if (ret < 0)
+		return -EINVAL;
+	ret = device_property_read_u16(dev, "tx_fifo_size",
+			&data->tx_fifo_size);
+	if (ret < 0)
+		return -EINVAL;
+	ret = device_property_read_u16(dev, "rx_fifo_size",
+			&data->rx_fifo_size);
+	if (ret < 0)
+		return -EINVAL;
+	ret = device_property_read_u32(dev, "significand", &data->significand);
+	if (ret < 0)
+		return -EINVAL;
+	ret = device_property_read_u8(dev, "exponent", &data->exponent);
+	if (ret < 0)
+		return -EINVAL;
+	ret = device_property_read_u32(dev, "capability", &data->capability);
+	if (ret < 0)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int sdc8250_rs485_init(struct sdc8250_data *data,
+				struct serial_rs485 *rs485)
+{
+	int ret = 0;
+	u8 umr;
+
+	if (data->data.version != 0)
+		return -EINVAL;
+
+	memset(rs485, 0, sizeof(struct serial_rs485));
+	umr = inb(data->res->start + SDC_UART_UMR);
+	if ((umr & SDC_UART_MODE_MASK) == SDC_UART_RS232) {
+		/* RS232 mode */
+
+	} else if ((umr & SDC_UART_MODE_MASK) == SDC_UART_RS422) {
+		/* RS422 mode */
+		rs485->flags = SER_RS485_ENABLED | SER_RS485_RX_DURING_TX;
+
+		if (umr & SDC_UART_RS422_TERMINATION)
+			rs485->flags |= SER_RS485_TERMINATE_BUS;
+
+	} else if ((umr & SDC_UART_MODE_MASK) == SDC_UART_RS485) {
+		/* RS485 mode */
+		rs485->flags = SER_RS485_ENABLED;
+
+		if (umr & SDC_UART_RS485_TERMINATION)
+			rs485->flags |= SER_RS485_TERMINATE_BUS;
+
+		if (data->data.capability & SDC_UART_AHDC)
+			umr |= SDC_UART_AHDC;
+
+		if (data->data.capability & SDC_UART_CS)
+			umr |= SDC_UART_CS;
+
+		outb(umr, data->res->start + SDC_UART_UMR);
+
+	} else {
+		ret = -EINVAL;
+	}
+
+	return ret;
+}
+
+#ifdef CONFIG_DEBUG_FS
+
+static struct dentry *sdc8250_debugfs;
+#define SDC8250_DEBUGFS_FORMAT		"b%d:uart%d"
+
+static void sdc8250_debugfs_add(struct sdc8250_data *data)
+{
+	struct dentry *dir;
+	char name[32];
+
+	snprintf(name, sizeof(name), SDC8250_DEBUGFS_FORMAT,
+		data->data.board_id, data->data.chl_number);
+	dir = debugfs_create_dir(name, sdc8250_debugfs);
+	debugfs_create_x8("version", 0444, dir, &data->data.version);
+	debugfs_create_x32("capability", 0444, dir, &data->data.capability);
+	debugfs_create_u32("line", 0444, dir, &data->data.line);
+}
+
+static void sdc8250_debugfs_remove(struct sdc8250_data *data)
+{
+	struct dentry *dir;
+	char name[32];
+
+	snprintf(name, sizeof(name), SDC8250_DEBUGFS_FORMAT,
+		data->data.board_id, data->data.chl_number);
+	dir = debugfs_lookup(name, sdc8250_debugfs);
+	debugfs_remove_recursive(dir);
+}
+
+static void sdc8250_debugfs_init(void)
+{
+	sdc8250_debugfs = debugfs_create_dir(DRIVER_NAME, NULL);
+}
+
+static void sdc8250_debugfs_exit(void)
+{
+	debugfs_remove(sdc8250_debugfs);
+}
+#else
+static void sdc8250_debugfs_add(struct sdc8250_data *data) {}
+static void sdc8250_debugfs_remove(struct sdc8250_data *data) {}
+static void sdc8250_debugfs_init(void) {}
+static void sdc8250_debugfs_exit(void) {}
+#endif
+
+static int sdc8250_probe(struct platform_device *pdev)
+{
+	unsigned long long exponent;
+	struct uart_8250_port *up;
+	struct sdc8250_data *data;
+	struct serial_rs485 rs485;
+	struct uart_port *p;
+	struct resource *res;
+	struct device *dev;
+	int irq;
+	int ret;
+	int i;
+
+	dev = &pdev->dev;
+
+	res = platform_get_resource(pdev, IORESOURCE_IO, 0);
+	if (!res) {
+		dev_err(dev, "no resource defined\n");
+		return -EINVAL;
+	}
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return irq;
+
+	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	ret = sdc8250_read_property(&data->data, dev);
+	if (ret < 0) {
+		dev_err(dev, "failed to read property\n");
+		return ret;
+	}
+	data->dev = dev;
+	data->res = res;
+	up = &data->uart;
+	p = &up->port;
+
+	data->fifosize = data->data.rx_fifo_size;
+	if (data->fifosize > data->data.tx_fifo_size)
+		data->fifosize = data->data.tx_fifo_size;
+
+	exponent = 1;
+	for (i = 0; i < data->data.exponent; i++)
+		exponent *= 10;
+	data->clk_rate = data->data.significand * exponent;
+
+	ret = sdc8250_rs485_init(data, &rs485);
+	if (ret < 0)
+		goto err_out;
+
+	spin_lock_init(&p->lock);
+	p->iotype       = UPIO_PORT;
+	p->iobase       = res->start;
+	p->regshift     = 0;
+	p->irq          = irq;
+	p->type         = PORT_SUNIX;
+	p->flags        = UPF_SHARE_IRQ | UPF_FIXED_PORT | UPF_FIXED_TYPE;
+	p->fifosize     = data->fifosize;
+	p->uartclk      = data->clk_rate;
+	p->private_data = &data->data;
+	p->pm           = sdc8250_do_pm;
+	p->rs485_config = sdc8250_rs485_config;
+	memcpy(&p->rs485, &rs485, sizeof(rs485));
+
+	data->data.line = serial8250_register_8250_port(up);
+	if (data->data.line < 0) {
+		ret = data->data.line;
+		goto err_out;
+	}
+	platform_set_drvdata(pdev, data);
+
+	sdc8250_debugfs_add(data);
+	return 0;
+
+err_out:
+	dev_err(dev, "failed to probe, err %d\n", ret);
+	return ret;
+}
+
+static int sdc8250_remove(struct platform_device *pdev)
+{
+	struct sdc8250_data *data = platform_get_drvdata(pdev);
+
+	sdc8250_debugfs_remove(data);
+	serial8250_unregister_port(data->data.line);
+	return 0;
+}
+
+#ifdef CONFIG_PM_SLEEP
+static int sdc8250_suspend(struct device *dev)
+{
+	struct sdc8250_data *data = dev_get_drvdata(dev);
+
+	/* Save umr */
+	data->umr_suspend = inb(data->uart.port.iobase + SDC_UART_UMR);
+	serial8250_suspend_port(data->data.line);
+	return 0;
+}
+
+static int sdc8250_resume(struct device *dev)
+{
+	struct sdc8250_data *data = dev_get_drvdata(dev);
+
+	/* Restore umr */
+	outb(data->umr_suspend, data->uart.port.iobase + SDC_UART_UMR);
+	serial8250_resume_port(data->data.line);
+	return 0;
+}
+#endif
+
+static const struct dev_pm_ops sdc8250_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(sdc8250_suspend, sdc8250_resume)
+};
+
+static struct platform_driver sdc8250_platform_driver = {
+	.driver = {
+		.name = DRIVER_NAME,
+		.pm = &sdc8250_pm_ops,
+	},
+	.probe = sdc8250_probe,
+	.remove = sdc8250_remove,
+};
+
+static int __init sdc8250_init(void)
+{
+	sdc8250_debugfs_init();
+	platform_driver_register(&sdc8250_platform_driver);
+	return 0;
+}
+module_init(sdc8250_init);
+
+static void __exit sdc8250_exit(void)
+{
+	platform_driver_unregister(&sdc8250_platform_driver);
+	sdc8250_debugfs_exit();
+}
+module_exit(sdc8250_exit);
+
+MODULE_AUTHOR("Jason Lee <jason_lee@sunix.com>");
+MODULE_DESCRIPTION("SUNIX SDC serial port driver");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:" DRIVER_NAME);
-- 
2.20.1

