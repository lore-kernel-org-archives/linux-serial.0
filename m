Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42667C4708D
	for <linux-serial@archiver.kernel.org>; Fri,  9 Dec 2022 14:12:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbiLIOMW (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 9 Dec 2022 09:12:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbiLIOLb (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 9 Dec 2022 09:11:31 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5D0AF020
        for <linux-serial@vger.kernel.org>; Fri,  9 Dec 2022 06:07:49 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id bg10so3668092wmb.1
        for <linux-serial@vger.kernel.org>; Fri, 09 Dec 2022 06:07:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D9hs664qju1jr9botwPcx4yk7u/Ban5WI5fBxEeXJKY=;
        b=2gKaMzEdJu6183MaIfhqG4qOE/65iIziO/nRwAObuSx4Gm0EDfG4Ie9WcFu66ogkwY
         +9jvVIDsn/U1+Z4s80gq1895PXrcYg++MeBy6vC9z0/xX/t5BtjKozmbJR2snQc0BMSP
         aYvtX5rRKPPOvRHa/LDM9zf5P231MuPbav/pVwRhtt8eAtNkFkyN1fglU9VChnMcRY6c
         NOQoyrYQwSn3hChQDY3wV84H7RNKgz3GeSi0aX7sCIbc63ss1jeeJN12w+iRhs2QYdVS
         WKENBc2WW/UoDdZ1g36Y/R2vTPw/0VMGXJS0EKe4K2/vmZqx7v1fAdoCFnVPvQ96uUMJ
         0WbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D9hs664qju1jr9botwPcx4yk7u/Ban5WI5fBxEeXJKY=;
        b=q5eZJsGKYTCisIsGhC+2OMmxQG/izA1Ypjd0lvms81GHOx5lE0QGag517dga4Z5ls4
         dw1jARPkydmFyobCr/o6mBTiAy+DqDuAu/yBDloDQpUPCZCrjDG1M2oskuz2DOzKPY/K
         //buqQ44iloUVpetlwATgSENR6FTuxkKSl1YwjlX0W/hQMaF0GpoGPeZ+Dy9hOWGv8zf
         Ly1WoLT1TY9dhE32uAgpBvi8RBcBOFfoKdjG99eE2WjX9tFxUjy3NMV8Lx0ZS7X9Gt+l
         zwwqnciXhVa86xR30WsQuhHHGFvxxbxKGKcw2hb2MnL1TRKVjVgAwgnQIwqOS2SwekHp
         ZkNQ==
X-Gm-Message-State: ANoB5plvbbWE/hHJCLZoyaRgedhXZOV9f70IxpS1arv4ytvbFyFstrEM
        6emdkMfwh2cGSE7iCNGpveDbxQ==
X-Google-Smtp-Source: AA0mqf6+aVu/uc8c7VIta+ZcJNe3jBqQU1GY0l6/UKg7sU1blxWJBYrBieE9sgl3NVTdOIy13JgyWQ==
X-Received: by 2002:a05:600c:5010:b0:3d0:71d1:7931 with SMTP id n16-20020a05600c501000b003d071d17931mr5385549wmr.8.1670594856387;
        Fri, 09 Dec 2022 06:07:36 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:51db:8fd7:45e0:fe69])
        by smtp.gmail.com with ESMTPSA id q3-20020a1c4303000000b003cfa81e2eb4sm1869848wma.38.2022.12.09.06.07.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 06:07:36 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, Alex Elder <elder@kernel.org>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-serial@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 1/2] tty: serial: provide devm_uart_add_one_port()
Date:   Fri,  9 Dec 2022 15:07:30 +0100
Message-Id: <20221209140731.573503-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221209140731.573503-1-brgl@bgdev.pl>
References: <20221209140731.573503-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Provide a devres variant of uart_add_one_port() that removes the managed
port at device detach.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 .../driver-api/driver-model/devres.rst        |  3 ++
 drivers/tty/serial/serial_core.c              | 48 +++++++++++++++++++
 include/linux/serial_core.h                   |  6 +++
 3 files changed, 57 insertions(+)

diff --git a/Documentation/driver-api/driver-model/devres.rst b/Documentation/driver-api/driver-model/devres.rst
index 56082265e8e5..5d07a8c1eadb 100644
--- a/Documentation/driver-api/driver-model/devres.rst
+++ b/Documentation/driver-api/driver-model/devres.rst
@@ -436,6 +436,9 @@ RTC
 SERDEV
   devm_serdev_device_open()
 
+SERIAL
+  devm_uart_add_one_port()
+
 SLAVE DMA ENGINE
   devm_acpi_dma_controller_register()
 
diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 179ee199df34..44cdb8aa80a4 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -3217,6 +3217,54 @@ int uart_remove_one_port(struct uart_driver *drv, struct uart_port *uport)
 }
 EXPORT_SYMBOL(uart_remove_one_port);
 
+struct uart_port_devres {
+	struct uart_driver *drv;
+	struct uart_port *port;
+};
+
+static void devm_uart_remove_one_port(struct device *dev, void *data)
+{
+	struct uart_port_devres *res = data;
+
+	uart_remove_one_port(res->drv, res->port);
+}
+
+/**
+ * devm_uart_add_one_port - managed variant of uart_register_driver()
+ * @dev: managed device
+ * @drv: pointer to the uart low level driver structure for this port
+ * @uport: uart port structure to use for this port.
+ *
+ * Context: task context, might sleep
+ *
+ * This is a devres wrapper around uart_add_one_port(). It allows the driver
+ * @drv to register its own uart_port structure with the core driver. The port
+ * will be unregistered on driver detach.
+ */
+int devm_uart_add_one_port(struct device *dev,
+			   struct uart_driver *drv, struct uart_port *port)
+{
+	struct uart_port_devres *res;
+	int ret;
+
+	res = devres_alloc(devm_uart_remove_one_port, sizeof(*res), GFP_KERNEL);
+	if (!res)
+		return -1;
+
+	ret = uart_add_one_port(drv, port);
+	if (ret) {
+		devres_free(res);
+		return -1;
+	}
+
+	res->drv = drv;
+	res->port = port;
+	devres_add(dev, res);
+
+	return 0;
+}
+EXPORT_SYMBOL(devm_uart_add_one_port);
+
 /**
  * uart_match_port - are the two ports equivalent?
  * @port1: first port
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index d657f2a42a7b..d0911f04706e 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -771,6 +771,12 @@ int uart_remove_one_port(struct uart_driver *reg, struct uart_port *port);
 bool uart_match_port(const struct uart_port *port1,
 		const struct uart_port *port2);
 
+/*
+ * UART devres
+ */
+int devm_uart_add_one_port(struct device *dev,
+			   struct uart_driver *drv, struct uart_port *port);
+
 /*
  * Power Management
  */
-- 
2.37.2

