From: Johan Hovold <johan@kernel.org>
Subject: [PATCH RESEND] serdev: ttyport: do not used keyed wakeup in write_wakeup
Date: Mon, 18 Dec 2017 12:00:19 +0100
Message-ID: <20171218110019.21934-1-johan@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
List-Id: linux-serial@vger.kernel.org

Serdev does not use the file abstraction and specifically there will
never be anyone polling a file descriptor for POLLOUT events.

Just use plain wake_up_interruptible() in the write_wakeup callback and
document why it's there.

Signed-off-by: Johan Hovold <johan@kernel.org>
---

Here's a resend of the final patch from the series "[PATCH 0/8] serdev:
receive_buf and locking fixes", which did not apply after the series was
split over 4.15-rc and -next.

Johan


 drivers/tty/serdev/serdev-ttyport.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serdev/serdev-ttyport.c b/drivers/tty/serdev/serdev-ttyport.c
index c2629ab1bbcf..a5abb05be67d 100644
--- a/drivers/tty/serdev/serdev-ttyport.c
+++ b/drivers/tty/serdev/serdev-ttyport.c
@@ -59,7 +59,8 @@ static void ttyport_write_wakeup(struct tty_port *port)
 	    test_bit(SERPORT_ACTIVE, &serport->flags))
 		serdev_controller_write_wakeup(ctrl);
 
-	wake_up_interruptible_poll(&tty->write_wait, POLLOUT);
+	/* Wake up any tty_wait_until_sent() */
+	wake_up_interruptible(&tty->write_wait);
 
 	tty_kref_put(tty);
 }
-- 
2.15.1
