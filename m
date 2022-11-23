Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F047C3A59F
	for <linux-serial@archiver.kernel.org>; Wed, 23 Nov 2022 11:09:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237704AbiKWLJG (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 23 Nov 2022 06:09:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237494AbiKWLIa (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 23 Nov 2022 06:08:30 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03CAEB64
        for <linux-serial@vger.kernel.org>; Wed, 23 Nov 2022 03:08:09 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id z4so14260826wrr.3
        for <linux-serial@vger.kernel.org>; Wed, 23 Nov 2022 03:08:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DkZacf9TX3zvyVeUrL+nHxYirMYsPuTeW+Zo+lEbcT0=;
        b=TpYK9iculPDZDpoefDVsLJ5lmcUiuXemv6LAXee6UBhJIaFqvJLLheaqxKVECcrWeC
         f65RSTWvLVmbRRmVQ7P7WE+1MF+bQxVZlkMI3JKeHZOyDh4MLwzyddLPwCkbRQ6ipFU4
         MBlx9bpx4VcUUBLqwPCrJCIVudG87uZg0nBeyPqgwwKDOO9XN6/5JFX6/C8AGCo0aaSn
         iLJXoW6UlACy2IXVJMLyjDnaPLpdY85ps/Fnb81Jsl3isryI+JJzYeYDO359JDGCqjPz
         wc+OQTwIHTNnyQDgx6jNG4AI1Bv06Yr6IA6WgaorXyyRmW045dVJ0MOhmg/ObZMFxDQv
         FieA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DkZacf9TX3zvyVeUrL+nHxYirMYsPuTeW+Zo+lEbcT0=;
        b=Zq57O8RqTlwGWXzt8ePUtg7KQt27pQj0wteZPo0JFfNl9JMfMQo8/Kb7YC45VXO6CN
         mHOkemocltUtNHHU4i3GQkIVlJF4U/WXUfpm4GBuq2gpODfPfn1WF2rjM+dfERVNssNV
         6RGokXMyjqAggNcH4W0uWlmgSVvugH6iwCdr+pg+S2bdu1eNvodpfjulq2g7VpXfZkBq
         ZVXTnx2/0Lr1B9BgOWirIEw50PX5WRbxiCczSRij0Ae0yGh2vtR9bPXbrLg6pOjq4mjI
         dPwEI4djfFHGDt9C+iX/FumPZd4VQNv0ir4zbnfnvEnUfKL16/DK62cf+5Ae9CmuHoK1
         YluA==
X-Gm-Message-State: ANoB5pk7zC+hjXbJJ2V5R7LrIchqRsuC94ac633+4CTb2eDaXG9HCId7
        MSmGSdN6yHbdgfiEuebFwKBigg==
X-Google-Smtp-Source: AA0mqf5NT9i1wJa01HLAhZgnn4sdfa3ZdNkUk+c0ESJEcJdA26BsSk8OjL43qB08MuiJqcM+plNqTQ==
X-Received: by 2002:adf:f3d0:0:b0:241:f721:3ba2 with SMTP id g16-20020adff3d0000000b00241f7213ba2mr399458wrp.681.1669201688557;
        Wed, 23 Nov 2022 03:08:08 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:ae74:d94f:4677:3378])
        by smtp.gmail.com with ESMTPSA id f13-20020a05600c4e8d00b003c6c182bef9sm2560406wmq.36.2022.11.23.03.08.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 03:08:08 -0800 (PST)
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
Subject: [PATCH v3 04/13] tty: serial: qcom-geni-serial: improve the to_dev_port() macro
Date:   Wed, 23 Nov 2022 12:07:50 +0100
Message-Id: <20221123110759.1836666-5-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221123110759.1836666-1-brgl@bgdev.pl>
References: <20221123110759.1836666-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

The member we want to resolve in struct qcom_geni_serial_port is called
uport so we don't need an additional redundant parameter in this macro.

