Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A972C43217
	for <linux-serial@archiver.kernel.org>; Tue, 22 Nov 2022 10:23:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232748AbiKVKXw (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 22 Nov 2022 05:23:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232951AbiKVKWL (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 22 Nov 2022 05:22:11 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3952C2BD4
        for <linux-serial@vger.kernel.org>; Tue, 22 Nov 2022 02:21:54 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id a11-20020a05600c2d4b00b003cf6f5fd9f1so10939427wmg.2
        for <linux-serial@vger.kernel.org>; Tue, 22 Nov 2022 02:21:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j23hZnphv0jcgZfiOY9qWXNDpMCFFj9PRM3bEUKGmc4=;
        b=fDNYsQ3j2gLDbZskMdzxyTjl8yIPfTyD01yYPRdSjW+X6zPNqK3ztySziZezPu419E
         suCJQuvywgERUuFjcEnHi4Z1QQWUyfFO4bjGUFByDMTU2ML1XaBgAmunf8cy0bjbUiW6
         daoPwkNXiRew7YerkscSIQfCA1vTfCA/zQEJYA+Gy88c/te+ILvMNZbT6x+k+h8ZXa58
         AhXsEKNQkEnyM1McFXynLRGACGVnivDCet0jtDLXhYTpNVJlBqHoZ63GGUSki5MbqFCA
         mruZWz6KtrRz2f/+SjzX2D9ZkEppU8HB1XaTcih4ryJpVJ1rEiWyU2v/OrqDDX3QhTzV
         PjKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j23hZnphv0jcgZfiOY9qWXNDpMCFFj9PRM3bEUKGmc4=;
        b=306xXGqnKUhLmLEc/qZtkJcfv+/mX0UMI3TxoYKhXvJ7vc9wMuxYd62qSralq+cyMA
         QQsKBk027JFhHYoLj2FgmfBRhh+t9bsOoXN+pdzkn/YRkMUJRrook++QdzgYBIDWSa+E
         sz5OxmGH3U5/5RwL1xye/zpEnhf8GfMDJ3NJ0LbPnBrE0Wvds1qWVTWA5T3vHPBgjKE7
         0BKl+MIZe5Y9Y3LpfdNFABhJtS8tc9tDUU+9eYWd+JGHUh6HQW5Yi/MtdDaO4l0O+8+T
         yv4sTCJLHJD72+LHH7zm+6jwU2X4fT8TSvCVncUI2aB/VqS2JdI2SPj948a2GR/KCjn0
         5Y3w==
X-Gm-Message-State: ANoB5pmzcPCO/SvMJYV1OAi6QvbxCFcQt5uwwQ9oVZOinQ3MvfKjTC9Z
        BFo1D7TmncpI3rG8C8aB4OWywA==
X-Google-Smtp-Source: AA0mqf6F5CKYp1cj3ICGkEzObFA7z8uPbsQFkopSwvQDdKVO4tzZn/XDhXCeCyEy5WVeeswdbWEjag==
X-Received: by 2002:a7b:cb98:0:b0:3cf:9a12:e645 with SMTP id m24-20020a7bcb98000000b003cf9a12e645mr8714322wmi.59.1669112512755;
        Tue, 22 Nov 2022 02:21:52 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:e011:9e81:66f1:3415])
        by smtp.gmail.com with ESMTPSA id o3-20020a5d4083000000b002366e8eee11sm13432873wrp.101.2022.11.22.02.21.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 02:21:52 -0800 (PST)
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
Subject: [PATCH v2 12/15] tty: serial: provide devm_uart_add_one_port()
Date:   Tue, 22 Nov 2022 11:21:22 +0100
Message-Id: <20221122102125.142075-13-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221122102125.142075-1-brgl@bgdev.pl>
References: <20221122102125.142075-1-brgl@bgdev.pl>
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
 drivers/tty/serial/serial_core.c              | 36 +++++++++++++++++++
 include/linux/serial_core.h                   |  6 ++++
 3 files changed, 45 insertions(+)

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
index 179ee199df34..005190b279b3 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -3217,6 +3217,42 @@ int uart_remove_one_port(struct uart_driver *drv, struct uart_port *uport)
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

