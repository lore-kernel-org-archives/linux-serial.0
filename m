From: "Enrico Weigelt, metux IT consult" <info@metux.net>
Subject: [PATCH v2 34/45] drivers: tty: serial: sb1250-duart: use devm_* functions
Date: Thu, 14 Mar 2019 23:34:04 +0100
Message-ID: <1552602855-26086-35-git-send-email-info@metux.net>
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
 drivers/tty/serial/sb1250-duart.c | 42 +++++++++++++++++++++++++--------------
 1 file changed, 27 insertions(+), 15 deletions(-)

diff --git a/drivers/tty/serial/sb1250-duart.c b/drivers/tty/serial/sb1250-duart.c
index 655961c..e77eef6 100644
--- a/drivers/tty/serial/sb1250-duart.c
+++ b/drivers/tty/serial/sb1250-duart.c
@@ -651,14 +651,18 @@ static void sbd_release_port(struct uart_port *uport)
 	struct sbd_port *sport = to_sport(uport);
 	struct sbd_duart *duart = sport->duart;
 
-	iounmap(sport->memctrl);
+	devm_iounmap(uport->dev, sport->memctrl);
 	sport->memctrl = NULL;
-	iounmap(uport->membase);
+	devm_iounmap(uport->dev, uport->membase);
 	uport->membase = NULL;
 
 	if(refcount_dec_and_test(&duart->map_guard))
-		release_mem_region(duart->mapctrl, DUART_CHANREG_SPACING);
-	release_mem_region(uport->mapbase, DUART_CHANREG_SPACING);
+		devm_release_mem_region(uport->dev,
+					duart->mapctrl,
+					DUART_CHANREG_SPACING);
+	devm_release_mem_region(uport->dev,
+				uport->mapbase,
+				DUART_CHANREG_SPACING);
 }
 
 static int sbd_map_port(struct uart_port *uport)
@@ -667,19 +671,21 @@ static int sbd_map_port(struct uart_port *uport)
 	struct sbd_duart *duart = sport->duart;
 
 	if (!uport->membase)
-		uport->membase = ioremap_nocache(uport->mapbase,
-						 DUART_CHANREG_SPACING);
+		uport->membase = devm_ioremap_nocache(uport->dev,
+						      uport->mapbase,
+						      DUART_CHANREG_SPACING);
 	if (!uport->membase) {
 		dev_err(uport->dev, "Cannot map MMIO (base)\n");
 		return -ENOMEM;
 	}
 
 	if (!sport->memctrl)
-		sport->memctrl = ioremap_nocache(duart->mapctrl,
-						 DUART_CHANREG_SPACING);
+		sport->memctrl = devm_ioremap_nocache(uport->dev,
+						      duart->mapctrl,
+						      DUART_CHANREG_SPACING);
 	if (!sport->memctrl) {
 		dev_err(uport->dev, "Cannot map MMIO (ctrl)\n");
-		iounmap(uport->membase);
+		devm_iounmap(uport->dev, uport->membase);
 		uport->membase = NULL;
 		return -ENOMEM;
 	}
@@ -693,15 +699,18 @@ static int sbd_request_port(struct uart_port *uport)
 	struct sbd_duart *duart = to_sport(uport)->duart;
 	int ret = 0;
 
-	if (!request_mem_region(uport->mapbase, DUART_CHANREG_SPACING,
+	if (!devm_request_mem_region(uport->dev,
+				uport->mapbase, DUART_CHANREG_SPACING,
 				"sb1250-duart")) {
 		printk(err);
 		return -EBUSY;
 	}
 	refcount_inc(&duart->map_guard);
 	if (refcount_read(&duart->map_guard) == 1) {
-		if (!request_mem_region(duart->mapctrl, DUART_CHANREG_SPACING,
-					"sb1250-duart")) {
+		if (!devm_request_mem_region(uport->dev,
+					     duart->mapctrl,
+					     DUART_CHANREG_SPACING,
+					     "sb1250-duart")) {
 			refcount_dec(&duart->map_guard);
 			printk(err);
 			ret = -EBUSY;
@@ -711,12 +720,15 @@ static int sbd_request_port(struct uart_port *uport)
 		ret = sbd_map_port(uport);
 		if (ret) {
 			if (refcount_dec_and_test(&duart->map_guard))
-				release_mem_region(duart->mapctrl,
-						   DUART_CHANREG_SPACING);
+				devm_release_mem_region(uport->dev,
+							duart->mapctrl,
+							DUART_CHANREG_SPACING);
 		}
 	}
 	if (ret) {
-		release_mem_region(uport->mapbase, DUART_CHANREG_SPACING);
+		devm_release_mem_region(uport->dev,
+					uport->mapbase,
+					DUART_CHANREG_SPACING);
 		return ret;
 	}
 	return 0;
-- 
1.9.1
