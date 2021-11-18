Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEB14C433EF
	for <linux-serial@archiver.kernel.org>; Thu, 18 Nov 2021 07:31:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 943CF61875
	for <linux-serial@archiver.kernel.org>; Thu, 18 Nov 2021 07:31:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243885AbhKRHed (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 18 Nov 2021 02:34:33 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:46352 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243838AbhKRHe2 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 18 Nov 2021 02:34:28 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 7C2C1218B5;
        Thu, 18 Nov 2021 07:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637220687; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YXHWFxXvwHXrG+llI4tPpUmGY4L8ryaGLtJVyNvcgPY=;
        b=cPdfOK5fDHjaaH4/62o1hhL76OBDjUpssTFIKSKtsJNEenycQptsMFccySUGXkFhcXB83a
        NODg76tctwRlwdrQVirVbspUdH9/f4qX3MUQERVyUwONXkZOSo/tx/Mkb1uK6emxpotcWb
        UYnn3lTDdg10oaU6qesKc+uoqAzGPAg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637220687;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YXHWFxXvwHXrG+llI4tPpUmGY4L8ryaGLtJVyNvcgPY=;
        b=rfpiWRCJsED5ArHuIk/AFW0po2Opw6Q6fMbnVVSbNrNETLPA+uBRn2mRYiFT5ilrrf3KTV
        /oRjRlOlFmtMWJCA==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 575B0A3B84;
        Thu, 18 Nov 2021 07:31:27 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 05/19] mxser: clean up tx handling in mxser_transmit_chars()
Date:   Thu, 18 Nov 2021 08:31:11 +0100
Message-Id: <20211118073125.12283-6-jslaby@suse.cz>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211118073125.12283-1-jslaby@suse.cz>
References: <20211118073125.12283-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The port->icount.tx is handled in a too complicated manner. Instead of
remembering the original count and subtracting the new one from it,
simply increase tx for each character in the loop. No need for cnt
variable then.

Change also the "X = X & Y" assignment to simpler "X &= Y".

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/mxser.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/mxser.c b/drivers/tty/mxser.c
index 3d5c20e31836..eb5fb4fb2aef 100644
--- a/drivers/tty/mxser.c
+++ b/drivers/tty/mxser.c
@@ -1622,7 +1622,7 @@ static u8 mxser_receive_chars(struct tty_struct *tty,
 
 static void mxser_transmit_chars(struct tty_struct *tty, struct mxser_port *port)
 {
-	int count, cnt;
+	int count;
 
 	if (port->x_char) {
 		outb(port->x_char, port->ioaddr + UART_TX);
@@ -1640,18 +1640,16 @@ static void mxser_transmit_chars(struct tty_struct *tty, struct mxser_port *port
 		return;
 	}
 
-	cnt = port->xmit_cnt;
 	count = port->xmit_fifo_size;
 	do {
 		outb(port->port.xmit_buf[port->xmit_tail++],
 			port->ioaddr + UART_TX);
-		port->xmit_tail = port->xmit_tail & (SERIAL_XMIT_SIZE - 1);
+		port->xmit_tail &= SERIAL_XMIT_SIZE - 1;
+		port->icount.tx++;
 		if (!--port->xmit_cnt)
 			break;
 	} while (--count > 0);
 
-	port->icount.tx += (cnt - port->xmit_cnt);
-
 	if (port->xmit_cnt < WAKEUP_CHARS)
 		tty_wakeup(tty);
 
-- 
2.33.1

