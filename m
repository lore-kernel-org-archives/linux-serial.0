From: Andre Przywara <andre.przywara@arm.com>
Subject: [PATCH v2 01/10] drivers: PL011: avoid potential unregister_driver
 call
Date: Wed,  4 Mar 2015 17:59:45 +0000
Message-ID: <1425491994-23913-2-git-send-email-andre.przywara@arm.com>
References: <1425491994-23913-1-git-send-email-andre.przywara@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1425491994-23913-1-git-send-email-andre.przywara@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux@arm.linux.org.uk, gregkh@linuxfoundation.org, jslaby@suse.cz
Cc: linux-arm-kernel@lists.infradead.org, rob.herring@linaro.org, arnd@arndb.de, linux-serial@vger.kernel.org, Dave.Martin@arm.com
List-Id: linux-serial@vger.kernel.org

Although we care about not unregistering the driver if there are
still ports connected during the .remove callback, we do miss this
check in the pl011_probe function. So if the current port allocation
fails, but there are other ports already registered, we will kill
those.
So factor out the port removal into a separate function and use that
in the probe function, too.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 drivers/tty/serial/amba-pl011.c |   38 +++++++++++++++++++++-----------------
 1 file changed, 21 insertions(+), 17 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 92783fc..961f9b0 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -2235,6 +2235,24 @@ static int pl011_probe_dt_alias(int index, struct device *dev)
 	return ret;
 }
 
+/* unregisters the driver also if no more ports are left */
+static void pl011_unregister_port(struct uart_amba_port *uap)
+{
+	int i;
+	bool busy = false;
+
+	for (i = 0; i < ARRAY_SIZE(amba_ports); i++) {
+		if (amba_ports[i] == uap)
+			amba_ports[i] = NULL;
+		else if (amba_ports[i])
+			busy = true;
+	}
+	pl011_dma_remove(uap);
+	if (!busy)
+		uart_unregister_driver(&amba_reg);
+}
+
+
 static int pl011_probe(struct amba_device *dev, const struct amba_id *id)
 {
 	struct uart_amba_port *uap;
@@ -2301,11 +2319,8 @@ static int pl011_probe(struct amba_device *dev, const struct amba_id *id)
 	}
 
 	ret = uart_add_one_port(&amba_reg, &uap->port);
-	if (ret) {
-		amba_ports[i] = NULL;
-		uart_unregister_driver(&amba_reg);
-		pl011_dma_remove(uap);
-	}
+	if (ret)
+		pl011_unregister_port(uap);
 
 	return ret;
 }
@@ -2313,20 +2328,9 @@ static int pl011_probe(struct amba_device *dev, const struct amba_id *id)
 static int pl011_remove(struct amba_device *dev)
 {
 	struct uart_amba_port *uap = amba_get_drvdata(dev);
-	bool busy = false;
-	int i;
 
 	uart_remove_one_port(&amba_reg, &uap->port);
-
-	for (i = 0; i < ARRAY_SIZE(amba_ports); i++)
-		if (amba_ports[i] == uap)
-			amba_ports[i] = NULL;
-		else if (amba_ports[i])
-			busy = true;
-
-	pl011_dma_remove(uap);
-	if (!busy)
-		uart_unregister_driver(&amba_reg);
+	pl011_unregister_port(uap);
 	return 0;
 }
 
-- 
1.7.9.5
