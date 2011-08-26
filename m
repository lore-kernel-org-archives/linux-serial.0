From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 05/12] atmel_serial: fix atmel_default_console_device
Date: Fri, 26 Aug 2011 13:58:14 -0700
Message-ID: <1314392301-25140-5-git-send-email-gregkh@suse.de>
References: <20110826191143.GC5557@kroah.com>
 <1314392301-25140-1-git-send-email-gregkh@suse.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:37776 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753646Ab1HZU6v (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 26 Aug 2011 16:58:51 -0400
In-Reply-To: <1314392301-25140-1-git-send-email-gregkh@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: "Voss, Nikolaus" <N.Voss@weinmann.de>, Nikolaus Voss <n.voss@weinmann.de>, Greg Kroah-Hartman <gregkh@suse.de>

From: "Voss, Nikolaus" <N.Voss@weinmann.de>

reflect new static uart platform ids introduced by patch
http://article.gmane.org/gmane.linux.kernel/1126105

Signed-off-by: Nikolaus Voss <n.voss@weinmann.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/tty/serial/atmel_serial.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index af9b781..b922f5d 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -1609,9 +1609,11 @@ static struct console atmel_console = {
 static int __init atmel_console_init(void)
 {
 	if (atmel_default_console_device) {
-		add_preferred_console(ATMEL_DEVICENAME,
-				      atmel_default_console_device->id, NULL);
-		atmel_init_port(&atmel_ports[atmel_default_console_device->id],
+		struct atmel_uart_data *pdata =
+			atmel_default_console_device->dev.platform_data;
+
+		add_preferred_console(ATMEL_DEVICENAME, pdata->num, NULL);
+		atmel_init_port(&atmel_ports[pdata->num],
 				atmel_default_console_device);
 		register_console(&atmel_console);
 	}
-- 
1.7.6.1

