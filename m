From: Alexey Khoroshilov <khoroshilov@ispras.ru>
Subject: [PATCH v3] serial: 8250: fix error handling in of_platform_serial_probe()
Date: Wed, 19 Jul 2017 11:32:37 +0300
Message-ID: <1500453157-13258-1-git-send-email-khoroshilov@ispras.ru>
References: <20170718154521.GA7132@localhost>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170718154521.GA7132@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Arnd Bergmann <arnd@arndb.de>
Cc: Alexey Khoroshilov <khoroshilov@ispras.ru>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org
List-Id: linux-serial@vger.kernel.org

clk_disable_unprepare(info->clk) is missed in of_platform_serial_probe(),
while irq_dispose_mapping(port->irq) is missed in of_platform_serial_setup().

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
---
v2: Rebase on top of e2860e1f62f2 "serial: 8250_of: Add reset support"
v3: Rename error labels after what they do as Johan Hovold suggested.

 drivers/tty/serial/8250/8250_of.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_of.c b/drivers/tty/serial/8250/8250_of.c
index 0cf95fd..6c5a8ca 100644
--- a/drivers/tty/serial/8250/8250_of.c
+++ b/drivers/tty/serial/8250/8250_of.c
@@ -88,7 +88,7 @@ static int of_platform_serial_setup(struct platform_device *ofdev,
 	ret = of_address_to_resource(np, 0, &resource);
 	if (ret) {
 		dev_warn(&ofdev->dev, "invalid address\n");
-		goto out;
+		goto err_unprepare;
 	}
 
 	spin_lock_init(&port->lock);
@@ -130,16 +130,16 @@ static int of_platform_serial_setup(struct platform_device *ofdev,
 			dev_warn(&ofdev->dev, "unsupported reg-io-width (%d)\n",
 				 prop);
 			ret = -EINVAL;
-			goto out;
+			goto err_dispose;
 		}
 	}
 
 	info->rst = devm_reset_control_get_optional_shared(&ofdev->dev, NULL);
 	if (IS_ERR(info->rst))
-		goto out;
+		goto err_dispose;
 	ret = reset_control_deassert(info->rst);
 	if (ret)
-		goto out;
+		goto err_dispose;
 
 	port->type = type;
 	port->uartclk = clk;
@@ -167,7 +167,9 @@ static int of_platform_serial_setup(struct platform_device *ofdev,
 		port->handle_irq = fsl8250_handle_irq;
 
 	return 0;
-out:
+err_dispose:
+	irq_dispose_mapping(port->irq);
+err_unprepare:
 	if (info->clk)
 		clk_disable_unprepare(info->clk);
 	return ret;
@@ -201,7 +203,7 @@ static int of_platform_serial_probe(struct platform_device *ofdev)
 	memset(&port8250, 0, sizeof(port8250));
 	ret = of_platform_serial_setup(ofdev, port_type, &port8250.port, info);
 	if (ret)
-		goto out;
+		goto err_free;
 
 	if (port8250.port.fifosize)
 		port8250.capabilities = UART_CAP_FIFO;
@@ -217,15 +219,18 @@ static int of_platform_serial_probe(struct platform_device *ofdev)
 
 	ret = serial8250_register_8250_port(&port8250);
 	if (ret < 0)
-		goto out;
+		goto err_dispose;
 
 	info->type = port_type;
 	info->line = ret;
 	platform_set_drvdata(ofdev, info);
 	return 0;
-out:
-	kfree(info);
+err_dispose:
 	irq_dispose_mapping(port8250.port.irq);
+	if (info->clk)
+		clk_disable_unprepare(info->clk);
+err_free:
+	kfree(info);
 	return ret;
 }
 
-- 
2.7.4
