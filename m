From: "Enrico Weigelt, metux IT consult" <info@metux.net>
Subject: [PATCH v2 10/45] drivers: tty: serial: zs: use devm_* functions
Date: Thu, 14 Mar 2019 23:33:40 +0100
Message-ID: <1552602855-26086-11-git-send-email-info@metux.net>
References: <1552602855-26086-1-git-send-email-info@metux.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1552602855-26086-1-git-send-email-info@metux.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: gregkh@linuxfoundation.org, eric@anholt.net, stefan.wahren@i2se.com, f.fainelli@gmail.com, rjui@broadcom.com, sbranden@broadcom.com, bcm-kernel-feedback-list@broadcom.com, andriy.shevchenko@linux.intel.com, vz@mleia.com, matthias.bgg@gmail.com, yamada.masahiro@socionext.com, tklauser@distanz.ch, richard.genoud@gmail.com, macro@linux-mips.org, u.kleine-koenig@pengutronix.de, kernel@pengutronix.de, slemieux.tyco@gmail.com, andy.gross@linaro.org, david.brown@linaro.org, shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com, baohua@kernel.org, jacmet@sunsite.dk, linux-serial@vger.kernel.org, linux-arm-msm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: linux-serial@vger.kernel.org

Use the safer devm versions of memory mapping functions.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/tty/serial/zs.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/zs.c b/drivers/tty/serial/zs.c
index b03d3e4..0b1ec2f 100644
--- a/drivers/tty/serial/zs.c
+++ b/drivers/tty/serial/zs.c
@@ -984,16 +984,17 @@ static const char *zs_type(struct uart_port *uport)
 
 static void zs_release_port(struct uart_port *uport)
 {
-	iounmap(uport->membase);
+	devm_iounmap(uport->dev, uport->membase);
 	uport->membase = 0;
-	release_mem_region(uport->mapbase, ZS_CHAN_IO_SIZE);
+	devm_release_mem_region(uport->dev, uport->mapbase, ZS_CHAN_IO_SIZE);
 }
 
 static int zs_map_port(struct uart_port *uport)
 {
 	if (!uport->membase)
-		uport->membase = ioremap_nocache(uport->mapbase,
-						 ZS_CHAN_IO_SIZE);
+		uport->membase = devm_ioremap_nocache(uport->dev,
+						      uport->mapbase,
+						      ZS_CHAN_IO_SIZE);
 	if (!uport->membase) {
 		printk(KERN_ERR "zs: Cannot map MMIO\n");
 		return -ENOMEM;
@@ -1005,13 +1006,16 @@ static int zs_request_port(struct uart_port *uport)
 {
 	int ret;
 
-	if (!request_mem_region(uport->mapbase, ZS_CHAN_IO_SIZE, "scc")) {
+	if (!devm_request_mem_region(uport->mapbase,
+				     ZS_CHAN_IO_SIZE, "scc")) {
 		printk(KERN_ERR "zs: Unable to reserve MMIO resource\n");
 		return -EBUSY;
 	}
 	ret = zs_map_port(uport);
 	if (ret) {
-		release_mem_region(uport->mapbase, ZS_CHAN_IO_SIZE);
+		devm_release_mem_region(uport-dev,
+					uport->mapbase,
+					ZS_CHAN_IO_SIZE);
 		return ret;
 	}
 	return 0;
-- 
1.9.1
