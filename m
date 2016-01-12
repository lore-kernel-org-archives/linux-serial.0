From: Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 2/3] TTY: serial/mpsc, clean up init/remove functions
Date: Tue, 12 Jan 2016 10:49:33 +0100
Message-ID: <1452592174-24805-2-git-send-email-jslaby@suse.cz>
References: <1452592174-24805-1-git-send-email-jslaby@suse.cz>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1452592174-24805-1-git-send-email-jslaby@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>
List-Id: linux-serial@vger.kernel.org

There is a chain of up to 4 nested ifs in init and remove functions.
Instead, make the code linear and use goto's to handle failures.

Remove unneeded cast from mpsc_release_port by referencing pi->port
directly. And finally, use dev_dbg instead of pr_debug given we have
dev->dev node.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/serial/mpsc.c | 163 ++++++++++++++++++++++------------------------
 1 file changed, 79 insertions(+), 84 deletions(-)

diff --git a/drivers/tty/serial/mpsc.c b/drivers/tty/serial/mpsc.c
index 363772992acc..44a23113f469 100644
--- a/drivers/tty/serial/mpsc.c
+++ b/drivers/tty/serial/mpsc.c
@@ -1891,44 +1891,39 @@ static void mpsc_shared_unmap_regs(void)
 static int mpsc_shared_drv_probe(struct platform_device *dev)
 {
 	struct mpsc_shared_pdata	*pdata;
-	int				 rc = -ENODEV;
-
-	if (dev->id == 0) {
-		rc = mpsc_shared_map_regs(dev);
-		if (!rc) {
-			pdata = (struct mpsc_shared_pdata *)
-				dev_get_platdata(&dev->dev);
-
-			mpsc_shared_regs.MPSC_MRR_m = pdata->mrr_val;
-			mpsc_shared_regs.MPSC_RCRR_m= pdata->rcrr_val;
-			mpsc_shared_regs.MPSC_TCRR_m= pdata->tcrr_val;
-			mpsc_shared_regs.SDMA_INTR_CAUSE_m =
-				pdata->intr_cause_val;
-			mpsc_shared_regs.SDMA_INTR_MASK_m =
-				pdata->intr_mask_val;
-
-			rc = 0;
-		}
-	}
+	int rc;
 
-	return rc;
+	if (dev->id != 0)
+		return -ENODEV;
+
+	rc = mpsc_shared_map_regs(dev);
+	if (rc)
+		return rc;
+
+	pdata = dev_get_platdata(&dev->dev);
+
+	mpsc_shared_regs.MPSC_MRR_m = pdata->mrr_val;
+	mpsc_shared_regs.MPSC_RCRR_m= pdata->rcrr_val;
+	mpsc_shared_regs.MPSC_TCRR_m= pdata->tcrr_val;
+	mpsc_shared_regs.SDMA_INTR_CAUSE_m = pdata->intr_cause_val;
+	mpsc_shared_regs.SDMA_INTR_MASK_m = pdata->intr_mask_val;
+
+	return 0;
 }
 
 static int mpsc_shared_drv_remove(struct platform_device *dev)
 {
-	int	rc = -ENODEV;
+	if (dev->id != 0)
+		return -ENODEV;
 
-	if (dev->id == 0) {
-		mpsc_shared_unmap_regs();
-		mpsc_shared_regs.MPSC_MRR_m = 0;
-		mpsc_shared_regs.MPSC_RCRR_m = 0;
-		mpsc_shared_regs.MPSC_TCRR_m = 0;
-		mpsc_shared_regs.SDMA_INTR_CAUSE_m = 0;
-		mpsc_shared_regs.SDMA_INTR_MASK_m = 0;
-		rc = 0;
-	}
+	mpsc_shared_unmap_regs();
+	mpsc_shared_regs.MPSC_MRR_m = 0;
+	mpsc_shared_regs.MPSC_RCRR_m = 0;
+	mpsc_shared_regs.MPSC_TCRR_m = 0;
+	mpsc_shared_regs.SDMA_INTR_CAUSE_m = 0;
+	mpsc_shared_regs.SDMA_INTR_MASK_m = 0;
 
-	return rc;
+	return 0;
 }
 
 static struct platform_driver mpsc_shared_driver = {
@@ -1979,10 +1974,6 @@ static int mpsc_drv_map_regs(struct mpsc_port_info *pi,
 		pi->sdma_base_p = r->start;
 	} else {
 		mpsc_resource_err("SDMA base");
-		if (pi->mpsc_base) {
-			iounmap(pi->mpsc_base);
-			pi->mpsc_base = NULL;
-		}
 		goto err;
 	}
 
@@ -1993,19 +1984,19 @@ static int mpsc_drv_map_regs(struct mpsc_port_info *pi,
 		pi->brg_base_p = r->start;
 	} else {
 		mpsc_resource_err("BRG base");
-		if (pi->mpsc_base) {
-			iounmap(pi->mpsc_base);
-			pi->mpsc_base = NULL;
-		}
-		if (pi->sdma_base) {
-			iounmap(pi->sdma_base);
-			pi->sdma_base = NULL;
-		}
 		goto err;
 	}
 	return 0;
 
 err:
+	if (pi->sdma_base) {
+		iounmap(pi->sdma_base);
+		pi->sdma_base = NULL;
+	}
+	if (pi->mpsc_base) {
+		iounmap(pi->mpsc_base);
+		pi->mpsc_base = NULL;
+	}
 	return -ENOMEM;
 }
 
