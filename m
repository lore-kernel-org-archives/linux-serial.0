From: Huang Shijie <shijie8@gmail.com>
Subject: [PATCH v3 2/3] serial: mxs: remove the MXS_AUART_DMA_CONFIG
Date: Sat,  3 Aug 2013 10:09:15 -0400
Message-ID: <1375538956-15862-3-git-send-email-shijie8@gmail.com>
References: <1375538956-15862-1-git-send-email-shijie8@gmail.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pb0-f48.google.com ([209.85.160.48]:58531 "EHLO
	mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752785Ab3HCCFU (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 2 Aug 2013 22:05:20 -0400
Received: by mail-pb0-f48.google.com with SMTP id ma3so1299047pbc.21
        for <linux-serial@vger.kernel.org>; Fri, 02 Aug 2013 19:05:19 -0700 (PDT)
In-Reply-To: <1375538956-15862-1-git-send-email-shijie8@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org, shawn.guo@linaro.org, linux-arm-kernel@lists.infradead.org, u.kleine-koenig@pengutronix.de, Huang Shijie <shijie8@gmail.com>

The MXS_AUART_DMA_CONFIG is originally used to check if the DT node
is configured with the DMA property.

But now, the MXS_AUART_DMA_CONFIG is set unconditionally in the
serial_mxs_probe_dt(), so the check in the mxs_auart_settermios() is
not necessary anymore. This patch removes this macro.

Signed-off-by: Huang Shijie <shijie8@gmail.com>
---
 drivers/tty/serial/mxs-auart.c |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-auart.c
index eac7b58..10e9d70 100644
--- a/drivers/tty/serial/mxs-auart.c
+++ b/drivers/tty/serial/mxs-auart.c
@@ -133,7 +133,6 @@ enum mxs_auart_type {
 struct mxs_auart_port {
 	struct uart_port port;
 
-#define MXS_AUART_DMA_CONFIG	0x1
 #define MXS_AUART_DMA_ENABLED	0x2
 #define MXS_AUART_DMA_TX_SYNC	2  /* bit 2 */
 #define MXS_AUART_DMA_RX_READY	3  /* bit 3 */
@@ -640,7 +639,7 @@ static void mxs_auart_settermios(struct uart_port *u,
 		 * we can only implement the DMA support for auart
 		 * in mx28.
 		 */
-		if (is_imx28_auart(s) && (s->flags & MXS_AUART_DMA_CONFIG)
+		if (is_imx28_auart(s)
 				&& test_bit(MXS_AUART_RTSCTS, &s->flags)) {
 			if (!mxs_auart_dma_init(s))
 				/* enable DMA tranfer */
@@ -1009,8 +1008,6 @@ static int serial_mxs_probe_dt(struct mxs_auart_port *s,
 	}
 	s->port.line = ret;
 
-	s->flags |= MXS_AUART_DMA_CONFIG;
-
 	if (of_get_property(np, "fsl,uart-has-rtscts", NULL))
 		set_bit(MXS_AUART_RTSCTS, &s->flags);
 
-- 
1.7.4.4

