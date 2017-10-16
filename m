From: Johan Hovold <johan@kernel.org>
Subject: [PATCH 2/2] serdev: ttyport: add missing open() error handling
Date: Mon, 16 Oct 2017 15:06:20 +0200
Message-ID: <20171016130620.5404-2-johan@kernel.org>
References: <20171016130620.5404-1-johan@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171016130620.5404-1-johan@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
List-Id: linux-serial@vger.kernel.org

Add missing error handling for tty-driver open() which may fail (e.g. if
resource allocation fails or if a port is being disconnected).

Note that close() must be called also in case of failed open() and that
the operation sanity check is amended to catch buggy drivers.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/tty/serdev/serdev-ttyport.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serdev/serdev-ttyport.c b/drivers/tty/serdev/serdev-ttyport.c
index 404f3fd070a7..5b09ce920117 100644
--- a/drivers/tty/serdev/serdev-ttyport.c
+++ b/drivers/tty/serdev/serdev-ttyport.c
@@ -96,16 +96,21 @@ static int ttyport_open(struct serdev_controller *ctrl)
 	struct serport *serport = serdev_controller_get_drvdata(ctrl);
 	struct tty_struct *tty;
 	struct ktermios ktermios;
+	int ret;
 
 	tty = tty_init_dev(serport->tty_drv, serport->tty_idx);
 	if (IS_ERR(tty))
 		return PTR_ERR(tty);
 	serport->tty = tty;
 
-	if (!tty->ops->open)
+	if (!tty->ops->open || !tty->ops->close) {
+		ret = -ENODEV;
 		goto err_unlock;
+	}
 
-	tty->ops->open(serport->tty, NULL);
+	ret = tty->ops->open(serport->tty, NULL);
+	if (ret)
+		goto err_close;
 
 	/* Bring the UART into a known 8 bits no parity hw fc state */
 	ktermios = tty->termios;
@@ -123,11 +128,13 @@ static int ttyport_open(struct serdev_controller *ctrl)
 	tty_unlock(serport->tty);
 	return 0;
 
+err_close:
+	tty->ops->close(tty, NULL);
 err_unlock:
 	tty_unlock(tty);
 	tty_release_struct(tty, serport->tty_idx);
 
-	return -ENODEV;
+	return ret;
 }
 
 static void ttyport_close(struct serdev_controller *ctrl)
-- 
2.14.2