@@ -2073,36 +2064,37 @@ static void mpsc_drv_get_platform_data(struct mpsc_port_info *pi,
 
 static int mpsc_drv_probe(struct platform_device *dev)
 {
-	struct mpsc_port_info	*pi;
-	int			rc = -ENODEV;
-
-	pr_debug("mpsc_drv_probe: Adding MPSC %d\n", dev->id);
-
-	if (dev->id < MPSC_NUM_CTLRS) {
-		pi = &mpsc_ports[dev->id];
-
-		rc = mpsc_drv_map_regs(pi, dev);
-		if (!rc) {
-			mpsc_drv_get_platform_data(pi, dev, dev->id);
-			pi->port.dev = &dev->dev;
-
-			rc = mpsc_make_ready(pi);
-			if (!rc) {
-				spin_lock_init(&pi->tx_lock);
-				rc = uart_add_one_port(&mpsc_reg, &pi->port);
-				if (!rc) {
-					rc = 0;
-				} else {
-					mpsc_release_port((struct uart_port *)
-							pi);
-					mpsc_drv_unmap_regs(pi);
-				}
-			} else {
-				mpsc_drv_unmap_regs(pi);
-			}
-		}
-	}
+	struct mpsc_port_info *pi;
+	int rc;
+
+	dev_dbg(&dev->dev, "mpsc_drv_probe: Adding MPSC %d\n", dev->id);
+
+	if (dev->id >= MPSC_NUM_CTLRS)
+		return -ENODEV;
+
+	pi = &mpsc_ports[dev->id];
+
+	rc = mpsc_drv_map_regs(pi, dev);
+	if (rc)
+		return rc;
 
+	mpsc_drv_get_platform_data(pi, dev, dev->id);
+	pi->port.dev = &dev->dev;
+
+	rc = mpsc_make_ready(pi);
+	if (rc)
+		goto err_unmap;
+
+	spin_lock_init(&pi->tx_lock);
+	rc = uart_add_one_port(&mpsc_reg, &pi->port);
+	if (rc)
+		goto err_relport;
+
+	return 0;
+err_relport:
+	mpsc_release_port(&pi->port);
+err_unmap:
+	mpsc_drv_unmap_regs(pi);
 	return rc;
 }
 
@@ -2124,19 +2116,22 @@ static int __init mpsc_drv_init(void)
 	memset(&mpsc_shared_regs, 0, sizeof(mpsc_shared_regs));
 
 	rc = uart_register_driver(&mpsc_reg);
-	if (!rc) {
-		rc = platform_driver_register(&mpsc_shared_driver);
-		if (!rc) {
-			rc = platform_driver_register(&mpsc_driver);
-			if (rc) {
-				platform_driver_unregister(&mpsc_shared_driver);
-				uart_unregister_driver(&mpsc_reg);
-			}
-		} else {
-			uart_unregister_driver(&mpsc_reg);
-		}
-	}
+	if (rc)
+		return rc;
+
+	rc = platform_driver_register(&mpsc_shared_driver);
+	if (rc)
+		goto err_unreg_uart;
 
+	rc = platform_driver_register(&mpsc_driver);
+	if (rc)
+		goto err_unreg_plat;
+
+	return 0;
+err_unreg_plat:
+	platform_driver_unregister(&mpsc_shared_driver);
+err_unreg_uart:
+	uart_unregister_driver(&mpsc_reg);
 	return rc;
 }
 device_initcall(mpsc_drv_init);
-- 
2.7.0
