Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05C75C433EF
	for <linux-serial@archiver.kernel.org>; Thu, 18 Nov 2021 07:31:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E281461269
	for <linux-serial@archiver.kernel.org>; Thu, 18 Nov 2021 07:31:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243846AbhKRHe1 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 18 Nov 2021 02:34:27 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:46328 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243818AbhKRHe1 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 18 Nov 2021 02:34:27 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id B1E9421891;
        Thu, 18 Nov 2021 07:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637220686; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KFC5gAiqk+r9hL3AJyPeq6Blqs/golh24ruvTn2aT08=;
        b=px5q/VM3kiRVScJQijeUW0HiGqOXqYo7BzsFDU7mFwtUCgdMDT7bnVeHlCdaA9OtCXSOPz
        Bqvw7qwlyFGSr11JsdnRW7V2WQHsFI83CjeSzETx7YbIBwZZF3nAklptIJtuMrs9t0tvOj
        4lFJerL/XJtEF77SCp9CbR4/YdJL+2A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637220686;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KFC5gAiqk+r9hL3AJyPeq6Blqs/golh24ruvTn2aT08=;
        b=wfjNPRLrjMDr9d4213mbXAAPSWq6Jb1r7wbf2zFwACqiK6x5q2cdqUN6il0pwK94DOWclG
        rvoPT649NPeN1UBw==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 8950EA3B84;
        Thu, 18 Nov 2021 07:31:26 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 01/19] mxser: remove wait for sent from mxser_close_port
Date:   Thu, 18 Nov 2021 08:31:07 +0100
Message-Id: <20211118073125.12283-2-jslaby@suse.cz>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211118073125.12283-1-jslaby@suse.cz>
References: <20211118073125.12283-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

mxser_close() behaves like this:
  -> tty_port_close_start()
    -> tty_wait_until_sent()
      -> mxser_wait_until_sent()
  -> mxser_close_port
    -> wait for TEMT

So it is already waited for TEMT through mxser_wait_until_sent() and
there is another round of waiting in mxser_close_port(). The latter one
is superfluous as nothing could be filled into the output FIFO. Remove
the call.

This helps unification among drivers (so that all behave the same) and
future use of tty_port_close().

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/mxser.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/tty/mxser.c b/drivers/tty/mxser.c
index 93a95a135a71..f9615245a60a 100644
--- a/drivers/tty/mxser.c
+++ b/drivers/tty/mxser.c
@@ -878,7 +878,6 @@ static void mxser_flush_buffer(struct tty_struct *tty)
 static void mxser_close_port(struct tty_port *port)
 {
 	struct mxser_port *info = container_of(port, struct mxser_port, port);
-	unsigned long timeout;
 	/*
 	 * At this point we stop accepting input.  To do this, we
 	 * disable the receive line status interrupts, and tell the
@@ -890,17 +889,6 @@ static void mxser_close_port(struct tty_port *port)
 		info->IER &= ~MOXA_MUST_RECV_ISR;
 
 	outb(info->IER, info->ioaddr + UART_IER);
-	/*
-	 * Before we drop DTR, make sure the UART transmitter
-	 * has completely drained; this is especially
-	 * important if there is a transmit FIFO!
-	 */
-	timeout = jiffies + HZ;
-	while (!(inb(info->ioaddr + UART_LSR) & UART_LSR_TEMT)) {
-		schedule_timeout_interruptible(5);
-		if (time_after(jiffies, timeout))
-			break;
-	}
 }
 
 /*
-- 
2.33.1

