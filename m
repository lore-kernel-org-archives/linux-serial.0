From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] serial: mxs-auart: Index is unsigned
Date: Mon,  7 Jan 2013 23:11:06 -0200
Message-ID: <1357607466-20358-1-git-send-email-festevam@gmail.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-yh0-f54.google.com ([209.85.213.54]:63950 "EHLO
	mail-yh0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753805Ab3AHBRd (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 7 Jan 2013 20:17:33 -0500
Received: by mail-yh0-f54.google.com with SMTP id i57so1535961yha.27
        for <linux-serial@vger.kernel.org>; Mon, 07 Jan 2013 17:17:32 -0800 (PST)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: alan@linux.intel.com
Cc: shawn.guo@linaro.org, linux-serial@vger.kernel.org, marex@denx.de, Fabio Estevam <fabio.estevam@freescale.com>

From: Fabio Estevam <fabio.estevam@freescale.com>>

Fix the following warning when building with W=1 option:

drivers/tty/serial/mxs-auart.c: In function 'mxs_auart_tx_chars':
drivers/tty/serial/mxs-auart.c:272:10: warning: comparison between signed and unsigned integer expressions [-Wsign-compare]

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 drivers/tty/serial/mxs-auart.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-auart.c
index 6db23b0..537e0af 100644
--- a/drivers/tty/serial/mxs-auart.c
+++ b/drivers/tty/serial/mxs-auart.c
@@ -253,7 +253,7 @@ static void mxs_auart_tx_chars(struct mxs_auart_port *s)
 	struct circ_buf *xmit = &s->port.state->xmit;
 
 	if (auart_dma_enabled(s)) {
-		int i = 0;
+		u32 i = 0;
 		int size;
 		void *buffer = s->tx_dma_buf;
 
-- 
1.7.9.5

