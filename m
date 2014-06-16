From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH tty-next 10/22] char: synclink: Remove WARN_ON for bad port count
Date: Mon, 16 Jun 2014 09:17:07 -0400
Message-ID: <1402924639-5164-11-git-send-email-peter@hurleysoftware.com>
References: <1402924639-5164-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout32.mail01.mtsvc.net ([216.70.64.70]:50404 "EHLO
	n23.mail01.mtsvc.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752571AbaFPNXY (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 16 Jun 2014 09:23:24 -0400
In-Reply-To: <1402924639-5164-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Peter Hurley <peter@hurleysoftware.com>

tty_port_close_start() already validates the port counts and issues
a diagnostic if validation fails.

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/char/pcmcia/synclink_cs.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/char/pcmcia/synclink_cs.c b/drivers/char/pcmcia/synclink_cs.c
index a63970f..0ea9986 100644
--- a/drivers/char/pcmcia/synclink_cs.c
+++ b/drivers/char/pcmcia/synclink_cs.c
@@ -2347,8 +2347,6 @@ static void mgslpc_close(struct tty_struct *tty, struct file * filp)
 		printk("%s(%d):mgslpc_close(%s) entry, count=%d\n",
 			 __FILE__, __LINE__, info->device_name, port->count);
 
-	WARN_ON(!port->count);
-
 	if (tty_port_close_start(port, tty, filp) == 0)
 		goto cleanup;
 
-- 
2.0.0

