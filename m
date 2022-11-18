Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70302C41535
	for <linux-serial@archiver.kernel.org>; Fri, 18 Nov 2022 12:27:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241758AbiKRM1S (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 18 Nov 2022 07:27:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241838AbiKRM0a (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 18 Nov 2022 07:26:30 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37FAE9A24F
        for <linux-serial@vger.kernel.org>; Fri, 18 Nov 2022 04:26:15 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id o30so3531998wms.2
        for <linux-serial@vger.kernel.org>; Fri, 18 Nov 2022 04:26:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j23hZnphv0jcgZfiOY9qWXNDpMCFFj9PRM3bEUKGmc4=;
        b=XgxLUl8pt1XNL0iLDiU427YWuA+WEaiaCkEvGhMxKvHS7AzO0WGlJgFy/efbY2ozcc
         DOQb1IEBoBtO3VW7x+t4MJQYkrfiPsUkhRvFkGp9UAoID4XLDZR8DnoIwBtbmXRAHpOc
         1oAXfiRsZyf4XuQMoOBnck65CaxmocuvADWKoZ3v+xS5uJMkpxOVxStEib7omyU7FG7X
         C0XU2f6TZgVvuoiBIgwqpOGHZ+qbVlVWTpDgUyO2oTqQxS4y7gMJWOMZmlX9oupLSzvj
         V5IED7b3gL8JPqwwin/Vx0dh/ewtVRM8QWnjapPvxRs6gVqFpNBCjdSiH9oBrQFTwi9T
         vmSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j23hZnphv0jcgZfiOY9qWXNDpMCFFj9PRM3bEUKGmc4=;
        b=jkqtsJ5CSP4Wf/uD8qqCfPfsGI4BKlw+0bUmmzQgs29QqmpwU0p6GvSIFdqNgNI4Eg
         9gBir5IYHg3bP/Irg8DctTb2cDGSMt6aTgFIe48Hj02BJJ7PL2DEm+JK/Fj1Kwsn28Sv
         7xZXhtMbN3rB1NklyUdmQkvDeHBwCz8+ro6OYfImgkcHsdB3ca6XuBbLOm6vJZ4W7QyZ
         6jc2yOfkMQ7cBCEzvmgQqZbuNJqqdCb4TWhXd1Rz2TCrIy5USTHb7CT4giV3LnlMH0dP
         mxTYZy7ygvHuLZvhNZcrZ1IxJ9df4sqZtwwpcDhUoYqbUcRVchY1omZJcqmoa1mz8Ps0
         TYwg==
X-Gm-Message-State: ANoB5pmLuL5dn8WzmI0UJN7KT3QNkiqmMoxpOSB0z/NaQep5pUMWIiep
        hfiwZFBHDV9UpshO6pAJSfffbw==
X-Google-Smtp-Source: AA0mqf6r1UopoD85mncIUva/+dvusTt3tcZCpOD8lLQGcqCaB9WfI6v27mi+Pj5NXkUPSpwj0H1JlQ==
X-Received: by 2002:a05:600c:19d0:b0:3cf:e7b7:d87d with SMTP id u16-20020a05600c19d000b003cfe7b7d87dmr7852582wmq.95.1668774373630;
        Fri, 18 Nov 2022 04:26:13 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:b10c:1279:a704:75d4])
        by smtp.gmail.com with ESMTPSA id f19-20020a05600c155300b003c6f3e5ba42sm9873958wmg.46.2022.11.18.04.26.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 04:26:13 -0800 (PST)
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
Subject: [PATCH 12/15] tty: serial: provide devm_uart_add_one_port()
Date:   Fri, 18 Nov 2022 13:25:36 +0100
Message-Id: <20221118122539.384993-13-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221118122539.384993-1-brgl@bgdev.pl>
References: <20221118122539.384993-1-brgl@bgdev.pl>
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

