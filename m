From: Mike Frysinger <vapier@gentoo.org>
Subject: [PATCH 3/4] serial: bfin_5xx: disable CON_PRINTBUFFER for consoles
Date: Wed, 27 Oct 2010 04:16:49 -0400
Message-ID: <1288167410-31554-4-git-send-email-vapier@gentoo.org>
References: <1288167410-31554-1-git-send-email-vapier@gentoo.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp.gentoo.org ([140.211.166.183]:53078 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758797Ab0J0IQo (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 27 Oct 2010 04:16:44 -0400
In-Reply-To: <1288167410-31554-1-git-send-email-vapier@gentoo.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: uclinux-dist-devel@blackfin.uclinux.org, Sonic Zhang <sonic.zhang@analog.com>

From: Sonic Zhang <sonic.zhang@analog.com>

If we are using early serial, don't let the normal console rewind
the log buffer, since that causes things to be printed multiple times.

Signed-off-by: Sonic Zhang <sonic.zhang@analog.com>
Signed-off-by: Mike Frysinger <vapier@gentoo.org>
---
 drivers/serial/bfin_5xx.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/drivers/serial/bfin_5xx.c b/drivers/serial/bfin_5xx.c
index 01315a2..c6774de 100644
--- a/drivers/serial/bfin_5xx.c
+++ b/drivers/serial/bfin_5xx.c
@@ -1326,6 +1326,14 @@ struct console __init *bfin_earlyserial_init(unsigned int port,
 	struct bfin_serial_port *uart;
 	struct ktermios t;
 
+#ifdef CONFIG_SERIAL_BFIN_CONSOLE
+	/*
+	 * If we are using early serial, don't let the normal console rewind
+	 * log buffer, since that causes things to be printed multiple times
+	 */
+	bfin_serial_console.flags &= ~CON_PRINTBUFFER;
+#endif
+
 	if (port == -1 || port >= nr_active_ports)
 		port = 0;
 	bfin_serial_init_ports();
-- 
1.7.3.2

