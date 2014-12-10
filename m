From: Robert Baldyga <r.baldyga@samsung.com>
Subject: [PATCH 2/6] serial: samsung: alloc dma stucture in ourport
Date: Wed, 10 Dec 2014 12:49:23 +0100
Message-ID: <1418212167-28992-3-git-send-email-r.baldyga@samsung.com>
References: <1418212167-28992-1-git-send-email-r.baldyga@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1418212167-28992-1-git-send-email-r.baldyga@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: jslaby@suse.cz, akpm@linux-foundation.org, kgene.kim@samsung.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, m.szyprowski@samsung.com, kyungmin.park@samsung.com, l.czerwinski@samsung.com, s.nawrocki@samsung.com, Robert Baldyga <r.baldyga@samsung.com>
List-Id: linux-serial@vger.kernel.org

When we have "dmas" property in serial node in device-tree, we do
memory alocation for dma structure which will be used in DMA handling
code.

Based on previous work of Sylwester Nawrocki and Lukasz Czerwinski.

Signed-off-by: Robert Baldyga <r.baldyga@samsung.com>
---
 drivers/tty/serial/samsung.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsung.c
index 19273e3..7196a3e 100644
--- a/drivers/tty/serial/samsung.c
+++ b/drivers/tty/serial/samsung.c
@@ -1209,6 +1209,18 @@ static int s3c24xx_serial_init_port(struct s3c24xx_uart_port *ourport,
 	ret = platform_get_irq(platdev, 1);
 	if (ret > 0)
 		ourport->tx_irq = ret;
+	/*
+	 * DMA is currently supported only on DT platforms, if DMA properties
+	 * are specified.
+	 */
+	if (platdev->dev.of_node && of_find_property(platdev->dev.of_node,
+						     "dmas", NULL)) {
+		ourport->dma = devm_kzalloc(port->dev,
+					    sizeof(*ourport->dma),
+					    GFP_KERNEL);
+		if (!ourport->dma)
+			return -ENOMEM;
+	}
 
 	ourport->clk	= clk_get(&platdev->dev, "uart");
 	if (IS_ERR(ourport->clk)) {
-- 
1.9.1
