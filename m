From: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
Subject: [PATCH 2/2] serial: sh-sci: Move uart_register_driver call to device probe
Date: Fri, 24 Mar 2017 17:26:34 +0100
Message-ID: <20170324162634.8880-3-sjoerd.simons@collabora.co.uk>
References: <20170324162634.8880-1-sjoerd.simons@collabora.co.uk>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20170324162634.8880-1-sjoerd.simons@collabora.co.uk>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.com>
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

 drivers/tty/serial/sh-sci.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 9a47cc4f16a2..7c1c0c08459e 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -3063,6 +3063,12 @@ static int sci_probe_single(struct platform_device *dev,
 		return -EINVAL;
 	}
 
+	if (!sci_uart_driver.state) {
+		ret = uart_register_driver(&sci_uart_driver);
+		if (ret)
+			return ret;
+	}
+
 	ret = sci_init_single(dev, sciport, index, p, false);
 	if (ret)
 		return ret;
@@ -3186,24 +3192,17 @@ static struct platform_driver sci_driver = {
 
 static int __init sci_init(void)
 {
-	int ret;
-
 	pr_info("%s\n", banner);
 
-	ret = uart_register_driver(&sci_uart_driver);
-	if (likely(ret == 0)) {
-		ret = platform_driver_register(&sci_driver);
-		if (unlikely(ret))
-			uart_unregister_driver(&sci_uart_driver);
-	}
-
-	return ret;
+	return platform_driver_register(&sci_driver);
 }
 
 static void __exit sci_exit(void)
 {
 	platform_driver_unregister(&sci_driver);
-	uart_unregister_driver(&sci_uart_driver);
+
+	if (sci_uart_driver.state)
+		uart_unregister_driver(&sci_uart_driver);
 }
 
 #ifdef CONFIG_SERIAL_SH_SCI_CONSOLE
-- 
2.11.0
