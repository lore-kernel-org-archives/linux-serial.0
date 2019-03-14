From: "Enrico Weigelt, metux IT consult" <info@metux.net>
Subject: [PATCH v2 33/45] drivers: tty: serial: sb1250-duart: use dev_err() instead of printk()
Date: Thu, 14 Mar 2019 23:34:03 +0100
Message-ID: <1552602855-26086-34-git-send-email-info@metux.net>
References: <1552602855-26086-1-git-send-email-info@metux.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1552602855-26086-1-git-send-email-info@metux.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: gregkh@linuxfoundation.org, eric@anholt.net, stefan.wahren@i2se.com, f.fainelli@gmail.com, rjui@broadcom.com, sbranden@broadcom.com, bcm-kernel-feedback-list@broadcom.com, andriy.shevchenko@linux.intel.com, vz@mleia.com, matthias.bgg@gmail.com, yamada.masahiro@socionext.com, tklauser@distanz.ch, richard.genoud@gmail.com, macro@linux-mips.org, u.kleine-koenig@pengutronix.de, kernel@pengutronix.de, slemieux.tyco@gmail.com, andy.gross@linaro.org, david.brown@linaro.org, shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com, baohua@kernel.org, jacmet@sunsite.dk, linux-serial@vger.kernel.org, linux-arm-msm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: linux-serial@vger.kernel.org

Using dev_err() instead of printk() for more consistent output.
(prints device name, etc).

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/tty/serial/sb1250-duart.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/sb1250-duart.c b/drivers/tty/serial/sb1250-duart.c
index 329aced..655961c 100644
--- a/drivers/tty/serial/sb1250-duart.c
+++ b/drivers/tty/serial/sb1250-duart.c
@@ -663,7 +663,6 @@ static void sbd_release_port(struct uart_port *uport)
 
 static int sbd_map_port(struct uart_port *uport)
 {
-	const char *err = KERN_ERR "sbd: Cannot map MMIO\n";
 	struct sbd_port *sport = to_sport(uport);
 	struct sbd_duart *duart = sport->duart;
 
@@ -671,7 +670,7 @@ static int sbd_map_port(struct uart_port *uport)
 		uport->membase = ioremap_nocache(uport->mapbase,
 						 DUART_CHANREG_SPACING);
 	if (!uport->membase) {
-		printk(err);
+		dev_err(uport->dev, "Cannot map MMIO (base)\n");
 		return -ENOMEM;
 	}
 
@@ -679,7 +678,7 @@ static int sbd_map_port(struct uart_port *uport)
 		sport->memctrl = ioremap_nocache(duart->mapctrl,
 						 DUART_CHANREG_SPACING);
 	if (!sport->memctrl) {
-		printk(err);
+		dev_err(uport->dev, "Cannot map MMIO (ctrl)\n");
 		iounmap(uport->membase);
 		uport->membase = NULL;
 		return -ENOMEM;
-- 
1.9.1
