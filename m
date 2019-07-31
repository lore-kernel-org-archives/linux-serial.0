From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] serial: sh-sci: Use DEVICE_ATTR_RW() for rx_fifo_trigger
Date: Wed, 31 Jul 2019 14:45:55 +0200
Message-ID: <20190731124555.14349-1-geert+renesas@glider.be>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: Joe Perches <joe@perches.com>, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>, linux-serial@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

While commit b6b996b6cdeecf7e ("treewide: Use DEVICE_ATTR_RW") converted
the rx_fifo_timeout attribute, it forgot to convert rx_fifo_trigger due
to a slightly different function naming.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/tty/serial/sh-sci.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index d18c680aa64b3427..57638175639e0f3f 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1092,9 +1092,8 @@ static void rx_fifo_timer_fn(struct timer_list *t)
 	scif_set_rtrg(port, 1);
 }
 
-static ssize_t rx_trigger_show(struct device *dev,
-			       struct device_attribute *attr,
-			       char *buf)
+static ssize_t rx_fifo_trigger_show(struct device *dev,
+				    struct device_attribute *attr, char *buf)
 {
 	struct uart_port *port = dev_get_drvdata(dev);
 	struct sci_port *sci = to_sci_port(port);
@@ -1102,10 +1101,9 @@ static ssize_t rx_trigger_show(struct device *dev,
 	return sprintf(buf, "%d\n", sci->rx_trigger);
 }
 
-static ssize_t rx_trigger_store(struct device *dev,
-				struct device_attribute *attr,
-				const char *buf,
-				size_t count)
+static ssize_t rx_fifo_trigger_store(struct device *dev,
+				     struct device_attribute *attr,
+				     const char *buf, size_t count)
 {
 	struct uart_port *port = dev_get_drvdata(dev);
 	struct sci_port *sci = to_sci_port(port);
@@ -1123,7 +1121,7 @@ static ssize_t rx_trigger_store(struct device *dev,
 	return count;
 }
 
-static DEVICE_ATTR(rx_fifo_trigger, 0644, rx_trigger_show, rx_trigger_store);
+static DEVICE_ATTR_RW(rx_fifo_trigger);
 
 static ssize_t rx_fifo_timeout_show(struct device *dev,
 			       struct device_attribute *attr,
-- 
2.17.1
