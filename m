From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH] serial: clps711x: drop needless devm_clk_put
Date: Mon, 23 Sep 2013 17:53:32 +0200
Message-ID: <1379951612-2471-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1379951159-8294-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:41813 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752776Ab3IWPxm (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 23 Sep 2013 11:53:42 -0400
In-Reply-To: <1379951159-8294-1-git-send-email-u.kleine-koenig@pengutronix.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>
Cc: linux-serial@vger.kernel.org, kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org, Alexander Shiyan <shc_work@mail.ru>, Russell King <linux@arm.linux.org.uk>

The nice thing about devm_* is that the driver doesn't need to free the
resources but the driver core takes care about that.

These calls were introduced in commit c08f015 (serial: clps711x: Using
CPU clock subsystem for getting base UART speed).

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
---
Cc: Alexander Shiyan <shc_work@mail.ru>
Cc: Russell King <linux@arm.linux.org.uk>
---
 drivers/tty/serial/clps711x.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/tty/serial/clps711x.c b/drivers/tty/serial/clps711=
x.c
index 7e4e408..8d0b994 100644
--- a/drivers/tty/serial/clps711x.c
+++ b/drivers/tty/serial/clps711x.c
@@ -459,7 +459,6 @@ static int uart_clps711x_probe(struct platform_devi=
ce *pdev)
 	ret =3D uart_register_driver(&s->uart);
 	if (ret) {
 		dev_err(&pdev->dev, "Registering UART driver failed\n");
-		devm_clk_put(&pdev->dev, s->uart_clk);
 		return ret;
 	}
=20
@@ -487,7 +486,6 @@ static int uart_clps711x_remove(struct platform_dev=
ice *pdev)
 	for (i =3D 0; i < UART_CLPS711X_NR; i++)
 		uart_remove_one_port(&s->uart, &s->port[i]);
=20
-	devm_clk_put(&pdev->dev, s->uart_clk);
 	uart_unregister_driver(&s->uart);
=20
 	return 0;
--=20
1.8.4.rc3

--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
