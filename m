Return-Path: <SRS0=EMO6=3B=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B8D1C33CA2
	for <linux-serial@archiver.kernel.org>; Sun, 12 Jan 2020 18:12:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 790552187F
	for <linux-serial@archiver.kernel.org>; Sun, 12 Jan 2020 18:12:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ivY56i+g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733201AbgALSMA (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 12 Jan 2020 13:12:00 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:40882 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733163AbgALSMA (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 12 Jan 2020 13:12:00 -0500
Received: by mail-lj1-f194.google.com with SMTP id u1so7513366ljk.7;
        Sun, 12 Jan 2020 10:11:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YJVXU10oDfgvRexuSvPa3vqWcQwamQAihJMaOV5Iic0=;
        b=ivY56i+gykXt6XSjr3FikFQwY77Fr9C+OXP1AARna4DuN6bBI+m95XWKyi9oLu7BM6
         6zFwEHYQDWBHO+WZH8Lv4bUNuObyRWo1XVtzaU9wREABN0QYDm1l4L/hvlXp8GNaqULL
         8BcVb/3cdcA3k/Rkv5DOnU+RjIw9HBAlab8naD1tlYhDu/SJhcoURMzd9lStruEeuNaQ
         m+BFYeBH2xj5X/e2DQyQbEOmVd6AeFQZldyg7LSUFNEm3qjv+E6ZgpKwPc8E+n0JDYPl
         3LTAzMiu5nDZI86qFNF0sEMtoR8w5e8fVirrsg6R2FMhQ6HgODnXuyZ9+1jRNdh9jNMQ
         E9Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YJVXU10oDfgvRexuSvPa3vqWcQwamQAihJMaOV5Iic0=;
        b=QdoPS280pBfhd5PPzIO2VvBonzVmpQOlfLDQrjnDwwqva6YA4bYxw4CItBHuR2xBgY
         xTpnmeIHvphT+1NTrp9kNzgTGpG9MSK5A26a3YdbHOuifSPMrY1zMwiFZTQWEsjTKGng
         QuujJh1xa3vvrwL3FGz/K/tci6mql8V61bJuVPiIxAV0vYOZoBzYOC2YkL2JcMREKZ1V
         8WWJ4by8wJlTHTETX2PA73ejuwR1h1cM8UkFEJoMeW8qv+hzCFEaidDuibLVegKmOyNr
         i46yKZQw3XrEpVFJWDpkNB3CSd8Jm8QymB8wZ5iQBHiQpP6DS47upthQ8G7GveZifQzw
         6Ydg==
X-Gm-Message-State: APjAAAWV/5ffqM4A9Ek8+WBmjlX3AJjGVSNYld4ju+tYWbmB/RxeNLCl
        o7om439qiOHpiN/1rMtDeAIGJDE+
X-Google-Smtp-Source: APXvYqzxbmtigao8IDfOesGjBcx8TQpyFsw3ke+jRYHd2RJd/0K0yJjUZzSsz/w18OB7mcByIgak4w==
X-Received: by 2002:a2e:b4e7:: with SMTP id s7mr8382268ljm.58.1578852718367;
        Sun, 12 Jan 2020 10:11:58 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id 195sm4542784ljj.55.2020.01.12.10.11.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jan 2020 10:11:57 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Laxman Dewangan <ldewangan@nvidia.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     linux-serial@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/2] tty: serial: tegra: Optimize DMA buffer synchronization
Date:   Sun, 12 Jan 2020 21:09:19 +0300
Message-Id: <20200112180919.5194-3-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200112180919.5194-1-digetx@gmail.com>
References: <20200112180919.5194-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Synchronize only the dirty part of DMA buffer in order to avoid
unnecessary overhead of syncing of the clean part, which is the case
of every serial DMA transfer in practice.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/tty/serial/serial-tegra.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/serial-tegra.c b/drivers/tty/serial/serial-tegra.c
index 3b495e7c9534..33034b852a51 100644
--- a/drivers/tty/serial/serial-tegra.c
+++ b/drivers/tty/serial/serial-tegra.c
@@ -534,11 +534,12 @@ static int tegra_uart_start_tx_dma(struct tegra_uart_port *tup,
 	struct circ_buf *xmit = &tup->uport.state->xmit;
 	dma_addr_t tx_phys_addr;
 
-	dma_sync_single_for_device(tup->uport.dev, tup->tx_dma_buf_phys,
-				UART_XMIT_SIZE, DMA_TO_DEVICE);
-
 	tup->tx_bytes = count & ~(0xF);
 	tx_phys_addr = tup->tx_dma_buf_phys + xmit->tail;
+
+	dma_sync_single_for_device(tup->uport.dev, tx_phys_addr,
+				   tup->tx_bytes, DMA_TO_DEVICE);
+
 	tup->tx_dma_desc = dmaengine_prep_slave_single(tup->tx_dma_chan,
 				tx_phys_addr, tup->tx_bytes, DMA_MEM_TO_DEV,
 				DMA_PREP_INTERRUPT);
@@ -680,7 +681,7 @@ static void tegra_uart_copy_rx_to_tty(struct tegra_uart_port *tup,
 		return;
 
 	dma_sync_single_for_cpu(tup->uport.dev, tup->rx_dma_buf_phys,
-				TEGRA_UART_RX_DMA_BUFFER_SIZE, DMA_FROM_DEVICE);
+				count, DMA_FROM_DEVICE);
 	copied = tty_insert_flip_string(tty,
 			((unsigned char *)(tup->rx_dma_buf_virt)), count);
 	if (copied != count) {
@@ -688,7 +689,7 @@ static void tegra_uart_copy_rx_to_tty(struct tegra_uart_port *tup,
 		dev_err(tup->uport.dev, "RxData copy to tty layer failed\n");
 	}
 	dma_sync_single_for_device(tup->uport.dev, tup->rx_dma_buf_phys,
-				TEGRA_UART_RX_DMA_BUFFER_SIZE, DMA_TO_DEVICE);
+				   count, DMA_TO_DEVICE);
 }
 
 static void tegra_uart_rx_buffer_push(struct tegra_uart_port *tup,
@@ -788,8 +789,6 @@ static int tegra_uart_start_rx_dma(struct tegra_uart_port *tup)
 	tup->rx_dma_active = true;
 	tup->rx_dma_desc->callback = tegra_uart_rx_dma_complete;
 	tup->rx_dma_desc->callback_param = tup;
-	dma_sync_single_for_device(tup->uport.dev, tup->rx_dma_buf_phys,
-				count, DMA_TO_DEVICE);
 	tup->rx_bytes_requested = count;
 	tup->rx_cookie = dmaengine_submit(tup->rx_dma_desc);
 	dma_async_issue_pending(tup->rx_dma_chan);
@@ -1154,6 +1153,9 @@ static int tegra_uart_dma_channel_allocate(struct tegra_uart_port *tup,
 			dma_release_channel(dma_chan);
 			return -ENOMEM;
 		}
+		dma_sync_single_for_device(tup->uport.dev, dma_phys,
+					   TEGRA_UART_RX_DMA_BUFFER_SIZE,
+					   DMA_TO_DEVICE);
 		dma_sconfig.src_addr = tup->uport.mapbase;
 		dma_sconfig.src_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
 		dma_sconfig.src_maxburst = tup->cdata->max_dma_burst_bytes;
-- 
2.24.0

