From: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
Subject: [PATCH v2 2/2] serial: sh-sci: Move uart_register_driver call to device probe
Date: Thu, 20 Apr 2017 14:13:01 +0200
Message-ID: <20170420121301.382-3-sjoerd.simons@collabora.co.uk>
References: <20170420121301.382-1-sjoerd.simons@collabora.co.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170420121301.382-1-sjoerd.simons@collabora.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
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

Changes in v2:
- Add locking to prevent issues when two probes run in parallel

 drivers/tty/serial/sh-sci.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 9a47cc4f16a2..f23254add9a7 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -2935,6 +2935,7 @@ static inline int sci_probe_earlyprintk(struct platform_device *pdev)
 
 static const char banner[] __initconst = "SuperH (H)SCI(F) driver initialized";
 
+static DEFINE_MUTEX(sci_uart_registration_lock);
 static struct uart_driver sci_uart_driver = {
 	.owner		= THIS_MODULE,
 	.driver_name	= "sci",
@@ -3063,6 +3064,16 @@ static int sci_probe_single(struct platform_device *dev,
 		return -EINVAL;
 	}
 
+	mutex_lock(&sci_uart_registration_lock);
+	if (!sci_uart_driver.state) {
+		ret = uart_register_driver(&sci_uart_driver);
+		if (ret) {
+			mutex_unlock(&sci_uart_registration_lock);
+			return ret;
+		}
+	}
+	mutex_unlock(&sci_uart_registration_lock);
+
 	ret = sci_init_single(dev, sciport, index, p, false);
 	if (ret)
 		return ret;
@@ -3186,24 +3197,17 @@ static struct platform_driver sci_driver = {
 
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
