From: "Enrico Weigelt, metux IT consult" <info@metux.net>
Subject: [PATCH v2 27/45] drivers: tty: serial: dz: use devm_* functions
Date: Thu, 14 Mar 2019 23:33:57 +0100
Message-ID: <1552602855-26086-28-git-send-email-info@metux.net>
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
 drivers/tty/serial/dz.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/dz.c b/drivers/tty/serial/dz.c
index 96e35af..10a75e3 100644
--- a/drivers/tty/serial/dz.c
+++ b/drivers/tty/serial/dz.c
@@ -666,19 +666,22 @@ static void dz_release_port(struct uart_port *uport)
 	struct dz_mux *mux = to_dport(uport)->mux;
 	int map_guard;
 
-	iounmap(uport->membase);
+	devm_iounmap(uport->dev, uport->membase);
 	uport->membase = NULL;
 
 	map_guard = atomic_add_return(-1, &mux->map_guard);
 	if (!map_guard)
-		release_mem_region(uport->mapbase, dec_kn_slot_size);
+		devm_release_mem_region(uport->dev,
+					uport->mapbase,
+					dec_kn_slot_size);
 }
 
 static int dz_map_port(struct uart_port *uport)
 {
 	if (!uport->membase)
-		uport->membase = ioremap_nocache(uport->mapbase,
-						 dec_kn_slot_size);
+		uport->membase = devm_ioremap_nocache(uport->dev,
+						      uport->mapbase,
+						      dec_kn_slot_size);
 	if (!uport->membase) {
 		dev_err(uport->dev, "Cannot map MMIO\n");
 		return -ENOMEM;
@@ -694,8 +697,10 @@ static int dz_request_port(struct uart_port *uport)
 
 	map_guard = atomic_add_return(1, &mux->map_guard);
 	if (map_guard == 1) {
-		if (!request_mem_region(uport->mapbase, dec_kn_slot_size,
-					"dz")) {
+		if (!devm_request_mem_region(uport->dev,
+					     uport->mapbase,
+					     dec_kn_slot_size,
+					     "dz")) {
 			atomic_add(-1, &mux->map_guard);
 			dev_err(uport->dev,
 				"Unable to reserve MMIO resource\n");
@@ -706,7 +711,9 @@ static int dz_request_port(struct uart_port *uport)
 	if (ret) {
 		map_guard = atomic_add_return(-1, &mux->map_guard);
 		if (!map_guard)
-			release_mem_region(uport->mapbase, dec_kn_slot_size);
+			devm_release_mem_region(uport->dev,
+						uport->mapbase,
+						dec_kn_slot_size);
 		return ret;
 	}
 	return 0;
-- 
1.9.1
