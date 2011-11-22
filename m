From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH 1/2] serial/imx: propagate error of platform_driver_register in init routine
Date: Tue, 22 Nov 2011 14:22:55 +0100
Message-ID: <1321968177-16039-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:43000 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751472Ab1KVNXc (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 22 Nov 2011 08:23:32 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: kernel@pengutronix.de, linux-serial@vger.kernel.org
Cc: Alan Cox <alan@linux.intel.com>

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
---
 drivers/tty/serial/imx.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 163fc90..962cafa 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -1476,7 +1476,7 @@ static int __init imx_serial_init(void)
 	if (ret !=3D 0)
 		uart_unregister_driver(&imx_reg);
=20
-	return 0;
+	return ret;
 }
=20
 static void __exit imx_serial_exit(void)
--=20
1.7.7.3

--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
