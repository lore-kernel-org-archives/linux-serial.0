From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH 03/25] serial/imx: make imx_port.devdata member point to const data
Date: Mon, 23 Jul 2012 11:13:08 +0200
Message-ID: <1343034810-3386-4-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1343034810-3386-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:35876 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751582Ab2GWJOF (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 23 Jul 2012 05:14:05 -0400
In-Reply-To: <1343034810-3386-1-git-send-email-u.kleine-koenig@pengutronix.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>, Arnd Bergmann <arnd@arndb.de>, Rob Herring <rob.herring@calxeda.com>, Alan Cox <alan@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org

This prepares *of_device_id.data becoming const. Without this change th=
e
following warning would occur:

	drivers/tty/serial/imx.c: In function 'serial_imx_probe_dt':
	drivers/tty/serial/imx.c:1430:17: warning: assignment discards 'const'=
 qualifier from pointer target type [enabled by default]

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
---
 drivers/tty/serial/imx.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 4ef7473..0af4eec 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -207,7 +207,7 @@ struct imx_port {
 	unsigned short		trcv_delay; /* transceiver delay */
 	struct clk		*clk_ipg;
 	struct clk		*clk_per;
-	struct imx_uart_data	*devdata;
+	const struct imx_uart_data *devdata;
 };
=20
 struct imx_port_ucrs {
--=20
1.7.10.4

--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
