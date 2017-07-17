From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH] serial: sh-sci: Uninitialized versions in sysfs files
Date: Mon, 17 Jul 2017 11:11:23 +0300
Message-ID: <20170717081123.akqck2wmj7m7gtc4@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
Sender: kernel-janitors-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Cc: Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

The kstrtol() function returns -ERANGE as well as -EINVAL so these tests
are not enough.  It's not a super serious bug, but my static checker
correctly complains that the "r" variable might be used uninitialized.

Fixes: 5d23188a473d ("serial: sh-sci: make RX FIFO parameters tunable via sysfs")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index da5ddfc14778..e08b16b070c0 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1085,10 +1085,12 @@ static ssize_t rx_trigger_store(struct device *dev,
 {
 	struct uart_port *port = dev_get_drvdata(dev);
 	struct sci_port *sci = to_sci_port(port);
+	int ret;
 	long r;
 
-	if (kstrtol(buf, 0, &r) == -EINVAL)
-		return -EINVAL;
+	ret = kstrtol(buf, 0, &r);
+	if (ret)
+		return ret;
 
 	sci->rx_trigger = scif_set_rtrg(port, r);
 	if (port->type == PORT_SCIFA || port->type == PORT_SCIFB)
@@ -1116,10 +1118,12 @@ static ssize_t rx_fifo_timeout_store(struct device *dev,
 {
 	struct uart_port *port = dev_get_drvdata(dev);
 	struct sci_port *sci = to_sci_port(port);
+	int ret;
 	long r;
 
-	if (kstrtol(buf, 0, &r) == -EINVAL)
-		return -EINVAL;
+	ret = kstrtol(buf, 0, &r);
+	if (ret)
+		return ret;
 	sci->rx_fifo_timeout = r;
 	scif_set_rtrg(port, 1);
 	if (r > 0)
