From: Martyn Welch <martyn.welch@collabora.co.uk>
Subject: [PATCH] Use RX_BUF_SIZE to set size of RX buffer
Date: Thu, 28 Sep 2017 10:52:15 +0100
Message-ID: <1506592335-12623-1-git-send-email-martyn.welch@collabora.co.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Martyn Welch <martyn.welch@collabora.co.uk>
List-Id: linux-serial@vger.kernel.org

The imx serial driver uses PAGE_SIZE when allocating rx_buf, but then
uses RX_BUF_SIZE (which is currently defined as PAGE_SIZE) to describe
the length of the buffer when initialising the scatter gather list.

In order to ensure that this stays consistent, use RX_BUF_SIZE in both
locations.
---
 drivers/tty/serial/imx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index fe368a4..bc2f2a2f 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -1165,7 +1165,7 @@ static int imx_uart_dma_init(struct imx_port *sport)
 		goto err;
 	}
 
-	sport->rx_buf = kzalloc(PAGE_SIZE, GFP_KERNEL);
+	sport->rx_buf = kzalloc(RX_BUF_SIZE, GFP_KERNEL);
 	if (!sport->rx_buf) {
 		ret = -ENOMEM;
 		goto err;
-- 
1.8.3.1
