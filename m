From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 1/4] serial: pch_uart: Delete an error message for a failed
 memory allocation in dma_handle_tx()
Date: Fri, 8 Dec 2017 19:09:26 +0100
Message-ID: <2378ba53-4894-e532-7523-b578e42c8eb2@users.sourceforge.net>
References: <f8220e08-da4c-65d6-ecc7-9405cab6f375@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <f8220e08-da4c-65d6-ecc7-9405cab6f375@users.sourceforge.net>
Content-Language: en-GB
Sender: kernel-janitors-owner@vger.kernel.org
To: linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 8 Dec 2017 18:28:20 +0100

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/tty/serial/pch_uart.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/tty/serial/pch_uart.c b/drivers/tty/serial/pch_uart.c
index 760d5dd0aada..0fc72c491c9b 100644
--- a/drivers/tty/serial/pch_uart.c
+++ b/drivers/tty/serial/pch_uart.c
@@ -992,10 +992,8 @@ static unsigned int dma_handle_tx(struct eg20t_port *priv)
 	priv->tx_dma_use = 1;
 
 	priv->sg_tx_p = kzalloc(sizeof(struct scatterlist)*num, GFP_ATOMIC);
-	if (!priv->sg_tx_p) {
-		dev_err(priv->port.dev, "%s:kzalloc Failed\n", __func__);
+	if (!priv->sg_tx_p)
 		return 0;
-	}
 
 	sg_init_table(priv->sg_tx_p, num); /* Initialize SG table */
 	sg = priv->sg_tx_p;
-- 
2.15.1

