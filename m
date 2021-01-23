Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B21FEC433E0
	for <linux-serial@archiver.kernel.org>; Sat, 23 Jan 2021 03:46:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E06B23B6A
	for <linux-serial@archiver.kernel.org>; Sat, 23 Jan 2021 03:46:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726849AbhAWDqa (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 22 Jan 2021 22:46:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726714AbhAWDqK (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 22 Jan 2021 22:46:10 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22304C06121D
        for <linux-serial@vger.kernel.org>; Fri, 22 Jan 2021 19:44:37 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id x20so5089872pjh.3
        for <linux-serial@vger.kernel.org>; Fri, 22 Jan 2021 19:44:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o4yYwzF4tROKFYt2eOzFnYYTnlg9EWxAh+XeSEeStnQ=;
        b=FePE0Rh/xSu8xWi5GgPl3W+kOB5bPHlW3vcnaWDD+ytBGmUhW1JH1xWeFygj4Lr9rK
         iGCNc9AgVKYmVL8T70diPUyowZlE99uqQjdOjRyDDnAFXqPsucDLpkDCb4IuOZ0fKbEH
         mFQbZStlFu37UytUjY/iMsBFh0gs+NMEt449A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o4yYwzF4tROKFYt2eOzFnYYTnlg9EWxAh+XeSEeStnQ=;
        b=r8CxjCTI29imT/cK+fLAg3Hz1fLILOYXoWmYrm7eiJHYe3E+krwHtVOYm/bw+PMxbB
         WzN8SpusqpzMUKtjNYAeGmwUkVR+muKFYD9ozp30WcmfpEArWLepPDr4O0D7SZHPwuC5
         wzTHW1o9hAyNam0ZNSPJKMys8sHUPXL0CTnVZ6lVf4S40KyCQnSChAC4WGfJA/jP3DEP
         TBn/AoLGFu2cjbsUsL2Wf0k0rbPZ6Ffpp1znBylPQIDS+aRPLpdTLHO90W9KygE/oWfK
         +cfEuvdTrTD0CAk1Ni2uZi96TWkZJfCdCBl/nDzWYju/+K7/tqfJE5aL66gu6PyLsL42
         edfA==
X-Gm-Message-State: AOAM533abx/XXm3vP6VflHvn/5WZSmEd2CAEC9inRPEq55eUh/6lsMqD
        1oLNRJYaX7Lbpc8LZ4MeG8+dqg==
X-Google-Smtp-Source: ABdhPJy66Yaa72bvz+TFvlVdOgWBeTJN96CJ6WmyZF4u0Sj7I332lxEwedbni49rsxMH4tn0yV97NA==
X-Received: by 2002:a17:902:d909:b029:df:52b4:8147 with SMTP id c9-20020a170902d909b02900df52b48147mr2722252plz.33.1611373476696;
        Fri, 22 Jan 2021 19:44:36 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:201:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id gf23sm10480343pjb.42.2021.01.22.19.44.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jan 2021 19:44:36 -0800 (PST)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Jiri Slaby <jslaby@suse.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-serial@vger.kernel.org
Subject: [PATCH v2 3/6] serial: stm32: Use of_device_get_match_data()
Date:   Fri, 22 Jan 2021 19:44:25 -0800
Message-Id: <20210123034428.2841052-4-swboyd@chromium.org>
X-Mailer: git-send-email 2.30.0.280.ga3ce27912f-goog
In-Reply-To: <20210123034428.2841052-1-swboyd@chromium.org>
References: <20210123034428.2841052-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

This driver casts away the constness of struct stm32_usart_info that is
pointed to by the of match table. Use of_device_get_match_data() instead
of of_match_device() here and push the const throughout the code so that
we don't cast away const. This nicely avoids referencing the match table
when it is undefined with configurations where CONFIG_OF=n and fixes the
const issues.

Signed-off-by: Stephen Boyd <swboyd@chromium.org>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@st.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Frank Rowand <frowand.list@gmail.com>
Cc: <linux-serial@vger.kernel.org>
---

Please ack so Rob can apply.

 drivers/tty/serial/stm32-usart.c | 71 +++++++++++++++-----------------
 drivers/tty/serial/stm32-usart.h |  2 +-
 2 files changed, 35 insertions(+), 38 deletions(-)

diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
index f4de32d3f2af..99f04db73830 100644
--- a/drivers/tty/serial/stm32-usart.c
+++ b/drivers/tty/serial/stm32-usart.c
@@ -99,8 +99,8 @@ static int stm32_config_rs485(struct uart_port *port,
 			      struct serial_rs485 *rs485conf)
 {
 	struct stm32_port *stm32_port = to_stm32_port(port);
-	struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
-	struct stm32_usart_config *cfg = &stm32_port->info->cfg;
+	const struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
+	const struct stm32_usart_config *cfg = &stm32_port->info->cfg;
 	u32 usartdiv, baud, cr1, cr3;
 	bool over8;
 
@@ -166,7 +166,7 @@ static int stm32_pending_rx(struct uart_port *port, u32 *sr, int *last_res,
 			    bool threaded)
 {
 	struct stm32_port *stm32_port = to_stm32_port(port);
-	struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
+	const struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
 	enum dma_status status;
 	struct dma_tx_state state;
 
@@ -191,7 +191,7 @@ static unsigned long stm32_get_char(struct uart_port *port, u32 *sr,
 				    int *last_res)
 {
 	struct stm32_port *stm32_port = to_stm32_port(port);
-	struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
+	const struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
 	unsigned long c;
 
 	if (stm32_port->rx_ch) {
@@ -211,7 +211,7 @@ static void stm32_receive_chars(struct uart_port *port, bool threaded)
 {
 	struct tty_port *tport = &port->state->port;
 	struct stm32_port *stm32_port = to_stm32_port(port);
-	struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
+	const struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
 	unsigned long c;
 	u32 sr;
 	char flag;
@@ -282,7 +282,7 @@ static void stm32_tx_dma_complete(void *arg)
 {
 	struct uart_port *port = arg;
 	struct stm32_port *stm32port = to_stm32_port(port);
-	struct stm32_usart_offsets *ofs = &stm32port->info->ofs;
+	const struct stm32_usart_offsets *ofs = &stm32port->info->ofs;
 
 	stm32_clr_bits(port, ofs->cr3, USART_CR3_DMAT);
 	stm32port->tx_dma_busy = false;
@@ -294,7 +294,7 @@ static void stm32_tx_dma_complete(void *arg)
 static void stm32_tx_interrupt_enable(struct uart_port *port)
 {
 	struct stm32_port *stm32_port = to_stm32_port(port);
-	struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
+	const struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
 
 	/*
 	 * Enables TX FIFO threashold irq when FIFO is enabled,
@@ -309,7 +309,7 @@ static void stm32_tx_interrupt_enable(struct uart_port *port)
 static void stm32_tx_interrupt_disable(struct uart_port *port)
 {
 	struct stm32_port *stm32_port = to_stm32_port(port);
-	struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
+	const struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
 
 	if (stm32_port->fifoen)
 		stm32_clr_bits(port, ofs->cr3, USART_CR3_TXFTIE);
@@ -320,7 +320,7 @@ static void stm32_tx_interrupt_disable(struct uart_port *port)
 static void stm32_transmit_chars_pio(struct uart_port *port)
 {
 	struct stm32_port *stm32_port = to_stm32_port(port);
-	struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
+	const struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
 	struct circ_buf *xmit = &port->state->xmit;
 
 	if (stm32_port->tx_dma_busy) {
@@ -347,7 +347,7 @@ static void stm32_transmit_chars_pio(struct uart_port *port)
 static void stm32_transmit_chars_dma(struct uart_port *port)
 {
 	struct stm32_port *stm32port = to_stm32_port(port);
-	struct stm32_usart_offsets *ofs = &stm32port->info->ofs;
+	const struct stm32_usart_offsets *ofs = &stm32port->info->ofs;
 	struct circ_buf *xmit = &port->state->xmit;
 	struct dma_async_tx_descriptor *desc = NULL;
 	unsigned int count, i;
@@ -407,7 +407,7 @@ static void stm32_transmit_chars_dma(struct uart_port *port)
 static void stm32_transmit_chars(struct uart_port *port)
 {
 	struct stm32_port *stm32_port = to_stm32_port(port);
-	struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
+	const struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
 	struct circ_buf *xmit = &port->state->xmit;
 
 	if (port->x_char) {
@@ -447,7 +447,7 @@ static irqreturn_t stm32_interrupt(int irq, void *ptr)
 {
 	struct uart_port *port = ptr;
 	struct stm32_port *stm32_port = to_stm32_port(port);
-	struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
+	const struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
 	u32 sr;
 
 	spin_lock(&port->lock);
@@ -494,7 +494,7 @@ static irqreturn_t stm32_threaded_interrupt(int irq, void *ptr)
 static unsigned int stm32_tx_empty(struct uart_port *port)
 {
 	struct stm32_port *stm32_port = to_stm32_port(port);
-	struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
+	const struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
 
 	return readl_relaxed(port->membase + ofs->isr) & USART_SR_TXE;
 }
@@ -502,7 +502,7 @@ static unsigned int stm32_tx_empty(struct uart_port *port)
 static void stm32_set_mctrl(struct uart_port *port, unsigned int mctrl)
 {
 	struct stm32_port *stm32_port = to_stm32_port(port);
-	struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
+	const struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
 
 	if ((mctrl & TIOCM_RTS) && (port->status & UPSTAT_AUTORTS))
 		stm32_set_bits(port, ofs->cr3, USART_CR3_RTSE);
@@ -579,7 +579,7 @@ static void stm32_start_tx(struct uart_port *port)
 static void stm32_throttle(struct uart_port *port)
 {
 	struct stm32_port *stm32_port = to_stm32_port(port);
-	struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
+	const struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
 	unsigned long flags;
 
 	spin_lock_irqsave(&port->lock, flags);
@@ -594,7 +594,7 @@ static void stm32_throttle(struct uart_port *port)
 static void stm32_unthrottle(struct uart_port *port)
 {
 	struct stm32_port *stm32_port = to_stm32_port(port);
-	struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
+	const struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
 	unsigned long flags;
 
 	spin_lock_irqsave(&port->lock, flags);
@@ -609,7 +609,7 @@ static void stm32_unthrottle(struct uart_port *port)
 static void stm32_stop_rx(struct uart_port *port)
 {
 	struct stm32_port *stm32_port = to_stm32_port(port);
-	struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
+	const struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
 
 	stm32_clr_bits(port, ofs->cr1, stm32_port->cr1_irq);
 	if (stm32_port->cr3_irq)
@@ -625,7 +625,7 @@ static void stm32_break_ctl(struct uart_port *port, int break_state)
 static int stm32_startup(struct uart_port *port)
 {
 	struct stm32_port *stm32_port = to_stm32_port(port);
-	struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
+	const struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
 	const char *name = to_platform_device(port->dev)->name;
 	u32 val;
 	int ret;
@@ -661,8 +661,8 @@ static int stm32_startup(struct uart_port *port)
 static void stm32_shutdown(struct uart_port *port)
 {
 	struct stm32_port *stm32_port = to_stm32_port(port);
-	struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
-	struct stm32_usart_config *cfg = &stm32_port->info->cfg;
+	const struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
+	const struct stm32_usart_config *cfg = &stm32_port->info->cfg;
 	u32 val, isr;
 	int ret;
 
@@ -721,8 +721,8 @@ static void stm32_set_termios(struct uart_port *port, struct ktermios *termios,
 			    struct ktermios *old)
 {
 	struct stm32_port *stm32_port = to_stm32_port(port);
-	struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
-	struct stm32_usart_config *cfg = &stm32_port->info->cfg;
+	const struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
+	const struct stm32_usart_config *cfg = &stm32_port->info->cfg;
 	struct serial_rs485 *rs485conf = &port->rs485;
 	unsigned int baud, bits;
 	u32 usartdiv, mantissa, fraction, oversampling;
@@ -921,8 +921,8 @@ static void stm32_pm(struct uart_port *port, unsigned int state,
 {
 	struct stm32_port *stm32port = container_of(port,
 			struct stm32_port, port);
-	struct stm32_usart_offsets *ofs = &stm32port->info->ofs;
-	struct stm32_usart_config *cfg = &stm32port->info->cfg;
+	const struct stm32_usart_offsets *ofs = &stm32port->info->ofs;
+	const struct stm32_usart_config *cfg = &stm32port->info->cfg;
 	unsigned long flags = 0;
 
 	switch (state) {
@@ -1081,7 +1081,7 @@ MODULE_DEVICE_TABLE(of, stm32_match);
 static int stm32_of_dma_rx_probe(struct stm32_port *stm32port,
 				 struct platform_device *pdev)
 {
-	struct stm32_usart_offsets *ofs = &stm32port->info->ofs;
+	const struct stm32_usart_offsets *ofs = &stm32port->info->ofs;
 	struct uart_port *port = &stm32port->port;
 	struct device *dev = &pdev->dev;
 	struct dma_slave_config config;
@@ -1152,7 +1152,7 @@ static int stm32_of_dma_rx_probe(struct stm32_port *stm32port,
 static int stm32_of_dma_tx_probe(struct stm32_port *stm32port,
 				 struct platform_device *pdev)
 {
-	struct stm32_usart_offsets *ofs = &stm32port->info->ofs;
+	const struct stm32_usart_offsets *ofs = &stm32port->info->ofs;
 	struct uart_port *port = &stm32port->port;
 	struct device *dev = &pdev->dev;
 	struct dma_slave_config config;
@@ -1202,7 +1202,6 @@ static int stm32_of_dma_tx_probe(struct stm32_port *stm32port,
 
 static int stm32_serial_probe(struct platform_device *pdev)
 {
-	const struct of_device_id *match;
 	struct stm32_port *stm32port;
 	int ret;
 
@@ -1210,10 +1209,8 @@ static int stm32_serial_probe(struct platform_device *pdev)
 	if (!stm32port)
 		return -ENODEV;
 
-	match = of_match_device(stm32_match, &pdev->dev);
-	if (match && match->data)
-		stm32port->info = (struct stm32_usart_info *)match->data;
-	else
+	stm32port->info = of_device_get_match_data(&pdev->dev);
+	if (!stm32port->info)
 		return -EINVAL;
 
 	ret = stm32_init_port(stm32port, pdev);
@@ -1272,7 +1269,7 @@ static int stm32_serial_remove(struct platform_device *pdev)
 {
 	struct uart_port *port = platform_get_drvdata(pdev);
 	struct stm32_port *stm32_port = to_stm32_port(port);
-	struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
+	const struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
 	int err;
 
 	pm_runtime_get_sync(&pdev->dev);
@@ -1317,7 +1314,7 @@ static int stm32_serial_remove(struct platform_device *pdev)
 static void stm32_console_putchar(struct uart_port *port, int ch)
 {
 	struct stm32_port *stm32_port = to_stm32_port(port);
-	struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
+	const struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
 
 	while (!(readl_relaxed(port->membase + ofs->isr) & USART_SR_TXE))
 		cpu_relax();
@@ -1329,8 +1326,8 @@ static void stm32_console_write(struct console *co, const char *s, unsigned cnt)
 {
 	struct uart_port *port = &stm32_ports[co->index].port;
 	struct stm32_port *stm32_port = to_stm32_port(port);
-	struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
-	struct stm32_usart_config *cfg = &stm32_port->info->cfg;
+	const struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
+	const struct stm32_usart_config *cfg = &stm32_port->info->cfg;
 	unsigned long flags;
 	u32 old_cr1, new_cr1;
 	int locked = 1;
@@ -1416,8 +1413,8 @@ static void __maybe_unused stm32_serial_enable_wakeup(struct uart_port *port,
 						      bool enable)
 {
 	struct stm32_port *stm32_port = to_stm32_port(port);
-	struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
-	struct stm32_usart_config *cfg = &stm32_port->info->cfg;
+	const struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
+	const struct stm32_usart_config *cfg = &stm32_port->info->cfg;
 	u32 val;
 
 	if (stm32_port->wakeirq <= 0)
diff --git a/drivers/tty/serial/stm32-usart.h b/drivers/tty/serial/stm32-usart.h
index d4c916e78d40..cb4f327c46db 100644
--- a/drivers/tty/serial/stm32-usart.h
+++ b/drivers/tty/serial/stm32-usart.h
@@ -259,7 +259,7 @@ struct stm32_usart_info stm32h7_info = {
 struct stm32_port {
 	struct uart_port port;
 	struct clk *clk;
-	struct stm32_usart_info *info;
+	const struct stm32_usart_info *info;
 	struct dma_chan *rx_ch;  /* dma rx channel            */
 	dma_addr_t rx_dma_buf;   /* dma rx buffer bus address */
 	unsigned char *rx_buf;   /* dma rx buffer cpu address */
-- 
https://chromeos.dev

