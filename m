Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04C41C43381
	for <linux-serial@archiver.kernel.org>; Wed, 23 Dec 2020 09:39:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C62BC22475
	for <linux-serial@archiver.kernel.org>; Wed, 23 Dec 2020 09:39:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728242AbgLWJjg (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 23 Dec 2020 04:39:36 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:10997 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727014AbgLWJja (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 23 Dec 2020 04:39:30 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4D17SP6pvjz9v1yT;
        Wed, 23 Dec 2020 10:38:45 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id aaWSSNKmWPJn; Wed, 23 Dec 2020 10:38:45 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4D17SP5sG6z9v1yS;
        Wed, 23 Dec 2020 10:38:45 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id E9E758B81D;
        Wed, 23 Dec 2020 10:38:46 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id vBDlujpSTbIq; Wed, 23 Dec 2020 10:38:46 +0100 (CET)
Received: from localhost.localdomain (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 96E7A8B75F;
        Wed, 23 Dec 2020 10:38:46 +0100 (CET)
Received: by localhost.localdomain (Postfix, from userid 0)
        id 526F96696F; Wed, 23 Dec 2020 09:38:46 +0000 (UTC)
Message-Id: <e4471bf81089252470efb3eed735d71a5b32adbd.1608716197.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH] tty: serial: cpm_uart: Add udbg support for enabling xmon
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Wed, 23 Dec 2020 09:38:46 +0000 (UTC)
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

In order to use xmon with powerpc 8xx, the serial driver
must provide udbg_putc() and udpb_getc().

Provide them via cpm_put_poll_char() and cpm_get_poll_char().

This requires CONFIG_CONSOLE_POLL.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 drivers/tty/serial/cpm_uart/cpm_uart_core.c | 40 ++++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/cpm_uart/cpm_uart_core.c b/drivers/tty/serial/cpm_uart/cpm_uart_core.c
index ba14ec5b9bc4..2920b9b602b3 100644
--- a/drivers/tty/serial/cpm_uart/cpm_uart_core.c
+++ b/drivers/tty/serial/cpm_uart/cpm_uart_core.c
@@ -1145,6 +1145,32 @@ static void cpm_put_poll_char(struct uart_port *port,
 	ch[0] = (char)c;
 	cpm_uart_early_write(pinfo, ch, 1, false);
 }
+
+static struct uart_port *udbg_port;
+
+static void udbg_cpm_putc(char c)
+{
+	if (c == '\n')
+		cpm_put_poll_char(udbg_port, '\r');
+	cpm_put_poll_char(udbg_port, c);
+}
+
+static int udbg_cpm_getc_poll(void)
+{
+	int c = cpm_get_poll_char(udbg_port);
+
+	return c == NO_POLL_CHAR ? -1 : c;
+}
+
+static int udbg_cpm_getc(void)
+{
+	int c;
+
+	while ((c = udbg_cpm_getc_poll()) == -1)
+		cpu_relax();
+	return c;
+}
+
 #endif /* CONFIG_CONSOLE_POLL */
 
 static const struct uart_ops cpm_uart_pops = {
@@ -1251,7 +1277,10 @@ static int cpm_uart_init_port(struct device_node *np,
 		pinfo->gpios[i] = NULL;
 
 #ifdef CONFIG_PPC_EARLY_DEBUG_CPM
-	udbg_putc = NULL;
+#ifdef CONFIG_CONSOLE_POLL
+	if (!udbg_port)
+#endif
+		udbg_putc = NULL;
 #endif
 
 	return cpm_uart_request_port(&pinfo->port);
@@ -1370,6 +1399,15 @@ static int __init cpm_uart_console_setup(struct console *co, char *options)
 	uart_set_options(port, co, baud, parity, bits, flow);
 	cpm_line_cr_cmd(pinfo, CPM_CR_RESTART_TX);
 
+#ifdef CONFIG_CONSOLE_POLL
+	if (!udbg_port) {
+		udbg_port = &pinfo->port;
+		udbg_putc = udbg_cpm_putc;
+		udbg_getc = udbg_cpm_getc;
+		udbg_getc_poll = udbg_cpm_getc_poll;
+	}
+#endif
+
 	return 0;
 }
 
-- 
2.25.0

