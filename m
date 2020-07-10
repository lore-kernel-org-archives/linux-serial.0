Return-Path: <SRS0=t8aj=AV=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82E26C433E7
	for <linux-serial@archiver.kernel.org>; Fri, 10 Jul 2020 14:01:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 629842083B
	for <linux-serial@archiver.kernel.org>; Fri, 10 Jul 2020 14:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594389666;
	bh=SVaoAKRDnHq8LQzz4vBGQnJe73aal5s0UhlYhE0D6+8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vu53P8hvNkvRNtshNG8I97cJuBae8i6CmWNc20L8nEsD42h8j/THag9pZi9VbQi0x
	 HnU4uB7wZBA2pFIYS192at8zL26tZHHaz39IOvUEw4v3K/FOMw78I+l4jVI7JS7GMH
	 Eb+ez9ugCc/ZdIPRFTZ5lWuDJjdIXeCjtTYQchNY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728157AbgGJOBB (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 10 Jul 2020 10:01:01 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:36217 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727978AbgGJOA5 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 10 Jul 2020 10:00:57 -0400
Received: by mail-lf1-f66.google.com with SMTP id k17so3266446lfg.3;
        Fri, 10 Jul 2020 07:00:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RMzivlzUW4rzxFNjnhbbZoBhTd2As0ue9nkTjYqTX5I=;
        b=F02FrvA+O18mR6yaPCcqyR9nFsuYsbTitC5LyEiWwBK/rrwni7bPjshrCLxwr40muA
         dOMjYI+SPI4d01/bNkul5H2AFhDuc25iTUnQtLpgnqMKQ495w/O0K3d44INPbVJBwKi2
         IRMaJUvNaKRtuCBJt+2pnXpGZkFmVFOYreoH1JI3GJuprCSqDRGSSZDPjIJi4Puj5VB8
         BczpwCT90zVlzXNGWWBr2TgpkSoqwtLigJ+Zup3WX/OHqe3trS4Mwj5+2JKvpPto63TM
         HQ/SxeJwp7I85aSA3WQLhM+RrBJeX4vr1PJ8e7aM8wXHdqKQWLx2B0TFbxDsFtMBAkni
         ADtw==
X-Gm-Message-State: AOAM533vUqHUZ7xVtW40AuWRnjHNDQlfwV4k+wyouyY2UaNsWSnhHq/O
        Kh/fPXb/R69PGgTXhJR/hM4=
X-Google-Smtp-Source: ABdhPJwtw5yq+ncWSD8hCBCP/UMKxDvk+Y0CnlyclQc1SXh+aw8BNGPj8CMugR/oByDsUVzExbdH6Q==
X-Received: by 2002:a05:6512:482:: with SMTP id v2mr42695899lfq.3.1594389653839;
        Fri, 10 Jul 2020 07:00:53 -0700 (PDT)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id z7sm1940292ljj.33.2020.07.10.07.00.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 07:00:53 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@xi.terra>)
        id 1jttaB-0000ja-V0; Fri, 10 Jul 2020 16:00:55 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Laxman Dewangan <ldewangan@nvidia.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jslaby@suse.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-serial@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [PATCH 2/2] serial: tegra: drop bogus NULL tty-port checks
Date:   Fri, 10 Jul 2020 15:59:47 +0200
Message-Id: <20200710135947.2737-3-johan@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200710135947.2737-1-johan@kernel.org>
References: <20200710135947.2737-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The struct tty_port is part of the uart state and will never be NULL in
the receive helpers. Drop the bogus NULL checks and rename the
pointer-variables "port" to differentiate them from struct tty_struct
pointers (which can be NULL).

Fixes: 962963e4ee23 ("serial: tegra: Switch to using struct tty_port")
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/tty/serial/serial-tegra.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/serial/serial-tegra.c b/drivers/tty/serial/serial-tegra.c
index b3bbee6b6702..04d1b0807e66 100644
--- a/drivers/tty/serial/serial-tegra.c
+++ b/drivers/tty/serial/serial-tegra.c
@@ -635,7 +635,7 @@ static void tegra_uart_handle_tx_pio(struct tegra_uart_port *tup)
 }
 
 static void tegra_uart_handle_rx_pio(struct tegra_uart_port *tup,
-		struct tty_port *tty)
+		struct tty_port *port)
 {
 	do {
 		char flag = TTY_NORMAL;
@@ -659,13 +659,12 @@ static void tegra_uart_handle_rx_pio(struct tegra_uart_port *tup,
 		if (tup->uport.ignore_status_mask & UART_LSR_DR)
 			continue;
 
-		if (tty)
-			tty_insert_flip_char(tty, ch, flag);
+		tty_insert_flip_char(port, ch, flag);
 	} while (1);
 }
 
 static void tegra_uart_copy_rx_to_tty(struct tegra_uart_port *tup,
-				      struct tty_port *tty,
+				      struct tty_port *port,
 				      unsigned int count)
 {
 	int copied;
@@ -675,17 +674,13 @@ static void tegra_uart_copy_rx_to_tty(struct tegra_uart_port *tup,
 		return;
 
 	tup->uport.icount.rx += count;
-	if (!tty) {
-		dev_err(tup->uport.dev, "No tty port\n");
-		return;
-	}
 
 	if (tup->uport.ignore_status_mask & UART_LSR_DR)
 		return;
 
 	dma_sync_single_for_cpu(tup->uport.dev, tup->rx_dma_buf_phys,
 				count, DMA_FROM_DEVICE);
-	copied = tty_insert_flip_string(tty,
+	copied = tty_insert_flip_string(port,
 			((unsigned char *)(tup->rx_dma_buf_virt)), count);
 	if (copied != count) {
 		WARN_ON(1);
-- 
2.26.2

