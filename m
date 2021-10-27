Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B5A4C433F5
	for <linux-serial@archiver.kernel.org>; Wed, 27 Oct 2021 10:15:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EC9D60F02
	for <linux-serial@archiver.kernel.org>; Wed, 27 Oct 2021 10:15:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241338AbhJ0KRo (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 27 Oct 2021 06:17:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241322AbhJ0KRo (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 27 Oct 2021 06:17:44 -0400
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [IPv6:2a02:1800:120:4::f00:14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5503C061767
        for <linux-serial@vger.kernel.org>; Wed, 27 Oct 2021 03:15:18 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed20:441:6c1a:bc30:46e])
        by xavier.telenet-ops.be with bizsmtp
        id AyFF260052hfXWm01yFFKF; Wed, 27 Oct 2021 12:15:15 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1mffiU-008HRd-Op; Wed, 27 Oct 2021 11:59:30 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1mfdkV-00DitM-UB; Wed, 27 Oct 2021 09:53:27 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-serial@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] serial: cpm_uart: Protect udbg definitions by CONFIG_SERIAL_CPM_CONSOLE
Date:   Wed, 27 Oct 2021 09:53:26 +0200
Message-Id: <20211027075326.3270785-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

If CONFIG_CONSOLE_POLL=y, and CONFIG_SERIAL_CPM=m (hence
CONFIG_SERIAL_CPM_CONSOLE=n):

    drivers/tty/serial/cpm_uart/cpm_uart_core.c:1109:12: warning: ‘udbg_cpm_getc’ defined but not used [-Wunused-function]
     1109 | static int udbg_cpm_getc(void)
	  |            ^~~~~~~~~~~~~
    drivers/tty/serial/cpm_uart/cpm_uart_core.c:1095:13: warning: ‘udbg_cpm_putc’ defined but not used [-Wunused-function]
     1095 | static void udbg_cpm_putc(char c)
	  |             ^~~~~~~~~~~~~

Fix this by making the udbg definitions depend on
CONFIG_SERIAL_CPM_CONSOLE, in addition to CONFIG_CONSOLE_POLL.

Fixes: a60526097f42eb98 ("tty: serial: cpm_uart: Add udbg support for enabling xmon")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
One more casualty of CONFIG_WERROR=y.
http://kisskb.ellerman.id.au/kisskb/buildresult/14652935/
---
 drivers/tty/serial/cpm_uart/cpm_uart_core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/serial/cpm_uart/cpm_uart_core.c b/drivers/tty/serial/cpm_uart/cpm_uart_core.c
index c719aa2b18328321..d6d3db9c3b1f83ab 100644
--- a/drivers/tty/serial/cpm_uart/cpm_uart_core.c
+++ b/drivers/tty/serial/cpm_uart/cpm_uart_core.c
@@ -1090,6 +1090,7 @@ static void cpm_put_poll_char(struct uart_port *port,
 	cpm_uart_early_write(pinfo, ch, 1, false);
 }
 
+#ifdef CONFIG_SERIAL_CPM_CONSOLE
 static struct uart_port *udbg_port;
 
 static void udbg_cpm_putc(char c)
@@ -1114,6 +1115,7 @@ static int udbg_cpm_getc(void)
 		cpu_relax();
 	return c;
 }
+#endif /* CONFIG_SERIAL_CPM_CONSOLE */
 
 #endif /* CONFIG_CONSOLE_POLL */
 
-- 
2.25.1

