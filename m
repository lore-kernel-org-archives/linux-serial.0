From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] tty: serial: men_z135_uart: Add terminating entry for
 men_z135_ids
Date: Mon, 10 Nov 2014 16:05:03 +0800
Message-ID: <1415606703.23695.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pd0-f181.google.com ([209.85.192.181]:55036 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751807AbaKJIFH (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 10 Nov 2014 03:05:07 -0500
Received: by mail-pd0-f181.google.com with SMTP id y10so7275528pdj.26
        for <linux-serial@vger.kernel.org>; Mon, 10 Nov 2014 00:05:07 -0800 (PST)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>
Cc: Johannes Thumshirn <johannes.thumshirn@men.de>, linux-serial@vger.kernel.org

The mcb_device_id table is supposed to be zero-terminated.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/tty/serial/men_z135_uart.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/men_z135_uart.c b/drivers/tty/serial/men_z135_uart.c
index 30e9e60..517cd07 100644
--- a/drivers/tty/serial/men_z135_uart.c
+++ b/drivers/tty/serial/men_z135_uart.c
@@ -809,6 +809,7 @@ static void men_z135_remove(struct mcb_device *mdev)
 
 static const struct mcb_device_id men_z135_ids[] = {
 	{ .device = 0x87 },
+	{ }
 };
 MODULE_DEVICE_TABLE(mcb, men_z135_ids);
 
-- 
1.9.1



