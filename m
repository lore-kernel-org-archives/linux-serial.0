From: Allen Pais <allen.lkml@gmail.com>
Subject: [PATCH 02/10] drivers:tty: imx: use setup_timer() helper.
Date: Fri, 22 Sep 2017 13:56:44 +0530
Message-ID: <1506068812-8496-3-git-send-email-allen.lkml@gmail.com>
References: <1506068812-8496-1-git-send-email-allen.lkml@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1506068812-8496-1-git-send-email-allen.lkml@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, jslaby@suse.com, Allen Pais <allen.lkml@gmail.com>
List-Id: linux-serial@vger.kernel.org

    Use setup_timer function instead of initializing timer with the
    function and data fields.

Signed-off-by: Allen Pais <allen.lkml@gmail.com>
---
 drivers/tty/serial/imx.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index dfeff39..64f57c6 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -2115,9 +2115,7 @@ static int serial_imx_probe(struct platform_device *pdev)
 	sport->port.rs485.flags =
 		SER_RS485_RTS_ON_SEND | SER_RS485_RX_DURING_TX;
 	sport->port.flags = UPF_BOOT_AUTOCONF;
-	init_timer(&sport->timer);
-	sport->timer.function = imx_timeout;
-	sport->timer.data     = (unsigned long)sport;
+	setup_timer(&sport->timer, imx_timeout, (unsigned long)sport);
 
 	sport->gpios = mctrl_gpio_init(&sport->port, 0);
 	if (IS_ERR(sport->gpios))
-- 
2.7.4
