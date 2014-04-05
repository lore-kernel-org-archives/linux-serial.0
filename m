From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH] serial: amba-pl011: fix regression, causing an Oops on rmmod
Date: Sat, 5 Apr 2014 16:31:08 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1404051629050.3518@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org
Cc: Greg KH <greg@kroah.com>, linux-serial@vger.kernel.org, Tushar Behera <tushar.behera@linaro.org>
List-Id: linux-serial@vger.kernel.org

A recent commit ef2889f7ffee67f0aed49e854c72be63f1466759 "serial: pl011:
Move uart_register_driver call to device probe" introduced a regression,
causing the pl011 driver to Oops if more than 1 port have been probed. Fix
the Oops by only calling uart_unregister_driver() once after the last port
has been removed.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/tty/serial/amba-pl011.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index d4eda24..07325f2 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -2176,6 +2176,7 @@ static int pl011_probe(struct amba_device *dev, const struct amba_id *id)
 static int pl011_remove(struct amba_device *dev)
 {
 	struct uart_amba_port *uap = amba_get_drvdata(dev);
+	bool busy = false;
 	int i;
 
 	uart_remove_one_port(&amba_reg, &uap->port);
@@ -2183,9 +2184,12 @@ static int pl011_remove(struct amba_device *dev)
 	for (i = 0; i < ARRAY_SIZE(amba_ports); i++)
 		if (amba_ports[i] == uap)
 			amba_ports[i] = NULL;
+		else if (amba_ports[i])
+			busy = true;
 
 	pl011_dma_remove(uap);
-	uart_unregister_driver(&amba_reg);
+	if (!busy)
+		uart_unregister_driver(&amba_reg);
 	return 0;
 }
 
-- 
1.9.1
