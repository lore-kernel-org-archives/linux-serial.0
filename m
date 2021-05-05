Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEB8FC43461
	for <linux-serial@archiver.kernel.org>; Wed,  5 May 2021 09:19:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB348613F0
	for <linux-serial@archiver.kernel.org>; Wed,  5 May 2021 09:19:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232331AbhEEJUt (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 5 May 2021 05:20:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:41394 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232466AbhEEJUh (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 5 May 2021 05:20:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B6B7EB27A;
        Wed,  5 May 2021 09:19:39 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>, Joel Stanley <joel@jms.id.au>
Subject: [PATCH 24/35] tty: make tty_buffer_space_avail return uint
Date:   Wed,  5 May 2021 11:19:17 +0200
Message-Id: <20210505091928.22010-25-jslaby@suse.cz>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210505091928.22010-1-jslaby@suse.cz>
References: <20210505091928.22010-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tty_buffer_space_avail returns values >= 0, so make it clear by the
return type.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Joel Stanley <joel@jms.id.au>
---
 drivers/tty/serial/8250/8250_aspeed_vuart.c | 4 ++--
 drivers/tty/tty_buffer.c                    | 2 +-
 include/linux/tty_flip.h                    | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_aspeed_vuart.c b/drivers/tty/serial/8250/8250_aspeed_vuart.c
index 61550f24a2d3..92d9a6164dfa 100644
--- a/drivers/tty/serial/8250/8250_aspeed_vuart.c
+++ b/drivers/tty/serial/8250/8250_aspeed_vuart.c
@@ -320,7 +320,7 @@ static int aspeed_vuart_handle_irq(struct uart_port *port)
 {
 	struct uart_8250_port *up = up_to_u8250p(port);
 	unsigned int iir, lsr;
-	int space, count;
+	unsigned int space, count;
 
 	iir = serial_port_in(port, UART_IIR);
 
@@ -346,7 +346,7 @@ static int aspeed_vuart_handle_irq(struct uart_port *port)
 			}
 
 		} else {
-			count = min(space, 256);
+			count = min(space, 256U);
 
 			do {
 				serial8250_read_char(up, lsr);
diff --git a/drivers/tty/tty_buffer.c b/drivers/tty/tty_buffer.c
index 55b1f1711341..585a19f65284 100644
--- a/drivers/tty/tty_buffer.c
+++ b/drivers/tty/tty_buffer.c
@@ -88,7 +88,7 @@ EXPORT_SYMBOL_GPL(tty_buffer_unlock_exclusive);
  *	pre-allocate if memory guarantee is required).
  */
 
-int tty_buffer_space_avail(struct tty_port *port)
+unsigned int tty_buffer_space_avail(struct tty_port *port)
 {
 	int space = port->buf.mem_limit - atomic_read(&port->buf.mem_used);
 	return max(space, 0);
diff --git a/include/linux/tty_flip.h b/include/linux/tty_flip.h
index 767f62086bd9..d6729281ec50 100644
--- a/include/linux/tty_flip.h
+++ b/include/linux/tty_flip.h
@@ -3,7 +3,7 @@
 #define _LINUX_TTY_FLIP_H
 
 extern int tty_buffer_set_limit(struct tty_port *port, int limit);
-extern int tty_buffer_space_avail(struct tty_port *port);
+extern unsigned int tty_buffer_space_avail(struct tty_port *port);
 extern int tty_buffer_request_room(struct tty_port *port, size_t size);
 extern int tty_insert_flip_string_flags(struct tty_port *port,
 		const unsigned char *chars, const char *flags, size_t size);
-- 
2.31.1

