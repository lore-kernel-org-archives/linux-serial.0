From: Tushar Behera <tushar.behera@linaro.org>
Subject: [PATCH 2/2] serial: pl011: Move uart_register_driver call to device probe
Date: Mon, 20 Jan 2014 14:32:35 +0530
Message-ID: <1390208555-27770-3-git-send-email-tushar.behera@linaro.org>
References: <1390208555-27770-1-git-send-email-tushar.behera@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1390208555-27770-1-git-send-email-tushar.behera@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc: jslaby@suse.cz, gregkh@linuxfoundation.org, linux@arm.linux.org.uk, ben.dooks@codethink.co.uk, broonie@kernel.org
List-Id: linux-serial@vger.kernel.org

uart_register_driver call binds the driver to a specific device
node through tty_register_driver call. This should typically happen
during device probe call.

In a multiplatform scenario, it is possible that multiple serial
drivers are part of the kernel. Currently the driver registration fails
if multiple serial drivers with same default major/minor numbers are
included in the kernel.

A typical case is observed with amba-pl011 and samsung-uart drivers.

Signed-off-by: Tushar Behera <tushar.behera@linaro.org>
---
 drivers/tty/serial/amba-pl011.c |   21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index d58783d..d4eda24 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -2154,9 +2154,19 @@ static int pl011_probe(struct amba_device *dev, const struct amba_id *id)
 	amba_ports[i] = uap;
 
 	amba_set_drvdata(dev, uap);
+
+	if (!amba_reg.state) {
+		ret = uart_register_driver(&amba_reg);
+		if (ret < 0) {
+			pr_err("Failed to register AMBA-PL011 driver\n");
+			return ret;
+		}
+	}
+
 	ret = uart_add_one_port(&amba_reg, &uap->port);
 	if (ret) {
 		amba_ports[i] = NULL;
+		uart_unregister_driver(&amba_reg);
 		pl011_dma_remove(uap);
 	}
  out:
@@ -2175,6 +2185,7 @@ static int pl011_remove(struct amba_device *dev)
 			amba_ports[i] = NULL;
 
 	pl011_dma_remove(uap);
+	uart_unregister_driver(&amba_reg);
 	return 0;
 }
 
@@ -2230,22 +2241,14 @@ static struct amba_driver pl011_driver = {
 
 static int __init pl011_init(void)
 {
-	int ret;
 	printk(KERN_INFO "Serial: AMBA PL011 UART driver\n");
 
-	ret = uart_register_driver(&amba_reg);
-	if (ret == 0) {
-		ret = amba_driver_register(&pl011_driver);
-		if (ret)
-			uart_unregister_driver(&amba_reg);
-	}
-	return ret;
+	return amba_driver_register(&pl011_driver);
 }
 
 static void __exit pl011_exit(void)
 {
 	amba_driver_unregister(&pl011_driver);
-	uart_unregister_driver(&amba_reg);
 }
 
 /*
-- 
1.7.9.5
