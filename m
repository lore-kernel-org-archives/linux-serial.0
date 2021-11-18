Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6BC5C433F5
	for <linux-serial@archiver.kernel.org>; Thu, 18 Nov 2021 07:31:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0F1561A3D
	for <linux-serial@archiver.kernel.org>; Thu, 18 Nov 2021 07:31:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243910AbhKRHek (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 18 Nov 2021 02:34:40 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:52154 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243853AbhKRHe2 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 18 Nov 2021 02:34:28 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 25C941FD38;
        Thu, 18 Nov 2021 07:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637220688; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2lcqYAPhKVv1hBbK73Dv2zJhHQ65booK25c2IEd61D8=;
        b=j5+DMpwBfXFoHCP1opxAeSgzsblTQymqKUkxsBq55aDmzkQFbjJ09jvbfTGR3MyFNJY6hL
        7UpBS2c0mUgwdofB1WQFmBnyjMd1w1cu00pRY7zgG2KP4z+F0aW/JJs1Lsd13EesMxRdVS
        +E2HSA5bZWsq9oocYouNwu45w8rVFSo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637220688;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2lcqYAPhKVv1hBbK73Dv2zJhHQ65booK25c2IEd61D8=;
        b=04KT5XUDy0XTgZt9j7tGg+wooN0OJ42VPuxVC0+CH/mcdd8Q3Lww4FTzHxGjtdGOFgY405
        ut6Kn/mxdAdiAKDA==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id F2AF5A3B83;
        Thu, 18 Nov 2021 07:31:27 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 08/19] mxser: call stop_rx from mxser_shutdown_port()
Date:   Thu, 18 Nov 2021 08:31:14 +0100
Message-Id: <20211118073125.12283-9-jslaby@suse.cz>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211118073125.12283-1-jslaby@suse.cz>
References: <20211118073125.12283-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

mxser_stop_rx() should be called from mxser_shutdown_port() for several
reasons:
1) info->slock is held while manipulating IER (as on other places),
2) hangup now stops rx too,
3) mxser_close() will use tty_port_close() and there is no place except
   tty_port_operations::shutdown() where this can be done,
4) this is the same sequence as serial_core does. So we can map this
   code 1:1 when switching the driver to it.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/mxser.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/drivers/tty/mxser.c b/drivers/tty/mxser.c
index 6b47a0607f59..45ee1122a5f7 100644
--- a/drivers/tty/mxser.c
+++ b/drivers/tty/mxser.c
@@ -807,6 +807,20 @@ static int mxser_activate(struct tty_port *port, struct tty_struct *tty)
 	return 0;
 }
 
+/*
+ * To stop accepting input, we disable the receive line status interrupts, and
+ * tell the interrupt driver to stop checking the data ready bit in the line
+ * status register.
+ */
+static void mxser_stop_rx(struct mxser_port *info)
+{
+	info->IER &= ~UART_IER_RLSI;
+	if (info->board->must_hwid)
+		info->IER &= ~MOXA_MUST_RECV_ISR;
+
+	outb(info->IER, info->ioaddr + UART_IER);
+}
+
 /*
  * This routine will shutdown a serial port
  */
@@ -817,6 +831,8 @@ static void mxser_shutdown_port(struct tty_port *port)
 
 	spin_lock_irqsave(&info->slock, flags);
 
+	mxser_stop_rx(info);
+
 	/*
 	 * clear delta_msr_wait queue to avoid mem leaks: we may free the irq
 	 * here so the queue might never be waken up
@@ -880,20 +896,6 @@ static void mxser_flush_buffer(struct tty_struct *tty)
 	tty_wakeup(tty);
 }
 
-/*
- * To stop accepting input, we disable the receive line status interrupts, and
- * tell the interrupt driver to stop checking the data ready bit in the line
- * status register.
- */
-static void mxser_stop_rx(struct mxser_port *info)
-{
-	info->IER &= ~UART_IER_RLSI;
-	if (info->board->must_hwid)
-		info->IER &= ~MOXA_MUST_RECV_ISR;
-
-	outb(info->IER, info->ioaddr + UART_IER);
-}
-
 /*
  * This routine is called when the serial port gets closed.  First, we
  * wait for the last remaining data to be sent.  Then, we unlink its
@@ -908,7 +910,6 @@ static void mxser_close(struct tty_struct *tty, struct file *filp)
 	if (tty_port_close_start(port, tty, filp) == 0)
 		return;
 	mutex_lock(&port->mutex);
-	mxser_stop_rx(info);
 	mxser_flush_buffer(tty);
 	if (tty_port_initialized(port) && C_HUPCL(tty))
 		tty_port_lower_dtr_rts(port);
-- 
2.33.1

