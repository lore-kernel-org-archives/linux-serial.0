From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 2/4] serial: pch_uart: Use kcalloc() in dma_handle_tx()
Date: Fri, 8 Dec 2017 19:10:32 +0100
Message-ID: <d9e3c269-9d71-7b58-be1f-8f0c75fdf6a3@users.sourceforge.net>
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
Date: Fri, 8 Dec 2017 18:38:15 +0100

* A multiplication for the size determination of a memory allocation
  indicated that an array data structure should be processed.
  Thus use the corresponding function "kcalloc".

  This issue was detected by using the Coccinelle software.

* Replace the specification of a data structure by a pointer dereference
  to make the corresponding size determination a bit safer according to
  the Linux coding style convention.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/tty/serial/pch_uart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/pch_uart.c b/drivers/tty/serial/pch_uart.c
index 0fc72c491c9b..53cdf23b83c6 100644
--- a/drivers/tty/serial/pch_uart.c
+++ b/drivers/tty/serial/pch_uart.c
@@ -991,7 +991,7 @@ static unsigned int dma_handle_tx(struct eg20t_port *priv)
 
 	priv->tx_dma_use = 1;
 
-	priv->sg_tx_p = kzalloc(sizeof(struct scatterlist)*num, GFP_ATOMIC);
+	priv->sg_tx_p = kcalloc(num, sizeof(*priv->sg_tx_p), GFP_ATOMIC);
 	if (!priv->sg_tx_p)
 		return 0;
 
-- 
2.15.1

