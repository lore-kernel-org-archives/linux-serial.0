Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 167C9C433F5
	for <linux-serial@archiver.kernel.org>; Thu, 18 Nov 2021 07:31:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1A7561875
	for <linux-serial@archiver.kernel.org>; Thu, 18 Nov 2021 07:31:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242780AbhKRHe2 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 18 Nov 2021 02:34:28 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:52138 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243831AbhKRHe1 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 18 Nov 2021 02:34:27 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 1F1131FD35;
        Thu, 18 Nov 2021 07:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637220687; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jMO59Qov2OsZCATsL7B22T4DTdBUqa05vDECtUkOWjc=;
        b=kNRGG0hY0FCCXA8CLnzvBm8b0NGe5Wl4OAos64uK6jyOevHdV/I8btqQCeOvq1IfaTkPuG
        BqzJ7yOVkWTy6/S4aSZPqxEkRLWn2QHNAoz+7m3Hetq0cEHVZ2a9ETyDSmMISg4f7TO/Ot
        R7ozwGiA3UCR7uaWHXr8ag8tvLGYljU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637220687;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jMO59Qov2OsZCATsL7B22T4DTdBUqa05vDECtUkOWjc=;
        b=7Gxr/YguKbUxAFBiMH0wfv36iTYOF6amzT/6qTWFqc9viD+8jU94HfF2mml2B3qqqj1MZj
        91Bz4zK1ppixK/Ag==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id EA801A3B84;
        Thu, 18 Nov 2021 07:31:26 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 03/19] mxser: keep only !tty test in ISR
Date:   Thu, 18 Nov 2021 08:31:09 +0100
Message-Id: <20211118073125.12283-4-jslaby@suse.cz>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211118073125.12283-1-jslaby@suse.cz>
References: <20211118073125.12283-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The others are superfluous with tty refcounting in place now. And they
are racy in fact:
* tty_port_initialized() reports false for a small moment after
  interrupts are enabled.
* closing is 1 while the port is still alive.

The queues are flushed later during close anyway. So there is no need
for this special handling. Actually, the ISR should not flush the
queues. It should behave as every other driver, just queue the chars
into tty buffer and go on. But this will be changed later. There is
still a lot code depending on having tty in ISR (and not only tty_port).

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/mxser.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/tty/mxser.c b/drivers/tty/mxser.c
index e9248d39879c..c8a56b0d900d 100644
--- a/drivers/tty/mxser.c
+++ b/drivers/tty/mxser.c
@@ -262,7 +262,6 @@ struct mxser_port {
 	unsigned int xmit_head;
 	unsigned int xmit_tail;
 	unsigned int xmit_cnt;
-	int closing;
 
 	spinlock_t slock;
 };
@@ -903,7 +902,6 @@ static void mxser_close(struct tty_struct *tty, struct file *filp)
 		return;
 	if (tty_port_close_start(port, tty, filp) == 0)
 		return;
-	info->closing = 1;
 	mutex_lock(&port->mutex);
 	mxser_stop_rx(info);
 	mxser_flush_buffer(tty);
@@ -912,7 +910,6 @@ static void mxser_close(struct tty_struct *tty, struct file *filp)
 	mxser_shutdown_port(port);
 	tty_port_set_initialized(port, 0);
 	mutex_unlock(&port->mutex);
-	info->closing = 0;
 	/* Right now the tty_port set is done outside of the close_end helper
 	   as we don't yet have everyone using refcounts */	
 	tty_port_close_end(port, tty);
@@ -1668,7 +1665,7 @@ static bool mxser_port_isr(struct mxser_port *port)
 
 	iir &= MOXA_MUST_IIR_MASK;
 	tty = tty_port_tty_get(&port->port);
-	if (!tty || port->closing || !tty_port_initialized(&port->port)) {
+	if (!tty) {
 		status = inb(port->ioaddr + UART_LSR);
 		outb(port->FCR | UART_FCR_CLEAR_RCVR | UART_FCR_CLEAR_XMIT,
 				port->ioaddr + UART_FCR);
-- 
2.33.1

