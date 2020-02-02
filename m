Return-Path: <SRS0=Ox/l=3W=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4EEAC35249
	for <linux-serial@archiver.kernel.org>; Sun,  2 Feb 2020 21:30:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CF812067C
	for <linux-serial@archiver.kernel.org>; Sun,  2 Feb 2020 21:30:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="URsjV6xk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbgBBVaR (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 2 Feb 2020 16:30:17 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:42082 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726967AbgBBVaQ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 2 Feb 2020 16:30:16 -0500
Received: by mail-lf1-f67.google.com with SMTP id y19so8296568lfl.9;
        Sun, 02 Feb 2020 13:30:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ksD2PJRkb52M0/uH1lv8CPBMGBMZornu7c/r2Oi94wE=;
        b=URsjV6xkgonCaoi+/ZKtmJIgWHog0hZZn0TRuOqMEFv30Sx8AfdweKXYqcEeQo8Waa
         mIvdSAG91QelmxL8fm/6Ocp7TuRA8Q/kdUpRIDvwTpWFu3pVp/p6QjjevozMs0PivC8Z
         bVfI1u/pxe57MEHXy5pDXKhhEtXnaAFAFyL+FXdKuFgV/Oo9Jw7wzlS/g2xIFcgIwX+4
         lYZtjWPWz+Nipxg0UuMqpU278/M7UfzHmbn4z/JzglBaiAMyyMYaA9WuOIUydmF5DIsD
         cUghRlpyM6WWT4NaUNfbAik3rWW/Og8eDcbEvnpMBL5VXh7YqTf/OgKwm4UDrGMqvzy4
         qT7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ksD2PJRkb52M0/uH1lv8CPBMGBMZornu7c/r2Oi94wE=;
        b=DsTvi0fxrC+IsCO98QdiPHdk42gsx6t5lnZo082mtRnyq7Kv/wlPJW6LtYoVipw4w0
         IcG5mYsOnG98ATbC3d2IYp0oEFbeRiQgXwGRBCNEOAfSyLa8hLGTELjvIOiEUu+J4cWC
         xn+96Kr98gWn0xbcMQdmL2skNSw5Uf/NrJtf5IwgllQYtnOGy+1nocf7Ka4Zt3sU7cMg
         1cdvEtr0gadqUA8UlzAXv+4WWZckicTMkkEg6BeQT0FvL6AtKMMrgrLOXiee/bDe28fi
         mRVNyj6yHFFxw3APuF8qz1wLD8OROoUeB+ZQ5cR81iXxUkQP4SS0Pp6ru1H3BAeur71v
         LoTg==
X-Gm-Message-State: APjAAAUCyJscD+1MS3ruhzKE7L+KWR7d+Ib+Kgt8fGUnnUv8CzB9nWB5
        F7iEIWWqG8GJCJe1IwvT1MI=
X-Google-Smtp-Source: APXvYqxpd/0zWkiP7/aoIoJkgjU/MVBmwR/6VUrTded9q2edoc0+TiKxYGsjaZ5tUkQP7d/jUt+szQ==
X-Received: by 2002:ac2:5c4b:: with SMTP id s11mr10492652lfp.133.1580679013061;
        Sun, 02 Feb 2020 13:30:13 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id u25sm8586833ljj.70.2020.02.02.13.30.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Feb 2020 13:30:12 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Laxman Dewangan <ldewangan@nvidia.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     linux-serial@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH for 5.6 v1] tty: serial: Handle RX transfer in PIO mode if DMA wasn't started
Date:   Mon,  3 Feb 2020 00:28:44 +0300
Message-Id: <20200202212844.11592-1-digetx@gmail.com>
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

