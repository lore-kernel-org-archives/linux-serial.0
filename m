Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB69BC07E9A
	for <linux-serial@archiver.kernel.org>; Wed, 14 Jul 2021 09:13:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0ACF613AA
	for <linux-serial@archiver.kernel.org>; Wed, 14 Jul 2021 09:13:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238671AbhGNJQM (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 14 Jul 2021 05:16:12 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:57904 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238625AbhGNJQI (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 14 Jul 2021 05:16:08 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 79F8B2059C;
        Wed, 14 Jul 2021 09:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1626253996; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VDmRR1x7Z/CmdMonI5OFpzbCnO0UTbu5cj4yX3PIg6E=;
        b=bNyHV+t/zIDzP09orgxmeILIXV1nJp1E6lnDLmR4oBxPBl3YQjwhM5UUVKovcC1kQIJ9hb
        5UcrMwe111fxpebtyD+yLIeT4o43v1jmqetDBZQ2IlglDAO7hxvtR0Xo6+3Zbb3TOJjsTP
        qYo1RWU9VZzxUwE7u5GyG7mq9AU04lI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1626253996;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VDmRR1x7Z/CmdMonI5OFpzbCnO0UTbu5cj4yX3PIg6E=;
        b=zHKWqwY5q16WaLNIJrlUM5+itqjNyUFluM0oD6I6Eq5x2CbTMuTe9H7f0SudoC+eLcc/0r
        5FNyOtSjxDeNCsDQ==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 523CAA3B8A;
        Wed, 14 Jul 2021 09:13:16 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 05/11] amiserial: simplify rs_open
Date:   Wed, 14 Jul 2021 11:13:08 +0200
Message-Id: <20210714091314.8292-5-jslaby@suse.cz>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210714091314.8292-1-jslaby@suse.cz>
References: <20210714091314.8292-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tty->port is already set when rs_open is called given we linked it by
tty_port_link_device(). If it wasn't, the tty layer would WARN loudly.
So it's pointless to set it in rs_open. Instead, use the value in
tty->port to find out the serial_state (info).

It's a fallout of commit b19e2ca77ee4 (TTY: use tty_port_link_device)
which added tty_port_link_device here, but omitted to remove the
tty->port assignment from rs_open.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/amiserial.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/amiserial.c b/drivers/tty/amiserial.c
index 0962b197e676..68f8cee389ec 100644
--- a/drivers/tty/amiserial.c
+++ b/drivers/tty/amiserial.c
@@ -1361,14 +1361,14 @@ static void rs_hangup(struct tty_struct *tty)
  */
 static int rs_open(struct tty_struct *tty, struct file * filp)
 {
-	struct serial_state *info = rs_table + tty->index;
-	struct tty_port *port = &info->tport;
+	struct tty_port *port = tty->port;
+	struct serial_state *info = container_of(port, struct serial_state,
+			tport);
 	int retval;
 
 	port->count++;
 	port->tty = tty;
 	tty->driver_data = info;
-	tty->port = port;
 
 	retval = startup(tty, info);
 	if (retval) {
-- 
2.32.0

