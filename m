Return-Path: <SRS0=sEmL=27=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A848C33CA3
	for <linux-serial@archiver.kernel.org>; Fri, 10 Jan 2020 08:55:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5AC82080D
	for <linux-serial@archiver.kernel.org>; Fri, 10 Jan 2020 08:55:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G82gUwhT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727193AbgAJIzC (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 10 Jan 2020 03:55:02 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43126 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727160AbgAJIzB (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 10 Jan 2020 03:55:01 -0500
Received: by mail-wr1-f67.google.com with SMTP id d16so964828wre.10
        for <linux-serial@vger.kernel.org>; Fri, 10 Jan 2020 00:55:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=gQ4Bh3OAeTWN28U6JwH3zankqm8sxWRvOJ7E4HiVe+g=;
        b=G82gUwhTtj1zZaM/e7lAPzQ3PiIWy84krBkHb9nfTI/0UER0fLEqlVLfaOiAZnigzD
         vfgzR6Jo15tHHJb9xkhgQBsD/KgnYgbYChBMtglOiybGxcXPJtoYFQNM7TgCaocYP/D3
         okST4yC8zJ7/26bbwyC6R+s3RWzuB7N7JmvW54rNjEt0cMV1FX5VqO3WwNWkWXyrnkpw
         f35v05ZcZKli/BMwv2az8FOnIzOkYak94K1jV/FHPamgkTRX+ANuVfEZWVvHRSXo4ocB
         SnHsOrAd6xRhrwvamfRfKeJ4xqAgYhsngGvnX7Cg4pBCEFbdBU6xDb19CI4UVH3ZhkjO
         EIAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=gQ4Bh3OAeTWN28U6JwH3zankqm8sxWRvOJ7E4HiVe+g=;
        b=g+2g4Tc7gmZpC+rVdn5MQTXVJ8sioQmIDAyJbnJPApkR5QlGLvVD9Yh73DCYgs7lEr
         0Fr/zd3OVQHVKTGxmyX5ekXRTiMbJuUQ8GJdUj/wAKpImrtMe6fQQMOBNb2iYgb1JZ4d
         Q2OmwA835+YrplvGVO6z9WOGc8+uGciQ2iCINxP8uWOjVg9kavCVky3WZuRtnMSoZx3K
         0ebe3ab6oCamZ7yRIo2JX6iA37IleNlfbzkUcmR06XRc9ZLlw4aaAcuRAXx/j+/jD7aw
         lkA8XCquQehxVuI0gdUQB+ps/2fP1dc9QwdwbVVKpvniNRN5Y8ZINNWmmNjfM+6y4H9d
         qLfQ==
X-Gm-Message-State: APjAAAX1/+R62AJey/z+/Grrxc+gRmjoMjUOjT0Z/paFYBoc/6rR4TGM
        F08WqtcmqaE99mOnEeBN51Fm5w==
X-Google-Smtp-Source: APXvYqyFDjHlr9Och5EICF0yTwr5/lsSf7fWGIB9VNb3wt9ego2i13MHHUDNPtKl7mEbfFuSpDTM6A==
X-Received: by 2002:adf:dfc9:: with SMTP id q9mr2360244wrn.219.1578646499713;
        Fri, 10 Jan 2020 00:54:59 -0800 (PST)
Received: from localhost.localdomain (amontpellier-651-1-327-221.w92-133.abo.wanadoo.fr. [92.133.126.221])
        by smtp.gmail.com with ESMTPSA id a184sm1453539wmf.29.2020.01.10.00.54.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 10 Jan 2020 00:54:59 -0800 (PST)
From:   Loic Poulain <loic.poulain@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org,
        Loic Poulain <loic.poulain@linaro.org>
Subject: [PATCH] tty: serial: msm_serial: RX SW/FIFO mode fallback
Date:   Fri, 10 Jan 2020 09:58:04 +0100
Message-Id: <1578646684-17379-1-git-send-email-loic.poulain@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

During db410c stress test and when the system is low on memory,
the UART/console becomes unresponsive and never recover back.
This has been narrowed down to the msm_start_rx_dma which does
not manage error cases correctly (e.g. dma mapping failure),
indeed, when an error happens, dma transfer is simply discarded
and so never completed, leading to unconfigured RX path.

This patch fixes this issue by switching to SW/FIFO mode in case
of DMA issue. This mainly consists in resetting the receiver to
apply RX BAM/DMA disabling change and re-enabling the RX level
and stale interrupts (previously disabled for DMA transfers).

The DMA will be re-enabled once memory is available since the
SW/FIFO read function (msm_handle_rx_dm) retries to start dma
on completion.

Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
---
 drivers/tty/serial/msm_serial.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/msm_serial.c b/drivers/tty/serial/msm_serial.c
index 1cbae07..a63b703 100644
--- a/drivers/tty/serial/msm_serial.c
+++ b/drivers/tty/serial/msm_serial.c
@@ -610,7 +610,7 @@ static void msm_start_rx_dma(struct msm_port *msm_port)
 				   UARTDM_RX_SIZE, dma->dir);
 	ret = dma_mapping_error(uart->dev, dma->phys);
 	if (ret)
-		return;
+		goto sw_mode;
 
 	dma->desc = dmaengine_prep_slave_single(dma->chan, dma->phys,
 						UARTDM_RX_SIZE, DMA_DEV_TO_MEM,
@@ -661,6 +661,22 @@ static void msm_start_rx_dma(struct msm_port *msm_port)
 	return;
 unmap:
 	dma_unmap_single(uart->dev, dma->phys, UARTDM_RX_SIZE, dma->dir);
+
+sw_mode:
+	/*
+	 * Switch from DMA to SW/FIFO mode. After clearing Rx BAM (UARTDM_DMEN),
+	 * receiver must be reset.
+	 */
+	msm_write(uart, UART_CR_CMD_RESET_RX, UART_CR);
+	msm_write(uart, UART_CR_RX_ENABLE, UART_CR);
+
+	msm_write(uart, UART_CR_CMD_RESET_STALE_INT, UART_CR);
+	msm_write(uart, 0xFFFFFF, UARTDM_DMRX);
+	msm_write(uart, UART_CR_CMD_STALE_EVENT_ENABLE, UART_CR);
+
+	/* Re-enable RX interrupts */
+	msm_port->imr |= (UART_IMR_RXLEV | UART_IMR_RXSTALE);
+	msm_write(uart, msm_port->imr, UART_IMR);
 }
 
 static void msm_stop_rx(struct uart_port *port)
-- 
2.7.4

