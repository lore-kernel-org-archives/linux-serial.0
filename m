Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDAA1C433F5
	for <linux-serial@archiver.kernel.org>; Thu, 18 Nov 2021 07:31:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7802617E3
	for <linux-serial@archiver.kernel.org>; Thu, 18 Nov 2021 07:31:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243940AbhKRHet (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 18 Nov 2021 02:34:49 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:52184 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243869AbhKRHea (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 18 Nov 2021 02:34:30 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id C3CF31FD3C;
        Thu, 18 Nov 2021 07:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637220689; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9+QZghgScWu28WLyT3PeJz/diGw34Qb4qYFQS/44/fw=;
        b=q2yqsRA8cRGV5YEDFx0S06c5EmvssJt1O8BJEOejQhB0//+Hxg/Cy/UuTdDHztNYXVqbkS
        sYNIABWF8ePnbxI4YQwA7F7ATQIV68gi2/ADT9Jc3gXvm5/s/RBpjjQKxxWV+2FwgfUK9e
        YUHSRWrnJiTkSFkqwpYpwYEVbebUUPc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637220689;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9+QZghgScWu28WLyT3PeJz/diGw34Qb4qYFQS/44/fw=;
        b=vGDbKB+lpuC7IYSBz3S78hX4mSlBIZTEYyQ/gNlOTUNi131m7eD9Py1pXucX/Q93vEKb1p
        frAyV0+9EwqTyuAw==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 9E285A3B83;
        Thu, 18 Nov 2021 07:31:29 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 16/19] mxser: increase buf_overrun if tty_insert_flip_char() fails
Date:   Thu, 18 Nov 2021 08:31:22 +0100
Message-Id: <20211118073125.12283-17-jslaby@suse.cz>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211118073125.12283-1-jslaby@suse.cz>
References: <20211118073125.12283-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

mxser doesn't increase port->icount.buf_overrun at all. Do so if overrun
happens, so that it can be read from the stats.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/mxser.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/mxser.c b/drivers/tty/mxser.c
index 10862d4bb885..65ea4baee5eb 100644
--- a/drivers/tty/mxser.c
+++ b/drivers/tty/mxser.c
@@ -1507,7 +1507,8 @@ static bool mxser_receive_chars_new(struct mxser_port *port, u8 status)
 
 	while (gdl--) {
 		u8 ch = inb(port->ioaddr + UART_RX);
-		tty_insert_flip_char(&port->port, ch, 0);
+		if (!tty_insert_flip_char(&port->port, ch, 0))
+			port->icount.buf_overrun++;
 	}
 
 	return true;
@@ -1553,8 +1554,10 @@ static u8 mxser_receive_chars_old(struct tty_struct *tty,
 					port->icount.overrun++;
 				}
 			}
-			if (!tty_insert_flip_char(&port->port, ch, flag))
+			if (!tty_insert_flip_char(&port->port, ch, flag)) {
+				port->icount.buf_overrun++;
 				break;
+			}
 		}
 
 		if (hwid)
-- 
2.33.1

