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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C428C4708C
	for <linux-serial@archiver.kernel.org>; Fri, 28 May 2021 09:23:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64CD66127A
	for <linux-serial@archiver.kernel.org>; Fri, 28 May 2021 09:23:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235378AbhE1JYz (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 28 May 2021 05:24:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbhE1JYy (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 28 May 2021 05:24:54 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A4C8C061574
        for <linux-serial@vger.kernel.org>; Fri, 28 May 2021 02:23:19 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id gb21-20020a17090b0615b029015d1a863a91so4133224pjb.2
        for <linux-serial@vger.kernel.org>; Fri, 28 May 2021 02:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/WVHrIpor0dL51Uaa6NbJ7cDLvRKdFTSnd/4zJGDHBE=;
        b=IgTmYp8VMaoIjvUWZEvjDd4MUqLQNZPq/mQnpfBU63jpNWX+D1VsaiZa25F1VgTyMy
         KduEzQCWwdBK3zCqtVJXG21hkOQlI12Y4Wbir9rcR9VfN7QYbUHDIJsEKb9A+q30HZJm
         mQt+eyVGRs0dNQoz9u3jr5N9zVgHdw/PBSFEEw1/ol04k9ooXMiSQ6TmhhCDJYkSAXZ/
         ET6FW0b+fw2XemE4HyP35dfOZPIOiP6pAlKc6F+qScfmwQYEARW+BKgnjqhJYXdyvhxM
         gHI4Cga0PYBGGhhs9/Xq/KalIi2J3TsqtVlPTXITNEJsKJxRW8MTpV6D1O7o9R229+H4
         p9BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/WVHrIpor0dL51Uaa6NbJ7cDLvRKdFTSnd/4zJGDHBE=;
        b=IWuN9LOVvnAM7nhUV+ycUmfgHuQ9xntqzohrvLEquhcHpLhhfIjg4VHMMFNDhTCtTb
         36vGDwuUYLPFqFF7fQlpW2jhXebDqbnl/mDWM8GfQ5DWhdx+WBlrgM2niKy878SoUntd
         D1sc2+QN6stl42iAI18ogJW6Yd+dhVq1jOVG0F/MoDfPjoipdejfYKJ8kbxp0wKeSzNq
         IzP58PTS2Gk2iPHEUAGtBD9oSDgo2Khy2mAxycTv45QexyaB/SR2ROlPKactV1U5a0lw
         M+My96lkt2c3M9VMyw/OboDUiX6yYIfhUdHKuB5x9Vj9heV5i1aRt9z3m7It1fhA0A55
         aulA==
X-Gm-Message-State: AOAM532LYfwk9koDJsyyd70nPjF6chjazGbBAleTiFyImfq2kPDW/MWU
        NpZRTX705kNiwE8E4hJkP2k=
X-Google-Smtp-Source: ABdhPJzGDKSz/9HdjpVtxZhLGhTtj3wwuBwbaTy0MAkxFHa8elx+y2te8Nv7xphgdsNVcgGPRyXsVg==
X-Received: by 2002:a17:90a:d14f:: with SMTP id t15mr3535245pjw.160.1622193798874;
        Fri, 28 May 2021 02:23:18 -0700 (PDT)
Received: from test-System-Product-Name.sunix.com.tw (61-220-142-250.HINET-IP.hinet.net. [61.220.142.250])
        by smtp.gmail.com with ESMTPSA id o6sm3983131pfb.126.2021.05.28.02.23.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 02:23:18 -0700 (PDT)
From:   Moriis Ku <saumah@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, jason_lee@sunix.com,
        taian.chen@sunix.com, Morris Ku <saumah@gmail.com>
Subject: [PATCH] serial:Add SUNIX SDC serial port driver
Date:   Fri, 28 May 2021 17:23:07 +0800
Message-Id: <20210528092307.5950-1-saumah@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Morris Ku <saumah@gmail.com>

SUNIX SDC serial port driver.

Cc: Jason Lee <jason_lee@sunix.com>
Cc: Taian Chen <taian.chen@sunix.com>
Signed-off-by: Morris Ku <saumah@gmail.com>
---
 8250_sdc.c | 519 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 519 insertions(+)
 create mode 100644 8250_sdc.c

diff --git a/drivers/tty/serial/8250_sdc.c b/8250_sdc.c
new file mode 100644
index 0000000..85ff351
--- /dev/null
+++ b/drivers/tty/serial//8250_sdc.c
@@ -0,0 +1,519 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * SUNIX SDC serial port driver.
+ *
+ * Copyright (C) 2021, SUNIX Co., Ltd.
+ *
+ * Based on Synopsys DesignWare 8250 driver written by
+ * - Copyright 2011 Picochip, Jamie Iles.
+ * - Copyright 2013 Intel Corporation
+ */
+
+#include <linux/module.h>
+#include <linux/pm_runtime.h>
+#include <linux/of_platform.h>
+#include <linux/debugfs.h>
+#include <linux/serial_8250.h>
+
+struct sdc8250_port_data {
+	int bus_number;
+	int device_number;
+	int irq;
+
+	unsigned char number;
+	unsigned char version;
+	unsigned char resource_cap;
+	unsigned char event_type;
+
+	unsigned short tx_fifo_size;
+	unsigned short rx_fifo_size;
+	unsigned int significand;
+	unsigned char exponent;
+	unsigned char rs232_cap;
+	unsigned char rs422_cap;
+	unsigned char rs485_cap;
+	unsigned char ahdc_cap;
+	unsigned char cs_cap;
+	unsigned char rs422_end_cap;
+	unsigned char rs485_end_cap;
+
+	int line;
+};
+
+#define UART_SDC_V0_UMER				0x0e
+
+struct sdc8250_data {
+	struct sdc8250_port_data data;
+	struct uart_8250_port uart;
+	struct device *device;
+	char device_name[50];
+	struct dentry *debugfs;
+	struct debugfs_blob_wrapper debugfs_blob_device_name;
+
+	struct resource *regs;
+	int fifosize;
+	unsigned long long clk_rate;
+	unsigned char umr;
+};
+
+static struct dentry *sdc_serial_debugfs;
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
+	int ret = 0;
+	unsigned char umr = 0;
+	unsigned char umr_check = 0;
+
+	if (rs485->flags & SER_RS485_ENABLED) {
+		if (rs485->flags & SER_RS485_RX_DURING_TX) {
+			// rs422
+			if (data->data.rs422_cap == 0x01) {
+				umr = 0x02;
+
+				if (rs485->flags & SER_RS485_TERMINATE_BUS) {
+					if (data->data.rs422_end_cap == 0x01) {
+						umr |= 0x40;
+					} else {
+						dev_err(p->dev, "no RS422 termination cap.\n");
+						ret = -EINVAL;
+					}
+				}
+			} else {
+				dev_err(p->dev, "no RS422 cap.\n");
+				ret = -EINVAL;
+			}
+		} else {
+			// rs485
+			if (data->data.rs485_cap == 0x01) {
+				umr = 0x04;
+
+				if (data->data.ahdc_cap == 0x01)
+					umr |= 0x08;
+
+				if (data->data.cs_cap == 0x01)
+					umr |= 0x10;
+
+				if (rs485->flags & SER_RS485_TERMINATE_BUS) {
+					if (data->data.rs485_end_cap == 0x01) {
+						umr |= 0x80;
+					} else {
+						dev_err(p->dev, "no RS485 termination cap.\n");
+						ret = -EINVAL;
+					}
+				}
+			} else {
+				dev_err(p->dev, "no RS485 cap.\n");
+				ret = -EINVAL;
+			}
+		}
+	} else {
+		// rs232
+		if (data->data.rs232_cap == 0x01) {
+			umr = 0x01;
+		} else {
+			dev_err(p->dev, "no rs232 cap.\n");
+			ret = -EINVAL;
+		}
+	}
+
+	if (ret == 0) {
+		do {
+			outb(umr, p->iobase + UART_SDC_V0_UMER);
+			umr_check = inb(p->iobase + UART_SDC_V0_UMER);
+			if (umr != umr_check) {
+				ret = -EIO;
+				break;
+			}
+
+			data->umr = umr;
+			p->rs485 = *rs485;
+
+		} while (false);
+	}
+
+	return ret;
+}
+
+static int sdc8250_debugfs_add(struct sdc8250_data *data)
+{
+	struct dentry *root_dir;
+	char root_name[20];
+
+	memset(root_name, 0, sizeof(root_name));
+	sprintf(root_name, "ttyS%d", data->data.line);
+	root_dir = debugfs_create_dir(root_name, sdc_serial_debugfs);
+	if (IS_ERR(root_dir))
+		return PTR_ERR(root_dir);
+
+	debugfs_create_u32("bus_number", 0644, root_dir,
+		&data->data.bus_number);
+	debugfs_create_u32("device_number", 0644, root_dir,
+		&data->data.device_number);
+	debugfs_create_u32("irq", 0644, root_dir, &data->data.irq);
+	debugfs_create_u8("number", 0644, root_dir, &data->data.number);
+	debugfs_create_u8("version", 0644, root_dir, &data->data.version);
+	debugfs_create_u8("resource_cap", 0644, root_dir,
+		&data->data.resource_cap);
+	debugfs_create_u8("event_type", 0644, root_dir,
+		&data->data.event_type);
+	debugfs_create_u16("tx_fifo_size", 0644, root_dir,
+		&data->data.tx_fifo_size);
+	debugfs_create_u16("rx_fifo_size", 0644, root_dir,
+		&data->data.rx_fifo_size);
+	debugfs_create_u32("significand", 0644, root_dir,
+		&data->data.significand);
+	debugfs_create_u8("exponent", 0644, root_dir,
+		&data->data.exponent);
+	debugfs_create_u8("rs232_cap", 0644, root_dir, &data->data.rs232_cap);
+	debugfs_create_u8("rs422_cap", 0644, root_dir, &data->data.rs422_cap);
+	debugfs_create_u8("rs485_cap", 0644, root_dir, &data->data.rs485_cap);
+	debugfs_create_u8("ahdc_cap", 0644, root_dir, &data->data.ahdc_cap);
+	debugfs_create_u8("cs_cap", 0644, root_dir, &data->data.cs_cap);
+	debugfs_create_u8("rs422_end_cap", 0644, root_dir,
+		&data->data.rs422_end_cap);
+	debugfs_create_u8("rs485_end_cap", 0644, root_dir,
+		&data->data.rs485_end_cap);
+	debugfs_create_u32("line", 0644, root_dir, &data->data.line);
+
+	memset(data->device_name, 0, sizeof(data->device_name));
+	sprintf(data->device_name, "%s", dev_name(data->device));
+	data->device_name[strlen(data->device_name)] = 0x0a;
+	data->debugfs_blob_device_name.data = data->device_name;
+	data->debugfs_blob_device_name.size = strlen(data->device_name) + 1;
+	debugfs_create_blob("device_name", 0644, root_dir,
+		&data->debugfs_blob_device_name);
+
+	data->debugfs = root_dir;
+	return 0;
+}
+
+static void sdc8250_debugfs_remove(struct sdc8250_data *data)
+{
+	debugfs_remove_recursive(data->debugfs);
+}
+
+static int sdc8250_read_property(struct sdc8250_data *data,
+				struct device *dev)
+{
+	int ret;
+
+	ret = device_property_read_u32(dev, "bus_number",
+				&data->data.bus_number);
+	if (ret < 0)
+		return -EINVAL;
+	ret = device_property_read_u32(dev, "device_number",
+				&data->data.device_number);
+	if (ret < 0)
+		return -EINVAL;
+	ret = device_property_read_u32(dev, "irq", &data->data.irq);
+	if (ret < 0)
+		return -EINVAL;
+	ret = device_property_read_u8(dev, "number", &data->data.number);
+	if (ret < 0)
+		return -EINVAL;
+	ret = device_property_read_u8(dev, "version", &data->data.version);
+	if (ret < 0)
+		return -EINVAL;
+	ret = device_property_read_u8(dev, "resource_cap",
+				&data->data.resource_cap);
+	if (ret < 0)
+		return -EINVAL;
+	ret = device_property_read_u8(dev, "event_type",
+				&data->data.event_type);
+	if (ret < 0)
+		return -EINVAL;
+	ret = device_property_read_u16(dev, "tx_fifo_size",
+				&data->data.tx_fifo_size);
+	if (ret < 0)
+		return -EINVAL;
+	ret = device_property_read_u16(dev, "rx_fifo_size",
+				&data->data.rx_fifo_size);
+	if (ret < 0)
+		return -EINVAL;
+	ret = device_property_read_u32(dev, "significand",
+				&data->data.significand);
+	if (ret < 0)
+		return -EINVAL;
+	ret = device_property_read_u8(dev, "exponent",
+				&data->data.exponent);
+	if (ret < 0)
+		return -EINVAL;
+	ret = device_property_read_u8(dev, "rs232_cap", &data->data.rs232_cap);
+	if (ret < 0)
+		return -EINVAL;
+	ret = device_property_read_u8(dev, "rs422_cap", &data->data.rs422_cap);
+	if (ret < 0)
+		return -EINVAL;
+	ret = device_property_read_u8(dev, "rs485_cap", &data->data.rs485_cap);
+	if (ret < 0)
+		return -EINVAL;
+	ret = device_property_read_u8(dev, "ahdc_cap", &data->data.ahdc_cap);
+	if (ret < 0)
+		return -EINVAL;
+	ret = device_property_read_u8(dev, "cs_cap", &data->data.cs_cap);
+	if (ret < 0)
+		return -EINVAL;
+	ret = device_property_read_u8(dev, "rs422_end_cap",
+				&data->data.rs422_end_cap);
+	if (ret < 0)
+		return -EINVAL;
+	ret = device_property_read_u8(dev, "rs485_end_cap",
+				&data->data.rs485_end_cap);
+	if (ret < 0)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int config_rs422485(struct sdc8250_data *data,
+				struct serial_rs485 *rs485)
+{
+	int ret = 0;
+	unsigned char umr_check = 0;
+
+	memset(rs485, 0, sizeof(struct serial_rs485));
+	if (data->data.version == 0x00) {
+		data->umr = inb(data->regs->start + UART_SDC_V0_UMER);
+		if ((data->umr & 0x07) == 0x01) {
+			// rs232 mode
+
+		} else if ((data->umr & 0x07) == 0x02) {
+			// rs422 mode
+			rs485->flags =
+				SER_RS485_ENABLED | SER_RS485_RX_DURING_TX;
+
+			if (data->umr & 0x40)
+				rs485->flags |= SER_RS485_TERMINATE_BUS;
+
+		} else if ((data->umr & 0x07) == 0x04) {
+			// rs485 mode
+			rs485->flags = SER_RS485_ENABLED;
+
+			if (data->umr & 0x80)
+				rs485->flags |= SER_RS485_TERMINATE_BUS;
+
+			if (data->data.ahdc_cap == 0x01)
+				data->umr |= 0x08;
+
+			if (data->data.cs_cap == 0x01)
+				data->umr |= 0x10;
+
+			outb(data->umr, data->regs->start + UART_SDC_V0_UMER);
+			umr_check = inb(data->regs->start + UART_SDC_V0_UMER);
+
+			if (data->umr != umr_check)
+				ret = -EIO;
+
+		} else {
+			ret = -EINVAL;
+		}
+	} else {
+		ret = -EINVAL;
+	}
+	return ret;
+}
+
+static int sdc8250_probe(struct platform_device *pdev)
+{
+	int ret;
+	int i;
+	struct uart_8250_port *up = NULL;
+	struct uart_port *p = NULL;
+	struct sdc8250_data *data;
+	struct device *dev = &pdev->dev;
+	struct resource *regs = platform_get_resource(pdev, IORESOURCE_IO, 0);
+	int irq;
+	unsigned long long exponent;
+	struct serial_rs485 rs485;
+
+	if (!regs) {
+		dev_err(dev, "no registers defined\n");
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
+	ret = sdc8250_read_property(data, dev);
+	if (ret < 0) {
+		dev_err(dev, "failed to read property\n");
+		return ret;
+	}
+	data->device = dev;
+	data->regs = regs;
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
+	ret = config_rs422485(data, &rs485);
+	if (ret < 0)
+		goto err_do_nothing;
+
+	spin_lock_init(&p->lock);
+	p->iotype       = UPIO_PORT;
+	p->iobase       = regs->start;
+	p->mapbase      = 0;
+	p->membase      = NULL;
+	p->regshift     = 0;
+
+	p->irq          = irq;
+	p->type         = PORT_SUNIX;
+	p->flags        = UPF_SHARE_IRQ | UPF_FIXED_PORT | UPF_FIXED_TYPE;
+	p->fifosize     = data->fifosize;
+	p->dev          = dev;
+	p->uartclk      = data->clk_rate;
+	p->private_data = &data->data;
+
+	p->pm           = sdc8250_do_pm;
+	p->rs485_config = sdc8250_rs485_config;
+	memcpy(&p->rs485, &rs485, sizeof(rs485));
+
+	data->data.line = serial8250_register_8250_port(up);
+	if (data->data.line < 0) {
+		ret = data->data.line;
+		goto err_do_nothing;
+	}
+
+	ret = sdc8250_debugfs_add(data);
+	if (ret)
+		dev_warn(dev, "failed to create debugfs entries\n");
+
+	platform_set_drvdata(pdev, data);
+
+	pm_runtime_set_active(dev);
+	pm_runtime_enable(dev);
+	return 0;
+
+err_do_nothing:
+	dev_err(dev, "failed to register, error:%d\n", ret);
+	return ret;
+}
+
+static int sdc8250_remove(struct platform_device *pdev)
+{
+	struct sdc8250_data *data = platform_get_drvdata(pdev);
+	struct device *dev = &pdev->dev;
+
+	pm_runtime_get_sync(dev);
+
+	sdc8250_debugfs_remove(data);
+	serial8250_unregister_port(data->data.line);
+
+	pm_runtime_disable(dev);
+	pm_runtime_put_noidle(dev);
+	return 0;
+}
+
+#ifdef CONFIG_PM_SLEEP
+static int sdc8250_suspend(struct device *dev)
+{
+	struct sdc8250_data *data = dev_get_drvdata(dev);
+
+	// save umr
+	data->umr = inb(data->uart.port.iobase + UART_SDC_V0_UMER);
+
+	serial8250_suspend_port(data->data.line);
+	return 0;
+}
+
+static int sdc8250_resume(struct device *dev)
+{
+	struct sdc8250_data *data = dev_get_drvdata(dev);
+
+	// restore umr
+	outb(data->umr, data->uart.port.iobase + UART_SDC_V0_UMER);
+
+	serial8250_resume_port(data->data.line);
+	return 0;
+}
+#endif
+
+#ifdef CONFIG_PM
+static int sdc8250_runtime_suspend(struct device *dev)
+{
+	return 0;
+}
+
+static int sdc8250_runtime_resume(struct device *dev)
+{
+	return 0;
+}
+#endif
+
+static const struct dev_pm_ops sdc8250_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(sdc8250_suspend, sdc8250_resume)
+	SET_RUNTIME_PM_OPS(sdc8250_runtime_suspend,
+		sdc8250_runtime_resume, NULL)
+};
+
+static const struct of_device_id sdc8250_of_match[] = {
+	{ .compatible = "sunix,sdc_serial" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, sdc8250_of_match);
+
+static struct platform_driver sdc8250_platform_driver = {
+	.driver = {
+		.name = "8250_sdc",
+		.pm = &sdc8250_pm_ops,
+		.of_match_table = sdc8250_of_match,
+	},
+	.probe = sdc8250_probe,
+	.remove = sdc8250_remove,
+};
+
+static int __init sdc8250_init(void)
+{
+	sdc_serial_debugfs = debugfs_create_dir("sdc_serial", NULL);
+	platform_driver_register(&sdc8250_platform_driver);
+	return 0;
+}
+module_init(sdc8250_init);
+
+static void __exit sdc8250_exit(void)
+{
+	platform_driver_unregister(&sdc8250_platform_driver);
+	debugfs_remove(sdc_serial_debugfs);
+}
+module_exit(sdc8250_exit);
+
+MODULE_AUTHOR("Jason Lee <jason_lee@sunix.com>");
+MODULE_DESCRIPTION("SUNIX SDC serial port driver");
+MODULE_LICENSE("GPL");
+
+MODULE_ALIAS("platform:8250_sdc");
+
+
-- 
2.20.1

