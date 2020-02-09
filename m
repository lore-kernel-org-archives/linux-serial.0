Return-Path: <SRS0=CO02=35=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41A1FC35250
	for <linux-serial@archiver.kernel.org>; Sun,  9 Feb 2020 16:45:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 076DA20714
	for <linux-serial@archiver.kernel.org>; Sun,  9 Feb 2020 16:45:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r40NS9Ia"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727725AbgBIQpK (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 9 Feb 2020 11:45:10 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:37381 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727661AbgBIQpK (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 9 Feb 2020 11:45:10 -0500
Received: by mail-lj1-f196.google.com with SMTP id v17so4415030ljg.4;
        Sun, 09 Feb 2020 08:45:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vOlt1s90wwxFL9uryuJBW3ESkV5Or6KtWKfVzGs/MUg=;
        b=r40NS9IaKFe289s1wd02JqPFoZJ1EYx3UAoqrcvzkxsJHZhMzF1HY7tp0U54EuGCo2
         RtMjrXEGpE1dNj/EzwQ5rA+/7Hol60Xnozj7VaTgSGTsxXp/uDmLaASQWFtuaBCs4+Al
         n/CKq8GwN7DsFCyaxkzRYZHEcOjlzfBWv1JWgsZVvSNqZlKPMgUmMJKULaP87uXv5J0j
         2Ozl63ZEREJkvc7emSuiLPIg7kYORuRT7mh5QqhCwHWXR3s3V/8bWp5CaBujvaTQQs4R
         rMZForOx5bnfgCfm6b+5V9RPdJ5Z96tZL9ZnzzPzTkeSANhOOPxAk0m5fZ8xpWez8vxX
         w1Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vOlt1s90wwxFL9uryuJBW3ESkV5Or6KtWKfVzGs/MUg=;
        b=sPzrTudmaT4LYPyAt8mH/h9pkPd9Io3TxaBK8jZ6c5/9KQZukOHFVdgqV99rb4AXZX
         Vssj/4yLT04B69T4/sjq/iZhyklFnaXnUrh4ADCRNpcT+DFS1ldAfMRkH10BKg5cdN7v
         T1285mN3bgGaJXuVwtwTySSikMS0jB2M6KquvU7KtYlwDUC5CUVllMSWdKaAnWeYlj7v
         EIpQ/IBfwEDKwm89/g44z4B3lVUYKO2YhUinOsF+0AQUXLtWlaOIslRAmjzSc+quRGZ5
         K3LDRUNTClfYuXGTMVEZEL49o1yJHO4MdvPukKM+GvGWvA0GvxJOk5+hvkLoDlPjY9wx
         LVnA==
X-Gm-Message-State: APjAAAW28fDJJ92XqNZQpBP+/flIqBUtht9ewcRBolDu5FG2boLCDBiv
        1vOYyk8LpM/UQYfHvSuaZS4=
X-Google-Smtp-Source: APXvYqxLnQL5Gbnt/iZx4MeR6ttqwm52Ee7kw+kxDCWlLMPLOQtRt4mUwN9qpjZjyj2BMUTvptc8hQ==
X-Received: by 2002:a2e:9e16:: with SMTP id e22mr5773121ljk.220.1581266708167;
        Sun, 09 Feb 2020 08:45:08 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id w8sm4933483ljj.75.2020.02.09.08.45.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Feb 2020 08:45:07 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Laxman Dewangan <ldewangan@nvidia.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     linux-serial@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH for 5.6 v2] tty: serial: tegra: Handle RX transfer in PIO mode if DMA wasn't started
Date:   Sun,  9 Feb 2020 19:44:15 +0300
Message-Id: <20200209164415.9632-1-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

It is possible to get an instant RX timeout or end-of-transfer interrupt
before RX DMA was started, if transaction is less than 16 bytes. Transfer
should be handled in PIO mode in this case because DMA can't handle it.
This patch brings back the original behaviour of the driver that was
changed by accident by a previous commit, it fixes occasional Bluetooth HW
initialization failures which I started to notice recently.

Fixes: d5e3fadb7012 ("tty: serial: tegra: Activate RX DMA transfer by request")
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---

Changelog:

v2: - Corrected commit's title by adding the accidentally missed "tegra: "
      to the prefix.

 drivers/tty/serial/serial-tegra.c | 35 ++++++++++++++-----------------
 1 file changed, 16 insertions(+), 19 deletions(-)

diff --git a/drivers/tty/serial/serial-tegra.c b/drivers/tty/serial/serial-tegra.c
index 33034b852a51..8de8bac9c6c7 100644
--- a/drivers/tty/serial/serial-tegra.c
+++ b/drivers/tty/serial/serial-tegra.c
@@ -692,11 +692,22 @@ static void tegra_uart_copy_rx_to_tty(struct tegra_uart_port *tup,
 				   count, DMA_TO_DEVICE);
 }
 
+static void do_handle_rx_pio(struct tegra_uart_port *tup)
+{
+	struct tty_struct *tty = tty_port_tty_get(&tup->uport.state->port);
+	struct tty_port *port = &tup->uport.state->port;
+
+	tegra_uart_handle_rx_pio(tup, port);
+	if (tty) {
+		tty_flip_buffer_push(port);
+		tty_kref_put(tty);
+	}
+}
+
 static void tegra_uart_rx_buffer_push(struct tegra_uart_port *tup,
 				      unsigned int residue)
 {
 	struct tty_port *port = &tup->uport.state->port;
-	struct tty_struct *tty = tty_port_tty_get(port);
 	unsigned int count;
 
 	async_tx_ack(tup->rx_dma_desc);
@@ -705,11 +716,7 @@ static void tegra_uart_rx_buffer_push(struct tegra_uart_port *tup,
 	/* If we are here, DMA is stopped */
 	tegra_uart_copy_rx_to_tty(tup, port, count);
 
-	tegra_uart_handle_rx_pio(tup, port);
-	if (tty) {
-		tty_flip_buffer_push(port);
-		tty_kref_put(tty);
-	}
+	do_handle_rx_pio(tup);
 }
 
 static void tegra_uart_rx_dma_complete(void *args)
@@ -749,8 +756,10 @@ static void tegra_uart_terminate_rx_dma(struct tegra_uart_port *tup)
 {
 	struct dma_tx_state state;
 
-	if (!tup->rx_dma_active)
+	if (!tup->rx_dma_active) {
+		do_handle_rx_pio(tup);
 		return;
+	}
 
 	dmaengine_terminate_all(tup->rx_dma_chan);
 	dmaengine_tx_status(tup->rx_dma_chan, tup->rx_cookie, &state);
@@ -816,18 +825,6 @@ static void tegra_uart_handle_modem_signal_change(struct uart_port *u)
 		uart_handle_cts_change(&tup->uport, msr & UART_MSR_CTS);
 }
 
-static void do_handle_rx_pio(struct tegra_uart_port *tup)
-{
-	struct tty_struct *tty = tty_port_tty_get(&tup->uport.state->port);
-	struct tty_port *port = &tup->uport.state->port;
-
-	tegra_uart_handle_rx_pio(tup, port);
-	if (tty) {
-		tty_flip_buffer_push(port);
-		tty_kref_put(tty);
-	}
-}
-
 static irqreturn_t tegra_uart_isr(int irq, void *data)
 {
 	struct tegra_uart_port *tup = data;
-- 
2.24.0

