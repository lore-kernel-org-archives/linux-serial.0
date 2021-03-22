Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D64AC433DB
	for <linux-serial@archiver.kernel.org>; Mon, 22 Mar 2021 11:11:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C32136198C
	for <linux-serial@archiver.kernel.org>; Mon, 22 Mar 2021 11:11:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbhCVLK4 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 22 Mar 2021 07:10:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:34560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229941AbhCVLKk (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 22 Mar 2021 07:10:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EC17261984;
        Mon, 22 Mar 2021 11:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616411436;
        bh=NC+1ODaAxS8f4l6Eky4fpzsmBqnrxmry+8HRa0Mpy8o=;
        h=From:To:Cc:Subject:Date:From;
        b=NvRmCNKpAkCtzMTEP6Rzoy6JWrrZ12TJlT9QM+GnoV4xCS1FuCCvOguKOtUZ4WY7A
         Y73NqI7LaXWIrYydNoNrqYb1fOefqzrA1ibq1+QnamTKh4OswTK1T0LNS/BLTvWmdz
         JySHq+PdhTZvFWgwwNvYILdycaUuB36y5u8polW6CLm9dJ5BJaBqzpfhjXx7zWm4uc
         HO0DWxKsKorlS56AUE+VjidXEadxek7fJV6nvvaPLgl2bblaUZb4vQWlF38wX63jAQ
         nNE1qljzVM6JBFFeW2nPkilZ0P6ckt0qD9XzVfp7M0POTkhO036WTZ3ahGAN/IXIU8
         LX8LSSek2gBqQ==
Received: from johan by xi with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lOISS-0008KL-A9; Mon, 22 Mar 2021 12:10:53 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan@kernel.org>,
        Sam Nobs <samuel.nobs@taitradio.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH] serial: imx: drop workaround for forced irq threading
Date:   Mon, 22 Mar 2021 12:10:36 +0100
Message-Id: <20210322111036.31966-1-johan@kernel.org>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Force-threaded interrupt handlers used to run with interrupts enabled,
something which could lead to deadlocks in case a threaded handler
shared a lock with code running in hard interrupt context (e.g. timer
callbacks) and did not explicitly disable interrupts.

This was specifically the case for serial drivers that take the port
lock in their console write path as printk can be called from hard
interrupt context also with forced threading ("threadirqs").

Since commit 81e2073c175b ("genirq: Disable interrupts for force
threaded handlers") interrupt handlers always run with interrupts
disabled on non-RT so that drivers no longer need to do handle this.

Drop the now obsolete workaround added by commit 33f16855dcb9 ("tty:
serial: imx: fix potential deadlock").

Cc: Sam Nobs <samuel.nobs@taitradio.com>
Cc: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/tty/serial/imx.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 8257597d034d..cca730fc2b0b 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -922,14 +922,8 @@ static irqreturn_t imx_uart_int(int irq, void *dev_id)
 	struct imx_port *sport = dev_id;
 	unsigned int usr1, usr2, ucr1, ucr2, ucr3, ucr4;
 	irqreturn_t ret = IRQ_NONE;
-	unsigned long flags = 0;
 
-	/*
-	 * IRQs might not be disabled upon entering this interrupt handler,
-	 * e.g. when interrupt handlers are forced to be threaded. To support
-	 * this scenario as well, disable IRQs when acquiring the spinlock.
-	 */
-	spin_lock_irqsave(&sport->port.lock, flags);
+	spin_lock(&sport->port.lock);
 
 	usr1 = imx_uart_readl(sport, USR1);
 	usr2 = imx_uart_readl(sport, USR2);
@@ -999,7 +993,7 @@ static irqreturn_t imx_uart_int(int irq, void *dev_id)
 		ret = IRQ_HANDLED;
 	}
 
-	spin_unlock_irqrestore(&sport->port.lock, flags);
+	spin_unlock(&sport->port.lock);
 
 	return ret;
 }
-- 
2.26.3

