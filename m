From: Alexey Khoroshilov <khoroshilov@ispras.ru>
Subject: [PATCH] serial: 8250: fix error handling in of_platform_serial_probe()
Date: Sat,  1 Jul 2017 01:49:29 +0300
Message-ID: <1498862969-4919-1-git-send-email-khoroshilov@ispras.ru>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Arnd Bergmann <arnd@arndb.de>
Cc: Alexey Khoroshilov <khoroshilov@ispras.ru>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org
List-Id: linux-serial@vger.kernel.org

clk_disable_unprepare(info->clk) is missed in of_platform_serial_probe(),
while irq_dispose_mapping(port->irq) is missed in of_platform_serial_setup().

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
---
 drivers/tty/serial/8250/8250_of.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_of.c b/drivers/tty/serial/8250/8250_of.c
index 1cbadafc6889..f7a0e7831635 100644
--- a/drivers/tty/serial/8250/8250_of.c
+++ b/drivers/tty/serial/8250/8250_of.c
@@ -86,7 +86,7 @@ static int of_platform_serial_setup(struct platform_device *ofdev,
 	ret = of_address_to_resource(np, 0, &resource);
 	if (ret) {
 		dev_warn(&ofdev->dev, "invalid address\n");
-		goto out;
+		goto err_address;
 	}
 
 	spin_lock_init(&port->lock);
@@ -128,7 +128,7 @@ static int of_platform_serial_setup(struct platform_device *ofdev,
 			dev_warn(&ofdev->dev, "unsupported reg-io-width (%d)\n",
 				 prop);
 			ret = -EINVAL;
-			goto out;
+			goto err_regio;
 		}
 	}
 
@@ -158,7 +158,10 @@ static int of_platform_serial_setup(struct platform_device *ofdev,
 		port->handle_irq = fsl8250_handle_irq;
 
 	return 0;
-out:
+
+err_regio:
+	irq_dispose_mapping(port->irq);
+err_address:
 	if (info->clk)
 		clk_disable_unprepare(info->clk);
 	return ret;
@@ -192,7 +195,7 @@ static int of_platform_serial_probe(struct platform_device *ofdev)
 	memset(&port8250, 0, sizeof(port8250));
 	ret = of_platform_serial_setup(ofdev, port_type, &port8250.port, info);
 	if (ret)
-		goto out;
+		goto err_setup;
 
 	if (port8250.port.fifosize)
 		port8250.capabilities = UART_CAP_FIFO;
@@ -208,15 +211,18 @@ static int of_platform_serial_probe(struct platform_device *ofdev)
 
 	ret = serial8250_register_8250_port(&port8250);
 	if (ret < 0)
-		goto out;
+		goto err_register;
 
 	info->type = port_type;
 	info->line = ret;
 	platform_set_drvdata(ofdev, info);
 	return 0;
-out:
-	kfree(info);
+err_register:
 	irq_dispose_mapping(port8250.port.irq);
+	if (info->clk)
+		clk_disable_unprepare(info->clk);
+err_setup:
+	kfree(info);
 	return ret;
 }
 
-- 
2.7.4
