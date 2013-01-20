From: Chen Gang <gang.chen@asianux.com>
Subject: [PATCH] drivers/tty/serial/8250: use strlcpy instead of strcpy
Date: Sun, 20 Jan 2013 17:36:02 +0800
Message-ID: <50FBBA82.1050307@asianux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from intranet.asianux.com ([58.214.24.6]:24204 "EHLO
	intranet.asianux.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750930Ab3ATJfP (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 20 Jan 2013 04:35:15 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
Cc: Greg KH <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org


  The fields must be null-terminated, or next printk for %s, will cause issue.

Signed-off-by: Chen Gang <gang.chen@asianux.com>
---
 drivers/tty/serial/8250/8250_early.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_early.c b/drivers/tty/serial/8250/8250_early.c
index f53a7db..721904f 100644
--- a/drivers/tty/serial/8250/8250_early.c
+++ b/drivers/tty/serial/8250/8250_early.c
@@ -194,7 +194,7 @@ static int __init parse_options(struct early_serial8250_device *device,
 		options++;
 		device->baud = simple_strtoul(options, NULL, 0);
 		length = min(strcspn(options, " "), sizeof(device->options));
-		strncpy(device->options, options, length);
+		strlcpy(device->options, options, length);
 	} else {
 		device->baud = probe_baud(port);
 		snprintf(device->options, sizeof(device->options), "%u",
-- 
1.7.10.4
