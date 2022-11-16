Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1289C433FE
	for <linux-serial@archiver.kernel.org>; Wed, 16 Nov 2022 16:23:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238534AbiKPQXR (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 16 Nov 2022 11:23:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234897AbiKPQWi (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 16 Nov 2022 11:22:38 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3FFA5800A;
        Wed, 16 Nov 2022 08:22:10 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668615729;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mrnamDANz6jBB9jzBVW9G8ct2/m0qCRJ/AQBo5wVT6Y=;
        b=IHfhXeIjsu1hLZtohnzmRyDQmIktHtCYtoLquUTX2WSs5AO+5oHUdvyoEj3rssbn/r0Y/n
        LMkEMBqml3FqzurxWRiZbvgQnknV+eWTnQhVjLO4dqmzTHdT6nEJ/dHdm5ueYtBLFKnVPG
        7np6nZtKtTBIMf2c1cwFYwYyJXAnKkmrvQZyEAr0GTCs9TTNGzYN0X64YR72T3shSCPxGM
        PBt+JjIrnMCiHi276+OsE946KngZDh4Ca/QFJt3t66u781zZfphAn6s3CglQk0EWgWzB4R
        /N6YP7kfixbkSrERtdxAiyQ8AkodcDy2N4VKRKd96wdm31dqJaNXmUvQIxGZBg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668615729;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mrnamDANz6jBB9jzBVW9G8ct2/m0qCRJ/AQBo5wVT6Y=;
        b=olP4GBMpkyeoYDHbACveIAi5zWc4NUMK1WYldtniy3N5RaKslutK2zK06oNEdudevtz8ET
        WYnWXIL4VwK4nqDQ==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org
Subject: [PATCH printk v5 27/40] tty: serial: pic32_uart: use console_is_registered()
Date:   Wed, 16 Nov 2022 17:27:39 +0106
Message-Id: <20221116162152.193147-28-john.ogness@linutronix.de>
In-Reply-To: <20221116162152.193147-1-john.ogness@linutronix.de>
References: <20221116162152.193147-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

It is not reliable to check for CON_ENABLED in order to identify if a
console is registered. Use console_is_registered() instead.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
 drivers/tty/serial/pic32_uart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/pic32_uart.c b/drivers/tty/serial/pic32_uart.c
index 1183b2a26539..c38754d593ca 100644
--- a/drivers/tty/serial/pic32_uart.c
+++ b/drivers/tty/serial/pic32_uart.c
@@ -843,7 +843,7 @@ console_initcall(pic32_console_init);
  */
 static int __init pic32_late_console_init(void)
 {
-	if (!(pic32_console.flags & CON_ENABLED))
+	if (!console_is_registered(&pic32_console))
 		register_console(&pic32_console);
 
 	return 0;
-- 
2.30.2

