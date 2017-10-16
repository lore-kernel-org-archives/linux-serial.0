From: Johan Hovold <johan@kernel.org>
Subject: [PATCH 1/2] serdev: ttyport: enforce tty-driver open() requirement
Date: Mon, 16 Oct 2017 15:06:19 +0200
Message-ID: <20171016130620.5404-1-johan@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
List-Id: linux-serial@vger.kernel.org

The tty-driver open routine is mandatory, but the serdev
tty-port-controller implementation did not treat it as such and would
instead fall back to calling tty_port_open() directly.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/tty/serdev/serdev-ttyport.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serdev/serdev-ttyport.c b/drivers/tty/serdev/serdev-ttyport.c
index 302018d67efa..404f3fd070a7 100644
--- a/drivers/tty/serdev/serdev-ttyport.c
+++ b/drivers/tty/serdev/serdev-ttyport.c
@@ -102,10 +102,10 @@ static int ttyport_open(struct serdev_controller *ctrl)
 		return PTR_ERR(tty);
 	serport->tty = tty;
 
-	if (tty->ops->open)
-		tty->ops->open(serport->tty, NULL);
-	else
-		tty_port_open(serport->port, tty, NULL);
+	if (!tty->ops->open)
+		goto err_unlock;
+
+	tty->ops->open(serport->tty, NULL);
 
 	/* Bring the UART into a known 8 bits no parity hw fc state */
 	ktermios = tty->termios;
@@ -122,6 +122,12 @@ static int ttyport_open(struct serdev_controller *ctrl)
 
 	tty_unlock(serport->tty);
 	return 0;
+
+err_unlock:
+	tty_unlock(tty);
+	tty_release_struct(tty, serport->tty_idx);
+
+	return -ENODEV;
 }
 
 static void ttyport_close(struct serdev_controller *ctrl)
-- 
2.14.2
