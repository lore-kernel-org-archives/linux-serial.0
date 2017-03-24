From: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
Subject: [PATCH 1/2] serial: pl010: Move uart_register_driver call to device probe
Date: Fri, 24 Mar 2017 17:26:33 +0100
Message-ID: <20170324162634.8880-2-sjoerd.simons@collabora.co.uk>
References: <20170324162634.8880-1-sjoerd.simons@collabora.co.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170324162634.8880-1-sjoerd.simons@collabora.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>, Jiri Slaby <jslaby@suse.com>
List-Id: linux-serial@vger.kernel.org

uart_register_driver call binds the driver to a specific device
node through tty_register_driver call. This should typically
happen during device probe call.

In a multiplatform scenario, it is possible that multiple serial
drivers are part of the kernel. Currently the driver registration fails
if multiple serial drivers with overlapping major/minor numbers are
included.

Signed-off-by: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
---

 drivers/tty/serial/amba-pl010.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/drivers/tty/serial/amba-pl010.c b/drivers/tty/serial/amba-pl010.c
index f2f251075109..74a1d3b2e45d 100644
--- a/drivers/tty/serial/amba-pl010.c
+++ b/drivers/tty/serial/amba-pl010.c
@@ -749,6 +749,16 @@ static int pl010_probe(struct amba_device *dev, const struct amba_id *id)
 	amba_ports[i] = uap;
 
 	amba_set_drvdata(dev, uap);
+
+	if (!amba_reg.state) {
+		ret = uart_register_driver(&amba_reg);
+		if (ret < 0) {
+			dev_err(uap->port.dev,
+				"Failed to register AMBA-PL010 driver\n");
+			return ret;
+		}
+	}
+
 	ret = uart_add_one_port(&amba_reg, &uap->port);
 	if (ret)
 		amba_ports[i] = NULL;
@@ -760,12 +770,18 @@ static int pl010_remove(struct amba_device *dev)
 {
 	struct uart_amba_port *uap = amba_get_drvdata(dev);
 	int i;
+	bool busy = false;
 
 	uart_remove_one_port(&amba_reg, &uap->port);
 
 	for (i = 0; i < ARRAY_SIZE(amba_ports); i++)
 		if (amba_ports[i] == uap)
 			amba_ports[i] = NULL;
+		else if (amba_ports[i])
+			busy = true;
+
+	if (!busy)
+		uart_unregister_driver(&amba_reg);
 
 	return 0;
 }
@@ -816,23 +832,14 @@ static struct amba_driver pl010_driver = {
 
 static int __init pl010_init(void)
 {
-	int ret;
-
 	printk(KERN_INFO "Serial: AMBA driver\n");
 
-	ret = uart_register_driver(&amba_reg);
-	if (ret == 0) {
-		ret = amba_driver_register(&pl010_driver);
-		if (ret)
-			uart_unregister_driver(&amba_reg);
-	}
-	return ret;
+	return  amba_driver_register(&pl010_driver);
 }
 
 static void __exit pl010_exit(void)
 {
 	amba_driver_unregister(&pl010_driver);
-	uart_unregister_driver(&amba_reg);
 }
 
 module_init(pl010_init);
-- 
2.11.0
