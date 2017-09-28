From: Martyn Welch <martyn.welch@collabora.co.uk>
Subject: [PATCH v2] Use RX_BUF_SIZE to set size of RX buffer
Date: Thu, 28 Sep 2017 11:07:40 +0100
Message-ID: <1506593260-14457-1-git-send-email-martyn.welch@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Martyn Welch <martyn.welch@collabora.co.uk>
List-Id: linux-serial@vger.kernel.org

The imx serial driver uses PAGE_SIZE when allocating rx_buf, but then
uses RX_BUF_SIZE (which is currently defined as PAGE_SIZE) to describe
the length of the buffer when initialising the scatter gather list.

In order to ensure that this stays consistent, use RX_BUF_SIZE in both
locations.

Signed-off-by: Martyn Welch <martyn.welch@collabora.co.uk>
Acked-by: Uwe Kleine-König <u.kleine-könig@pengtronix.de>
---

v2: Add missing SoB and Uwe's Acked-by.

 drivers/tty/serial/imx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 1691ed2..9da109a 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -1164,7 +1164,7 @@ static int imx_uart_dma_init(struct imx_port *sport)
 		goto err;
 	}
 
-	sport->rx_buf = kzalloc(PAGE_SIZE, GFP_KERNEL);
+	sport->rx_buf = kzalloc(RX_BUF_SIZE, GFP_KERNEL);
 	if (!sport->rx_buf) {
 		ret = -ENOMEM;
 		goto err;
-- 
1.8.3.1
