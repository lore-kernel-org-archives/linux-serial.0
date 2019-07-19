From: Navid Emamdoost <navid.emamdoost@gmail.com>
Subject: [PATCH] lpss8250_dma_setup: there is memory leak when second allocation fails
Date: Fri, 19 Jul 2019 13:11:58 -0500
Message-ID: <20190719181200.25607-1-navid.emamdoost@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: emamd001@umn.edu, kjlu@umn.edu, smccaman@umn.edu, Navid Emamdoost <navid.emamdoost@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Vinod Koul <vkoul@kernel.org>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

in lpss8250_dma_setup, we need to release the first dma slave object
allocated in case of the second allocation failure.

Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
---
 drivers/tty/serial/8250/8250_lpss.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_lpss.c b/drivers/tty/serial/8250/8250_lpss.c
index d07e431110d9..6e1f86db88b2 100644
--- a/drivers/tty/serial/8250/8250_lpss.c
+++ b/drivers/tty/serial/8250/8250_lpss.c
@@ -259,8 +259,10 @@ static int lpss8250_dma_setup(struct lpss8250 *lpss, struct uart_8250_port *port
 		return -ENOMEM;
 
 	tx_param = devm_kzalloc(dev, sizeof(*tx_param), GFP_KERNEL);
-	if (!tx_param)
+	if (!tx_param) {
+		kfree(rx_param);
 		return -ENOMEM;
+	}
 
 	*rx_param = lpss->dma_param;
 	dma->rxconf.src_maxburst = lpss->dma_maxburst;
-- 
2.17.1
