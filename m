From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH] serial/imx: make devdata member point to const data
Date: Mon, 21 May 2012 21:57:39 +0200
Message-ID: <1337630259-9510-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1335171381-24869-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:36419 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756333Ab2EUT5s (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 21 May 2012 15:57:48 -0400
In-Reply-To: <1335171381-24869-1-git-send-email-u.kleine-koenig@pengutronix.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: kernel@pengutronix.de, linux-serial@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, Arnd Bergmann <arnd@arndb.de>

This is only cosmetic for now. In case that

	http://mid.gmane.org/1335171381-24869-1-git-send-email-u.kleine-koenig=
@pengutronix.de

will be applied, it fixes a warning

	drivers/tty/serial/imx.c: In function 'serial_imx_probe_dt':
	drivers/tty/serial/imx.c:1430:17: warning: assignment discards 'const'=
 qualifier from pointer target type [enabled by default]

though.

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
---
 drivers/tty/serial/imx.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index e7fecee..d409bbb 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -205,7 +205,7 @@ struct imx_port {
 	unsigned int		irda_inv_tx:1;
 	unsigned short		trcv_delay; /* transceiver delay */
 	struct clk		*clk;
-	struct imx_uart_data	*devdata;
+	const struct imx_uart_data *devdata;
 };
=20
 struct imx_port_ucrs {
--=20
1.7.10

--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
