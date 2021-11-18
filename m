Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4FCEC43217
	for <linux-serial@archiver.kernel.org>; Thu, 18 Nov 2021 07:31:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D085761A3D
	for <linux-serial@archiver.kernel.org>; Thu, 18 Nov 2021 07:31:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243932AbhKRHes (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 18 Nov 2021 02:34:48 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:46384 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243862AbhKRHe3 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 18 Nov 2021 02:34:29 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 562C1218A8;
        Thu, 18 Nov 2021 07:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637220689; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8uJEY6GawRVuGpeu4+3Tz6MShZ9mZUQ4e2P24QxckKI=;
        b=IEr94KtyGAiXSpZFb9vdBjO5Q9asvF3B3G9Z8MovL6F9PE04sRQyzjj1wBN29Tm2hGva3h
        mYtFd8zF97KzM7libLerNOwzraSanTeIoMNZyyLveVHKhby2QNrGslYnOXU+qiN6UCOgpt
        8FJIojBQACCisKM0VyQzBBVabnvpCEU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637220689;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8uJEY6GawRVuGpeu4+3Tz6MShZ9mZUQ4e2P24QxckKI=;
        b=nX3IzNhJKhGRsfdU1UYKdy5SUWx3tYPk49HoOMBR7BbfTJM8uTVnzAj8vyoZHv68/rhz10
        mBwFUxzw+QFlOSAw==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 3863FA3B83;
        Thu, 18 Nov 2021 07:31:29 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 14/19] mxser: don't throttle manually
Date:   Thu, 18 Nov 2021 08:31:20 +0100
Message-Id: <20211118073125.12283-15-jslaby@suse.cz>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211118073125.12283-1-jslaby@suse.cz>
References: <20211118073125.12283-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

First, checking tty->receive_room to signalize whether there is enough space
in the tty buffers does not make much sense. Provided the tty buffers
are in tty_port and those are not checked at all.

Second, if the rx path is throttled, with CRTSCTS, RTS is deasserted,
but is never asserted again. This leads to port "lockup", not accepting
any more input.

So:
1) stty -F /dev/ttyMI0 crtscts # the mxser port
2) stty -F /dev/ttyS6 crtscts # the connected port
3) cat /dev/ttyMI0
4) "write in a loop" to /dev/ttyS6
5) cat from 3) produces the bytes from 4)
6) killall -STOP cat (the 3)'s one)
7) wait for RTS to drop on /dev/ttyMI0
8) killall -CONT cat (again the 3)'s one)

cat erroneously produces no more output now (i.e. no data sent from
ttyS6 to ttyMI can be seen).

Note that the step 7) is performed twice: once from n_tty by
tty_throttle_safe(), once by mxser_stoprx() from the receive path. Then
after step 7), n_tty correctly unthrottles the input, but mxser calls
mxser_stoprx() again as there is still only a little space in n_tty
buffers (tty->receive_room mentioned at the beginning), but the device's
FIFO is/can be already filled.

After this patch, the output is correctly resumed, i.e. n_tty both
throttles and unthrottles without interfering with mxser's attempts.

This allows us to get rid of the non-standard ldisc_stop_rx flag from
struct mxser_port.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/mxser.c | 36 ++++++------------------------------
 1 file changed, 6 insertions(+), 30 deletions(-)

diff --git a/drivers/tty/mxser.c b/drivers/tty/mxser.c
index c3f262dc936d..2359b4aa68af 100644
--- a/drivers/tty/mxser.c
+++ b/drivers/tty/mxser.c
@@ -251,8 +251,6 @@ struct mxser_port {
 	u8 MCR;			/* Modem control register */
 	u8 FCR;			/* FIFO control register */
 
-	bool ldisc_stop_rx;
-
 	struct async_icount icount; /* kernel counters for 4 input interrupts */
 	unsigned int timeout;
 
@@ -1286,11 +1284,14 @@ static int mxser_get_icount(struct tty_struct *tty,
 	return 0;
 }
 
-static void mxser_stoprx(struct tty_struct *tty)
+/*
+ * This routine is called by the upper-layer tty layer to signal that
+ * incoming characters should be throttled.
+ */
+static void mxser_throttle(struct tty_struct *tty)
 {
 	struct mxser_port *info = tty->driver_data;
 
-	info->ldisc_stop_rx = true;
 	if (I_IXOFF(tty)) {
 		if (info->board->must_hwid) {
 			info->IER &= ~MOXA_MUST_RECV_ISR;
@@ -1309,21 +1310,11 @@ static void mxser_stoprx(struct tty_struct *tty)
 	}
 }
 
-/*
- * This routine is called by the upper-layer tty layer to signal that
- * incoming characters should be throttled.
- */
-static void mxser_throttle(struct tty_struct *tty)
-{
-	mxser_stoprx(tty);
-}
-
 static void mxser_unthrottle(struct tty_struct *tty)
 {
 	struct mxser_port *info = tty->driver_data;
 
 	/* startrx */
-	info->ldisc_stop_rx = false;
 	if (I_IXOFF(tty)) {
 		if (info->x_char)
 			info->x_char = 0;
@@ -1515,9 +1506,6 @@ static bool mxser_receive_chars_new(struct tty_struct *tty,
 	if (hwid == MOXA_MUST_MU150_HWID)
 		gdl &= MOXA_MUST_GDL_MASK;
 
-	if (gdl >= tty->receive_room && !port->ldisc_stop_rx)
-		mxser_stoprx(tty);
-
 	while (gdl--) {
 		u8 ch = inb(port->ioaddr + UART_RX);
 		tty_insert_flip_char(&port->port, ch, 0);
@@ -1530,10 +1518,8 @@ static u8 mxser_receive_chars_old(struct tty_struct *tty,
 		                struct mxser_port *port, u8 status)
 {
 	enum mxser_must_hwid hwid = port->board->must_hwid;
-	int recv_room = tty->receive_room;
 	int ignored = 0;
 	int max = 256;
-	int cnt = 0;
 	u8 ch;
 
 	do {
@@ -1568,14 +1554,8 @@ static u8 mxser_receive_chars_old(struct tty_struct *tty,
 					port->icount.overrun++;
 				}
 			}
-			tty_insert_flip_char(&port->port, ch, flag);
-			cnt++;
-			if (cnt >= recv_room) {
-				if (!port->ldisc_stop_rx)
-					mxser_stoprx(tty);
+			if (!tty_insert_flip_char(&port->port, ch, flag))
 				break;
-			}
-
 		}
 
 		if (hwid)
@@ -1590,9 +1570,6 @@ static u8 mxser_receive_chars_old(struct tty_struct *tty,
 static u8 mxser_receive_chars(struct tty_struct *tty,
 		struct mxser_port *port, u8 status)
 {
-	if (tty->receive_room == 0 && !port->ldisc_stop_rx)
-		mxser_stoprx(tty);
-
 	if (!mxser_receive_chars_new(tty, port, status))
 		status = mxser_receive_chars_old(tty, port, status);
 
@@ -1798,7 +1775,6 @@ static void mxser_initbrd(struct mxser_board *brd, bool high_baud)
 		tty_port_init(&info->port);
 		info->port.ops = &mxser_port_ops;
 		info->board = brd;
-		info->ldisc_stop_rx = false;
 
 		/* Enhance mode enabled here */
 		if (brd->must_hwid != MOXA_OTHER_UART)
-- 
2.33.1

