From: Johan Hovold <johan@kernel.org>
Subject: [PATCH] serdev: ttyport: call tiocmget and tiocmset ops directly
Date: Wed, 30 Jan 2019 10:52:03 +0100
Message-ID: <20190130095203.4402-1-johan@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
List-Id: linux-serial@vger.kernel.org

The tty struct holds a pointer to the driver's tty operations so drop
the unnecessary driver dereference when calling tiocmget and tiocmset.

Note that this also makes the calls match the preceding sanity checks as
expected.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/tty/serdev/serdev-ttyport.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serdev/serdev-ttyport.c b/drivers/tty/serdev/serdev-ttyport.c
index fa1672993b4c..d1cdd2ab8b4c 100644
--- a/drivers/tty/serdev/serdev-ttyport.c
+++ b/drivers/tty/serdev/serdev-ttyport.c
@@ -233,7 +233,7 @@ static int ttyport_get_tiocm(struct serdev_controller *ctrl)
 	if (!tty->ops->tiocmget)
 		return -ENOTSUPP;
 
-	return tty->driver->ops->tiocmget(tty);
+	return tty->ops->tiocmget(tty);
 }
 
 static int ttyport_set_tiocm(struct serdev_controller *ctrl, unsigned int set, unsigned int clear)
@@ -244,7 +244,7 @@ static int ttyport_set_tiocm(struct serdev_controller *ctrl, unsigned int set, u
 	if (!tty->ops->tiocmset)
 		return -ENOTSUPP;
 
-	return tty->driver->ops->tiocmset(tty, set, clear);
+	return tty->ops->tiocmset(tty, set, clear);
 }
 
 static const struct serdev_controller_ops ctrl_ops = {
-- 
2.20.1
