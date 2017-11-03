From: Johan Hovold <johan@kernel.org>
Subject: [PATCH 1/8] serdev: ttyport: add missing receive_buf sanity checks
Date: Fri,  3 Nov 2017 15:30:52 +0100
Message-ID: <20171103143059.20749-2-johan@kernel.org>
References: <20171103143059.20749-1-johan@kernel.org>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20171103143059.20749-1-johan@kernel.org>
Sender: stable-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>, stable <stable@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

The receive_buf tty-port callback should return the number of bytes
accepted and must specifically never return a negative errno (or a value
larger than the buffer size) to the tty layer.

A serdev driver not providing a receive_buf callback would currently
cause the flush_to_ldisc() worker to spin in a tight loop when the tty
buffer pointers are incremented with -EINVAL (-22) after data has been
received.

A serdev driver occasionally returning a negative errno (or a too large
byte count) could cause information leaks or crashes when accessing
memory outside the tty buffers in consecutive callbacks.

Fixes: cd6484e1830b ("serdev: Introduce new bus for serial attached devices")
Cc: stable <stable@vger.kernel.org>	# 4.11
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/tty/serdev/serdev-ttyport.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serdev/serdev-ttyport.c b/drivers/tty/serdev/serdev-ttyport.c
index 5b09ce920117..b8bc60a251c6 100644
--- a/drivers/tty/serdev/serdev-ttyport.c
+++ b/drivers/tty/serdev/serdev-ttyport.c
@@ -35,11 +35,22 @@ static int ttyport_receive_buf(struct tty_port *port, const unsigned char *cp,
 {
 	struct serdev_controller *ctrl = port->client_data;
 	struct serport *serport = serdev_controller_get_drvdata(ctrl);
+	int ret;
 
 	if (!test_bit(SERPORT_ACTIVE, &serport->flags))
 		return 0;
 
-	return serdev_controller_receive_buf(ctrl, cp, count);
+	ret = serdev_controller_receive_buf(ctrl, cp, count);
+
+	dev_WARN_ONCE(&ctrl->dev, ret < 0 || ret > count,
+				"receive_buf returns %d (count = %zu)\n",
+				ret, count);
+	if (ret < 0)
+		return 0;
+	else if (ret > count)
+		return count;
+
+	return ret;
 }
 
 static void ttyport_write_wakeup(struct tty_port *port)
-- 
2.15.0
