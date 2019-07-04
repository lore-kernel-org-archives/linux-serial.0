From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 03/11] serial: sh-sci: use driver core functions, not sysfs ones.
Date: Thu,  4 Jul 2019 10:46:09 +0200
Message-ID: <20190704084617.3602-4-gregkh@linuxfoundation.org>
References: <20190704084617.3602-1-gregkh@linuxfoundation.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190704084617.3602-1-gregkh@linuxfoundation.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

This is a driver, do not call "raw" sysfs functions, instead call driver
core ones.  Specifically convert the use of sysfs_create_file() and
sysfs_remove_file() to use device_create_file() and device_remove_file()

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: linux-serial@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/sh-sci.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index abc705716aa0..69f9072505f7 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -3137,14 +3137,10 @@ static int sci_remove(struct platform_device *dev)
 
 	sci_cleanup_single(port);
 
-	if (port->port.fifosize > 1) {
-		sysfs_remove_file(&dev->dev.kobj,
-				  &dev_attr_rx_fifo_trigger.attr);
-	}
-	if (type == PORT_SCIFA || type == PORT_SCIFB || type == PORT_HSCIF) {
-		sysfs_remove_file(&dev->dev.kobj,
-				  &dev_attr_rx_fifo_timeout.attr);
-	}
+	if (port->port.fifosize > 1)
+		device_remove_file(&dev->dev, &dev_attr_rx_fifo_trigger);
+	if (type == PORT_SCIFA || type == PORT_SCIFB || type == PORT_HSCIF)
+		device_remove_file(&dev->dev, &dev_attr_rx_fifo_timeout);
 
 	return 0;
 }
@@ -3332,19 +3328,17 @@ static int sci_probe(struct platform_device *dev)
 		return ret;
 
 	if (sp->port.fifosize > 1) {
-		ret = sysfs_create_file(&dev->dev.kobj,
-				&dev_attr_rx_fifo_trigger.attr);
+		ret = device_create_file(&dev->dev, &dev_attr_rx_fifo_trigger);
 		if (ret)
 			return ret;
 	}
 	if (sp->port.type == PORT_SCIFA || sp->port.type == PORT_SCIFB ||
 	    sp->port.type == PORT_HSCIF) {
-		ret = sysfs_create_file(&dev->dev.kobj,
-				&dev_attr_rx_fifo_timeout.attr);
+		ret = device_create_file(&dev->dev, &dev_attr_rx_fifo_timeout);
 		if (ret) {
 			if (sp->port.fifosize > 1) {
-				sysfs_remove_file(&dev->dev.kobj,
-					&dev_attr_rx_fifo_trigger.attr);
+				device_remove_file(&dev->dev,
+						   &dev_attr_rx_fifo_trigger);
 			}
 			return ret;
 		}
-- 
2.22.0
