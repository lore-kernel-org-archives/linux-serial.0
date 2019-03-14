From: "Enrico Weigelt, metux IT consult" <info@metux.net>
Subject: [PATCH v2 26/45] drivers: tty: serial: dz: use dev_err() instead of printk()
Date: Thu, 14 Mar 2019 23:33:56 +0100
Message-ID: <1552602855-26086-27-git-send-email-info@metux.net>
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
 drivers/tty/serial/dz.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/dz.c b/drivers/tty/serial/dz.c
index 7b57e84..96e35af 100644
--- a/drivers/tty/serial/dz.c
+++ b/drivers/tty/serial/dz.c
@@ -416,7 +416,7 @@ static int dz_startup(struct uart_port *uport)
 			  IRQF_SHARED, "dz", mux);
 	if (ret) {
 		atomic_add(-1, &mux->irq_guard);
-		printk(KERN_ERR "dz: Cannot get IRQ %d!\n", dport->port.irq);
+		dev_err(uport->dev, "Cannot get IRQ %d!\n", dport->port.irq);
 		return ret;
 	}
 
@@ -680,7 +680,7 @@ static int dz_map_port(struct uart_port *uport)
 		uport->membase = ioremap_nocache(uport->mapbase,
 						 dec_kn_slot_size);
 	if (!uport->membase) {
-		printk(KERN_ERR "dz: Cannot map MMIO\n");
+		dev_err(uport->dev, "Cannot map MMIO\n");
 		return -ENOMEM;
 	}
 	return 0;
@@ -697,8 +697,8 @@ static int dz_request_port(struct uart_port *uport)
 		if (!request_mem_region(uport->mapbase, dec_kn_slot_size,
 					"dz")) {
 			atomic_add(-1, &mux->map_guard);
-			printk(KERN_ERR
-			       "dz: Unable to reserve MMIO resource\n");
+			dev_err(uport->dev,
+				"Unable to reserve MMIO resource\n");
 			return -EBUSY;
 		}
 	}
-- 
1.9.1