While at it: turn the macro into a static inline function.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/tty/serial/qcom_geni_serial.c | 36 ++++++++++++++-------------
 1 file changed, 19 insertions(+), 17 deletions(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 97ee7c074b79..e4139718e084 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -133,8 +133,10 @@ static const struct uart_ops qcom_geni_uart_pops;
 static struct uart_driver qcom_geni_console_driver;
 static struct uart_driver qcom_geni_uart_driver;
 
-#define to_dev_port(ptr, member) \
-		container_of(ptr, struct qcom_geni_serial_port, member)
+static inline struct qcom_geni_serial_port *to_dev_port(struct uart_port *uport)
+{
+	return container_of(uport, struct qcom_geni_serial_port, uport);
+}
 
 static struct qcom_geni_serial_port qcom_geni_uart_ports[GENI_UART_PORTS] = {
 	[0] = {
@@ -175,7 +177,7 @@ static struct qcom_geni_serial_port qcom_geni_console_port = {
 static int qcom_geni_serial_request_port(struct uart_port *uport)
 {
 	struct platform_device *pdev = to_platform_device(uport->dev);
-	struct qcom_geni_serial_port *port = to_dev_port(uport, uport);
+	struct qcom_geni_serial_port *port = to_dev_port(uport);
 
 	uport->membase = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(uport->membase))
@@ -212,7 +214,7 @@ static void qcom_geni_serial_set_mctrl(struct uart_port *uport,
 							unsigned int mctrl)
 {
 	u32 uart_manual_rfr = 0;
-	struct qcom_geni_serial_port *port = to_dev_port(uport, uport);
+	struct qcom_geni_serial_port *port = to_dev_port(uport);
 
 	if (uart_console(uport))
 		return;
@@ -253,7 +255,7 @@ static bool qcom_geni_serial_poll_bit(struct uart_port *uport,
 	struct qcom_geni_private_data *private_data = uport->private_data;
 
 	if (private_data->drv) {
-		port = to_dev_port(uport, uport);
+		port = to_dev_port(uport);
 		baud = port->baud;
 		if (!baud)
 			baud = 115200;
@@ -506,7 +508,7 @@ static int handle_rx_console(struct uart_port *uport, u32 bytes, bool drop)
 	u32 i;
 	unsigned char buf[sizeof(u32)];
 	struct tty_port *tport;
-	struct qcom_geni_serial_port *port = to_dev_port(uport, uport);
+	struct qcom_geni_serial_port *port = to_dev_port(uport);
 
 	tport = &uport->state->port;
 	for (i = 0; i < bytes; ) {
@@ -549,7 +551,7 @@ static int handle_rx_console(struct uart_port *uport, u32 bytes, bool drop)
 static int handle_rx_uart(struct uart_port *uport, u32 bytes, bool drop)
 {
 	struct tty_port *tport;
-	struct qcom_geni_serial_port *port = to_dev_port(uport, uport);
+	struct qcom_geni_serial_port *port = to_dev_port(uport);
 	u32 num_bytes_pw = port->tx_fifo_width / BITS_PER_BYTE;
 	u32 words = ALIGN(bytes, num_bytes_pw) / num_bytes_pw;
 	int ret;
@@ -598,7 +600,7 @@ static void qcom_geni_serial_stop_tx(struct uart_port *uport)
 {
 	u32 irq_en;
 	u32 status;
-	struct qcom_geni_serial_port *port = to_dev_port(uport, uport);
+	struct qcom_geni_serial_port *port = to_dev_port(uport);
 
 	irq_en = readl(uport->membase + SE_GENI_M_IRQ_EN);
 	irq_en &= ~(M_CMD_DONE_EN | M_TX_FIFO_WATERMARK_EN);
@@ -627,7 +629,7 @@ static void qcom_geni_serial_handle_rx(struct uart_port *uport, bool drop)
 	u32 last_word_byte_cnt;
 	u32 last_word_partial;
 	u32 total_bytes;
-	struct qcom_geni_serial_port *port = to_dev_port(uport, uport);
+	struct qcom_geni_serial_port *port = to_dev_port(uport);
 
 	status = readl(uport->membase +	SE_GENI_RX_FIFO_STATUS);
 	word_cnt = status & RX_FIFO_WC_MSK;
@@ -649,7 +651,7 @@ static void qcom_geni_serial_stop_rx(struct uart_port *uport)
 {
 	u32 irq_en;
 	u32 status;
-	struct qcom_geni_serial_port *port = to_dev_port(uport, uport);
+	struct qcom_geni_serial_port *port = to_dev_port(uport);
 	u32 s_irq_status;
 
 	irq_en = readl(uport->membase + SE_GENI_S_IRQ_EN);
@@ -687,7 +689,7 @@ static void qcom_geni_serial_start_rx(struct uart_port *uport)
 {
 	u32 irq_en;
 	u32 status;
-	struct qcom_geni_serial_port *port = to_dev_port(uport, uport);
+	struct qcom_geni_serial_port *port = to_dev_port(uport);
 
 	status = readl(uport->membase + SE_GENI_STATUS);
 	if (status & S_GENI_CMD_ACTIVE)
@@ -707,7 +709,7 @@ static void qcom_geni_serial_start_rx(struct uart_port *uport)
 static void qcom_geni_serial_handle_tx(struct uart_port *uport, bool done,
 		bool active)
 {
-	struct qcom_geni_serial_port *port = to_dev_port(uport, uport);
+	struct qcom_geni_serial_port *port = to_dev_port(uport);
 	struct circ_buf *xmit = &uport->state->xmit;
 	size_t avail;
 	size_t remaining;
@@ -803,7 +805,7 @@ static irqreturn_t qcom_geni_serial_isr(int isr, void *dev)
 	struct uart_port *uport = dev;
 	bool drop_rx = false;
 	struct tty_port *tport = &uport->state->port;
-	struct qcom_geni_serial_port *port = to_dev_port(uport, uport);
+	struct qcom_geni_serial_port *port = to_dev_port(uport);
 
 	if (uport->suspended)
 		return IRQ_NONE;
@@ -869,7 +871,7 @@ static void qcom_geni_serial_shutdown(struct uart_port *uport)
 
 static int qcom_geni_serial_port_setup(struct uart_port *uport)
 {
-	struct qcom_geni_serial_port *port = to_dev_port(uport, uport);
+	struct qcom_geni_serial_port *port = to_dev_port(uport);
 	u32 rxstale = DEFAULT_BITS_PER_CHAR * STALE_TIMEOUT;
 	u32 proto;
 	u32 pin_swap;
@@ -917,7 +919,7 @@ static int qcom_geni_serial_port_setup(struct uart_port *uport)
 static int qcom_geni_serial_startup(struct uart_port *uport)
 {
 	int ret;
-	struct qcom_geni_serial_port *port = to_dev_port(uport, uport);
+	struct qcom_geni_serial_port *port = to_dev_port(uport);
 
 	if (!port->setup) {
 		ret = qcom_geni_serial_port_setup(uport);
@@ -1003,7 +1005,7 @@ static void qcom_geni_serial_set_termios(struct uart_port *uport,
 	u32 stop_bit_len;
 	unsigned int clk_div;
 	u32 ser_clk_cfg;
-	struct qcom_geni_serial_port *port = to_dev_port(uport, uport);
+	struct qcom_geni_serial_port *port = to_dev_port(uport);
 	unsigned long clk_rate;
 	u32 ver, sampling_rate;
 	unsigned int avg_bw_core;
@@ -1288,7 +1290,7 @@ static struct uart_driver qcom_geni_uart_driver = {
 static void qcom_geni_serial_pm(struct uart_port *uport,
 		unsigned int new_state, unsigned int old_state)
 {
-	struct qcom_geni_serial_port *port = to_dev_port(uport, uport);
+	struct qcom_geni_serial_port *port = to_dev_port(uport);
 
 	/* If we've never been called, treat it as off */
 	if (old_state == UART_PM_STATE_UNDEFINED)
-- 
2.37.2

