Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB0BBC4708D
	for <linux-serial@archiver.kernel.org>; Thu, 29 Dec 2022 16:19:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233335AbiL2QT6 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 29 Dec 2022 11:19:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233477AbiL2QT4 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 29 Dec 2022 11:19:56 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6706912AAB
        for <linux-serial@vger.kernel.org>; Thu, 29 Dec 2022 08:19:55 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id y16so17818302wrm.2
        for <linux-serial@vger.kernel.org>; Thu, 29 Dec 2022 08:19:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oqAbnpnlAxZCZCp9Pk4QU/Xx94Xjsxer7IEB8LwGfcE=;
        b=CLYCYMRtgsROH78TnzkjNDFbHZS2utAHl8Z8QnooOTfxG7BBMv5TM3iAyLxJpsWNMN
         qHdAmpWiqODp2s1QfFjEXANyR3UuB122hm7gORFYEFVisJ7vPdROVTrpWBDMk30UzGee
         wakStsHPvUFzY70/dv6n348NkEq9S0gqFmEh5F2J3IWSY0bb/sNrZFcMyLl/ymjbQ6B8
         BX3S5bgwhDqu1GGp6l851NMiQBnGWGy/LhZElbwCklGcjnEhFgRI23dIwjarP1V3g2F2
         x4+J/vf2+tXw2GORQh0IxxkyTZWpjM0O/Xcteb9uAydF8oIbs33khNRPbtZWS+LSAel3
         hrkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oqAbnpnlAxZCZCp9Pk4QU/Xx94Xjsxer7IEB8LwGfcE=;
        b=q+Jct4vMXF0GO1OhTBNixotMHJwm73xCA4S7lk1ktV9Dw2u9y6JW5/a5Q9WamVE9Ml
         YKRkb0/uTZTaemR0Wp/+23YhLQH0GapkIjP8Md551WYTvFjjyD4NXsMHntQLrqXcqfJa
         XFl8eVfB+tjZKLEcTkaweT9YN4VgDZo7YDLN3Z0/HnALVtmm24vGSvQlK34S8UKBoGw9
         DmKsCBFdpdyiQWMlCF88Y022Nx93axacUiYx0foj0XGeq/FeE93W9v/zGDYsGlhSdCjN
         ye6kHPcahktGruht703XLdVrYZllR/nTtvmTrc7aPK22Uqf2ETpayf7064u5fLyCrSNV
         TR9g==
X-Gm-Message-State: AFqh2koD+2BSDoE4K78F9ns0sgMI0fKlZke0H0GwziF/IfVT1XSLoG5A
        cKVNLBZoiYmSmlrCkjDJ9IK8xA==
X-Google-Smtp-Source: AMrXdXtI9+FXgBJazhiWZznWBPZzoPSLpZA99ejJ2XdgruHoxFMk1dyy5w5GnvBwYTEt+W5zapcU+g==
X-Received: by 2002:a5d:49c3:0:b0:232:be5c:ec4a with SMTP id t3-20020a5d49c3000000b00232be5cec4amr22347519wrs.6.1672330793956;
        Thu, 29 Dec 2022 08:19:53 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:8f7a:98d8:9d8d:ced8])
        by smtp.gmail.com with ESMTPSA id t5-20020a5d49c5000000b0028cf987d944sm1333199wrs.33.2022.12.29.08.19.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 08:19:53 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, Alex Elder <elder@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-serial@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [RESEND PATCH 1/2] tty: serial: provide devm_uart_add_one_port()
Date:   Thu, 29 Dec 2022 17:19:47 +0100
Message-Id: <20221229161948.594102-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221229161948.594102-1-brgl@bgdev.pl>
References: <20221229161948.594102-1-brgl@bgdev.pl>
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
index 4249eb4239e0..1d79053070f5 100644
--- a/Documentation/driver-api/driver-model/devres.rst
+++ b/Documentation/driver-api/driver-model/devres.rst
@@ -448,6 +448,9 @@ RTC
 SERDEV
   devm_serdev_device_open()
 
+SERIAL
+  devm_uart_add_one_port()
+
 SLAVE DMA ENGINE
   devm_acpi_dma_controller_register()
   devm_acpi_dma_controller_free()
diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index b9fbbee598b8..996aa73705f8 100644
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
index fd59f600094a..3c86b751e3b6 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -857,6 +857,12 @@ int uart_remove_one_port(struct uart_driver *reg, struct uart_port *port);
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

