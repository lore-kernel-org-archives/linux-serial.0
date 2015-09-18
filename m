From: Luis de Bethencourt <luis@debethencourt.com>
Subject: [PATCH 3/4] tty: serial: of_serial: Fix module autoload for OF
 platform driver
Date: Fri, 18 Sep 2015 20:03:43 +0200
Message-ID: <20150918180343.GA30791@goodgumbo.baconseed.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

This platform driver has a OF device ID table but the OF module
alias information is not created so module autoloading won't work.

Signed-off-by: Luis de Bethencourt <luisbg@osg.samsung.com>
---
 drivers/tty/serial/of_serial.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/of_serial.c b/drivers/tty/serial/of_serial.c
index 6823df9..c535906 100644
--- a/drivers/tty/serial/of_serial.c
+++ b/drivers/tty/serial/of_serial.c
@@ -350,6 +350,7 @@ static const struct of_device_id of_platform_serial_table[] = {
 #endif
 	{ /* end of list */ },
 };
+MODULE_DEVICE_TABLE(of, of_platform_serial_table);
 
 static struct platform_driver of_platform_serial_driver = {
 	.driver = {
-- 
2.4.6
