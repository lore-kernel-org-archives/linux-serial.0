Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A088C433EF
	for <linux-serial@archiver.kernel.org>; Thu, 18 Nov 2021 07:31:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05FA661A3D
	for <linux-serial@archiver.kernel.org>; Thu, 18 Nov 2021 07:31:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243937AbhKRHet (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 18 Nov 2021 02:34:49 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:46394 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243867AbhKRHea (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 18 Nov 2021 02:34:30 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 8C076218B0;
        Thu, 18 Nov 2021 07:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637220689; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yN/tO29s6X69faiR3oNOok+bMgjwWHc5c99bC4Rp/g4=;
        b=ajrxleWpqRmXXW4pIIAIels/bpN2ATkvuOqVBE1/di0RT/+3JhUaOqtJAcQhcoILIJvg5n
        Ox7BUBGQ+/2KvmODWNfYzuOohKvutr31vMr4DZPX0yhTBdGzrGhc63RAnFQauuqQALvxMv
        mbalf57FJZzsgSCDwGUGrawv7poQ7mk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637220689;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yN/tO29s6X69faiR3oNOok+bMgjwWHc5c99bC4Rp/g4=;
        b=88zSsVNZsKz+/ron6n6VbJ6RGNCUSU0aFq3MY703z8vUeDdt89tOs/+7lg3YwihwdQuzXX
        1bXDpUAg5Fb1eDCQ==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 64FE8A3B84;
        Thu, 18 Nov 2021 07:31:29 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 15/19] mxser: remove tty parameter from mxser_receive_chars_new()
Date:   Thu, 18 Nov 2021 08:31:21 +0100
Message-Id: <20211118073125.12283-16-jslaby@suse.cz>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211118073125.12283-1-jslaby@suse.cz>
References: <20211118073125.12283-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

After the previous change (no plays with of tty->receive_room), the tty
parameter is unused.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/mxser.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/mxser.c b/drivers/tty/mxser.c
index 2359b4aa68af..10862d4bb885 100644
--- a/drivers/tty/mxser.c
+++ b/drivers/tty/mxser.c
@@ -1491,8 +1491,7 @@ static int mxser_rs_break(struct tty_struct *tty, int break_state)
 	return 0;
 }
 
-static bool mxser_receive_chars_new(struct tty_struct *tty,
-		struct mxser_port *port, u8 status)
+static bool mxser_receive_chars_new(struct mxser_port *port, u8 status)
 {
 	enum mxser_must_hwid hwid = port->board->must_hwid;
 	u8 gdl;
@@ -1570,7 +1569,7 @@ static u8 mxser_receive_chars_old(struct tty_struct *tty,
 static u8 mxser_receive_chars(struct tty_struct *tty,
 		struct mxser_port *port, u8 status)
 {
-	if (!mxser_receive_chars_new(tty, port, status))
+	if (!mxser_receive_chars_new(port, status))
 		status = mxser_receive_chars_old(tty, port, status);
 
 	tty_flip_buffer_push(&port->port);
-- 
2.33.1

