From: Luis de Bethencourt <luis@debethencourt.com>
Subject: [PATCH 4/4] tty: serial: sprd: Fix module autoload for OF platform
 driver
Date: Fri, 18 Sep 2015 20:04:12 +0200
Message-ID: <20150918180412.GA30800@goodgumbo.baconseed.org>
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
 drivers/tty/serial/sprd_serial.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/sprd_serial.c b/drivers/tty/serial/sprd_serial.c
index 3866516..9dbae01 100644
--- a/drivers/tty/serial/sprd_serial.c
+++ b/drivers/tty/serial/sprd_serial.c
@@ -782,6 +782,7 @@ static const struct of_device_id serial_ids[] = {
 	{.compatible = "sprd,sc9836-uart",},
 	{}
 };
+MODULE_DEVICE_TABLE(of, serial_ids);
 
 static struct platform_driver sprd_platform_driver = {
 	.probe		= sprd_probe,
-- 
2.4.6
