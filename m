Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69E6CC43217
	for <linux-serial@archiver.kernel.org>; Mon,  7 Nov 2022 14:17:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231993AbiKGOQ6 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 7 Nov 2022 09:16:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232222AbiKGOQy (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 7 Nov 2022 09:16:54 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE4911D0F7;
        Mon,  7 Nov 2022 06:16:53 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1667830612;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rIFVvGo20s9m3a2ORQZJ6diZh72O0KdKN/vykqpOG6M=;
        b=MZJB5lX42WcNqfQf/8Uy4aTmZOi552MX2XYZ5hG9OlguJgac67mF5BEXukX1d+qbynQc/L
        P13tXHiAAu9wRwaCfqN6TyjkrzUUkQNJA/l3DU53O6LkfVv5tI+qVxI2f8nZUIPn1b5S/E
        O3beP8Dac2x2r2ouaorlV9viccM6cVWYvKhliiBWguW38a07M6JzMV/CO5GqoyXLcp/hKW
        jHXOW3VMeEi4kzZGi3VPUxBDKxLeKLxdBzyFBTIAN8V4rNN9ZDGsAaQIH32Ozl5KcV6av/
        7DTDlBs1hTid01SHsrwLPYbWLGGbdYgc/xSMf9EqSBy9atMNjA4uSA1+zIlH3A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1667830612;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rIFVvGo20s9m3a2ORQZJ6diZh72O0KdKN/vykqpOG6M=;
        b=ALG9eKOl3s7Xt0eEnwNoL/F4GKWQMH6+qAGkok3zgVPzcLXBeHOOBayw+8bjy9jYTFLvj/
        pW3IJBvcGaP2m1CA==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org
Subject: [PATCH printk v3 27/40] tty: serial: earlycon: use console_is_registered()
Date:   Mon,  7 Nov 2022 15:22:25 +0106
Message-Id: <20221107141638.3790965-28-john.ogness@linutronix.de>
In-Reply-To: <20221107141638.3790965-1-john.ogness@linutronix.de>
References: <20221107141638.3790965-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

It is not reliable to check for CON_ENABLED in order to identify if a
console is registered. Use console_is_registered() instead.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 drivers/tty/serial/earlycon.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/earlycon.c b/drivers/tty/serial/earlycon.c
index a5f380584cda..4f6e9bf57169 100644
--- a/drivers/tty/serial/earlycon.c
+++ b/drivers/tty/serial/earlycon.c
@@ -181,7 +181,7 @@ int __init setup_earlycon(char *buf)
 	if (!buf || !buf[0])
 		return -EINVAL;
 
-	if (early_con.flags & CON_ENABLED)
+	if (console_is_registered(&early_con))
 		return -EALREADY;
 
 again:
@@ -253,7 +253,7 @@ int __init of_setup_earlycon(const struct earlycon_id *match,
 	bool big_endian;
 	u64 addr;
 
-	if (early_con.flags & CON_ENABLED)
+	if (console_is_registered(&early_con))
 		return -EALREADY;
 
 	spin_lock_init(&port->lock);
-- 
2.30.2

