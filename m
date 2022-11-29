Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FB80C46467
	for <linux-serial@archiver.kernel.org>; Tue, 29 Nov 2022 11:01:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232788AbiK2LBP (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 29 Nov 2022 06:01:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232611AbiK2LAg (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 29 Nov 2022 06:00:36 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1376460EB5
        for <linux-serial@vger.kernel.org>; Tue, 29 Nov 2022 03:00:28 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id p16so10587995wmc.3
        for <linux-serial@vger.kernel.org>; Tue, 29 Nov 2022 03:00:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wYb7Bk90e+N6jZPfw1QqOet30B/UaUEuFBD0IKIzTR8=;
        b=f3Z0rv/OhcPtzb4yCaFXJB2JtfotgQpUkcIzzXUWqT8dKmkk8TQVerVytP5+vtYPPi
         gPanRIqSoiER/lBrR7ZmoGLzSkTIWIANIDCxi3VnCRNVjaJ3lLl13Z50UlLYruHmX997
         Yafs8AdQIoBi9bDMyieTWMl4nri9JxOkXpIYS/zAEjDZkSavQg8CbVqkbznTBwndb1st
         0eAVvPT7DDFq07jE3QG0KFV9NjOc5KX5uAwQ372BO32wntma2E+4i9qVanRyS9RHVHJ2
         4AiZ9TUZZbyxPC20Aj247BGJZckPx7f/IUuxqKwV4yZTPMAXxvr63uzTUUJh/mXnd37y
         1K6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wYb7Bk90e+N6jZPfw1QqOet30B/UaUEuFBD0IKIzTR8=;
        b=OoamBSqzy7RRsz+QmLG1XpPRmuwpjA2nIxY6PQh/XvwEXgZQW3EDGzu/5s7ph0l9Yf
         kphHa8UVtB7GyzxB8O8nBwtBbgzy6sNe7RKco74G1S8ImIjlymUn/LmrsLHPgKXFoGx1
         jk0iaaEaK0r/a44sxWj8uxX2T/e2Sd0WrPktmZaxH+Wkwj2G+bdxuSyxDR0TRG7p0PsS
         eO09SYyt4qTs2xf92FHH4L/zPAsB2dhI85m6PKL0oK8+cfcYISdJRLt098HjK/5QBG6V
         s/aM+fFCEcuhwjhBauVUdMDpwrR/eqY3sN/wEv43Ho+zgm7KhRm30n62WxmuWXgYifr7
         rfQw==
X-Gm-Message-State: ANoB5pmevrCwpIORkj5WwQp1l6MgJCmgtkT/6/ld4kI0UX7Ib7ydD7OS
        SJ2QTGf1FAphFGQ1uiCcRalNHQ==
X-Google-Smtp-Source: AA0mqf7kcNvRZM+TZlTpO8UIwY1CdpXqD3jZgB40INQk3zzjpbmJqa4RKxYWhawskqmZy73znKIEXw==
X-Received: by 2002:a05:600c:35c4:b0:3cf:9668:e8f8 with SMTP id r4-20020a05600c35c400b003cf9668e8f8mr31955528wmq.195.1669719627575;
        Tue, 29 Nov 2022 03:00:27 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:6b19:1d8e:fbca:fd02])
        by smtp.gmail.com with ESMTPSA id q19-20020a1cf313000000b003a3170a7af9sm1617658wmq.4.2022.11.29.03.00.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 03:00:27 -0800 (PST)
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
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH v4 10/13] tty: serial: qcom-geni-serial: use of_device_id data
Date:   Tue, 29 Nov 2022 12:00:09 +0100
Message-Id: <20221129110012.224685-11-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221129110012.224685-1-brgl@bgdev.pl>
References: <20221129110012.224685-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Instead of checking the device compatible in probe(), assign the
device-specific data to struct of_device_id. We'll use it later when
providing SE DMA support.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/tty/serial/qcom_geni_serial.c | 46 ++++++++++++++++++++-------
 1 file changed, 34 insertions(+), 12 deletions(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 7d6330f85ec2..fe15fc0e1345 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -95,6 +95,11 @@
 /* We always configure 4 bytes per FIFO word */
 #define BYTES_PER_FIFO_WORD		4U
 
+struct qcom_geni_device_data {
+	bool console;
+	void (*handle_rx)(struct uart_port *uport, u32 bytes, bool drop);
+};
+
 struct qcom_geni_private_data {
 	/* NOTE: earlycon port will have NULL here */
 	struct uart_driver *drv;
@@ -114,7 +119,6 @@ struct qcom_geni_serial_port {
 	u32 tx_fifo_width;
 	u32 rx_fifo_depth;
 	bool setup;
-	void (*handle_rx)(struct uart_port *uport, u32 bytes, bool drop);
 	unsigned int baud;
 	void *rx_fifo;
 	u32 loopback;
@@ -126,6 +130,7 @@ struct qcom_geni_serial_port {
 	bool cts_rts_swap;
 
 	struct qcom_geni_private_data private_data;
+	const struct qcom_geni_device_data *dev_data;
 };
 
 static const struct uart_ops qcom_geni_console_pops;
@@ -640,7 +645,7 @@ static void qcom_geni_serial_handle_rx(struct uart_port *uport, bool drop)
 		total_bytes += last_word_byte_cnt;
 	else
 		total_bytes += BYTES_PER_FIFO_WORD;
-	port->handle_rx(uport, total_bytes, drop);
+	port->dev_data->handle_rx(uport, total_bytes, drop);
 }
 
 static void qcom_geni_serial_stop_rx(struct uart_port *uport)
@@ -1344,13 +1349,14 @@ static int qcom_geni_serial_probe(struct platform_device *pdev)
 	struct uart_port *uport;
 	struct resource *res;
 	int irq;
-	bool console = false;
 	struct uart_driver *drv;
+	const struct qcom_geni_device_data *data;
 
-	if (of_device_is_compatible(pdev->dev.of_node, "qcom,geni-debug-uart"))
-		console = true;
+	data = of_device_get_match_data(&pdev->dev);
+	if (!data)
+		return -EINVAL;
 
-	if (console) {
+	if (data->console) {
 		drv = &qcom_geni_console_driver;
 		line = of_alias_get_id(pdev->dev.of_node, "serial");
 	} else {
@@ -1360,7 +1366,7 @@ static int qcom_geni_serial_probe(struct platform_device *pdev)
 			line = of_alias_get_id(pdev->dev.of_node, "hsuart");
 	}
 
-	port = get_port_from_line(line, console);
+	port = get_port_from_line(line, data->console);
 	if (IS_ERR(port)) {
 		dev_err(&pdev->dev, "Invalid line %d\n", line);
 		return PTR_ERR(port);
@@ -1372,6 +1378,7 @@ static int qcom_geni_serial_probe(struct platform_device *pdev)
 		return -ENODEV;
 
 	uport->dev = &pdev->dev;
+	port->dev_data = data;
 	port->se.dev = &pdev->dev;
 	port->se.wrapper = dev_get_drvdata(pdev->dev.parent);
 	port->se.clk = devm_clk_get(&pdev->dev, "se");
@@ -1390,7 +1397,7 @@ static int qcom_geni_serial_probe(struct platform_device *pdev)
 	port->rx_fifo_depth = DEF_FIFO_DEPTH_WORDS;
 	port->tx_fifo_width = DEF_FIFO_WIDTH_BITS;
 
-	if (!console) {
+	if (!data->console) {
 		port->rx_fifo = devm_kcalloc(uport->dev,
 			port->rx_fifo_depth, sizeof(u32), GFP_KERNEL);
 		if (!port->rx_fifo)
@@ -1420,7 +1427,7 @@ static int qcom_geni_serial_probe(struct platform_device *pdev)
 	uport->irq = irq;
 	uport->has_sysrq = IS_ENABLED(CONFIG_SERIAL_QCOM_GENI_CONSOLE);
 
-	if (!console)
+	if (!data->console)
 		port->wakeup_irq = platform_get_irq_optional(pdev, 1);
 
 	if (of_property_read_bool(pdev->dev.of_node, "rx-tx-swap"))
@@ -1442,7 +1449,6 @@ static int qcom_geni_serial_probe(struct platform_device *pdev)
 	port->private_data.drv = drv;
 	uport->private_data = &port->private_data;
 	platform_set_drvdata(pdev, port);
-	port->handle_rx = console ? handle_rx_console : handle_rx_uart;
 
 	ret = uart_add_one_port(drv, uport);
 	if (ret)
@@ -1522,14 +1528,30 @@ static int __maybe_unused qcom_geni_serial_sys_resume(struct device *dev)
 	return ret;
 }
 
+static const struct qcom_geni_device_data qcom_geni_console_data = {
+	.console = true,
+	.handle_rx = handle_rx_console,
+};
+
+static const struct qcom_geni_device_data qcom_geni_uart_data = {
+	.console = false,
+	.handle_rx = handle_rx_uart,
+};
+
 static const struct dev_pm_ops qcom_geni_serial_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(qcom_geni_serial_sys_suspend,
 					qcom_geni_serial_sys_resume)
 };
 
 static const struct of_device_id qcom_geni_serial_match_table[] = {
-	{ .compatible = "qcom,geni-debug-uart", },
-	{ .compatible = "qcom,geni-uart", },
+	{
+		.compatible = "qcom,geni-debug-uart",
+		.data = &qcom_geni_console_data,
+	},
+	{
+		.compatible = "qcom,geni-uart",
+		.data = &qcom_geni_uart_data,
+	},
 	{}
 };
 MODULE_DEVICE_TABLE(of, qcom_geni_serial_match_table);
-- 
2.37.2

