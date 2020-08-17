Return-Path: <SRS0=iWX9=B3=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 275D7C433E1
	for <linux-serial@archiver.kernel.org>; Mon, 17 Aug 2020 08:59:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0B4C207DF
	for <linux-serial@archiver.kernel.org>; Mon, 17 Aug 2020 08:59:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eqHEvOD6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728307AbgHQI7w (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 17 Aug 2020 04:59:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728739AbgHQI7q (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 17 Aug 2020 04:59:46 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CDA6C061388;
        Mon, 17 Aug 2020 01:59:45 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id 128so7801407pgd.5;
        Mon, 17 Aug 2020 01:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bfbk6qu+Dh0r09/BC2HVXkZhe9/6tVYt11hNr0Vm+DI=;
        b=eqHEvOD60MZgX5QZiePO/SspTddcQhdgDeNCR0Mu0EohogFtoim9ZkpjIFOkxExKkV
         GcXVa3oznDDxllthJndBo0kfvWz7VfsWVYM29+Efm6v+9NIBXW4oqCm5P1PyrK+NYpd+
         9bmcq7UrAawZ2temd47NpyFCLPMwIvmx0FvUf4WNbQ3P46MunRJUvSzick/BSb5onCWf
         pUyDwHsKJrMBe4XRtdo6RMydJkB89oFjWH7ubvmVKtxkHsKDJE1gwVmpNtwyGzYUyvG7
         m/kOhs50nXk+/R+4pEyb+x+3OOzw/Di520QgWIpIR7WzYdlXiOIhUoqwM9F1NMGZ1lP4
         M5qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bfbk6qu+Dh0r09/BC2HVXkZhe9/6tVYt11hNr0Vm+DI=;
        b=jBan3AII1a1k/uPxJQxtuPjJFWdqtR15d3kgAY7L/suP1/WHGXojgqHE3/IOitofT+
         PMFxjKZks8cfqgmsAJ56QJmQjUCBopQOkzC360LS+JLV1Abu/IrBFblAQnGKwF+GTcUG
         zTd6iVe97QuXJ6T6Vaa314OoPeIS1Acq/NDJvfQzkOHtnKr8Gs5Ke30QbTrlJl6d5V90
         d2dy+2bCnsJb08wRZXVPjDYu9kZ5mPxssLldqvgUmT3aQJUwUZo1lbUe3YGusLxvWvXH
         Gbt/zM4PMhaGlOOcUSDUFw9jY+EHUoAUl0d/0f8Ib1FHUff9HC19SwaNHUWONxCZcCRn
         oBcA==
X-Gm-Message-State: AOAM530MvAGjMNso68NmXcKkY84RKxNRhvyyYiaVlafPyhDp1VICT9yH
        0FXd2x0/z1HZ/kpf6/Qu9EpsK6A5BPnUvA==
X-Google-Smtp-Source: ABdhPJwbOUjxkSKQIB51eMU9r5yw0K1XtQNm4cXz6JwSEOXlV6ZMtYAd8hVyZnS9wqz7EYBa7vpvLg==
X-Received: by 2002:aa7:8c42:: with SMTP id e2mr10278896pfd.181.1597654785029;
        Mon, 17 Aug 2020 01:59:45 -0700 (PDT)
Received: from localhost.localdomain ([49.207.202.98])
        by smtp.gmail.com with ESMTPSA id j13sm18508547pfn.166.2020.08.17.01.59.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 01:59:44 -0700 (PDT)
From:   Allen Pais <allen.cryptic@gmail.com>
To:     richard.genoud@gmail.com, gregkh@linuxfoundation.org
Cc:     keescook@chromium.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Allen Pais <allen.lkml@gmail.com>,
        Romain Perier <romain.perier@gmail.com>
Subject: [PATCH 4/4] tty: timbuart: convert tasklets to use new tasklet_setup() API
Date:   Mon, 17 Aug 2020 14:29:21 +0530
Message-Id: <20200817085921.26033-5-allen.cryptic@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200817085921.26033-1-allen.cryptic@gmail.com>
References: <20200817085921.26033-1-allen.cryptic@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Allen Pais <allen.lkml@gmail.com>

In preparation for unconditionally passing the
struct tasklet_struct pointer to all tasklet
callbacks, switch to using the new tasklet_setup()
and from_tasklet() to pass the tasklet pointer explicitly.

Signed-off-by: Romain Perier <romain.perier@gmail.com>
Signed-off-by: Allen Pais <allen.lkml@gmail.com>
---
 drivers/tty/serial/timbuart.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/timbuart.c b/drivers/tty/serial/timbuart.c
index 19d38b504e27..2126e6e6dfd1 100644
--- a/drivers/tty/serial/timbuart.c
+++ b/drivers/tty/serial/timbuart.c
@@ -172,9 +172,9 @@ static void timbuart_handle_rx_port(struct uart_port *port, u32 isr, u32 *ier)
 	dev_dbg(port->dev, "%s - leaving\n", __func__);
 }
 
-static void timbuart_tasklet(unsigned long arg)
+static void timbuart_tasklet(struct tasklet_struct *t)
 {
-	struct timbuart_port *uart = (struct timbuart_port *)arg;
+	struct timbuart_port *uart = from_tasklet(uart, t, tasklet);
 	u32 isr, ier = 0;
 
 	spin_lock(&uart->port.lock);
@@ -451,7 +451,7 @@ static int timbuart_probe(struct platform_device *dev)
 	}
 	uart->port.irq = irq;
 
-	tasklet_init(&uart->tasklet, timbuart_tasklet, (unsigned long)uart);
+	tasklet_setup(&uart->tasklet, timbuart_tasklet);
 
 	err = uart_register_driver(&timbuart_driver);
 	if (err)
-- 
2.17.1

