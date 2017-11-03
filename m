From: Johan Hovold <johan@kernel.org>
Subject: [PATCH 8/8] serdev: ttyport: do not used keyed wakeup in write_wakeup
Date: Fri,  3 Nov 2017 15:30:59 +0100
Message-ID: <20171103143059.20749-9-johan@kernel.org>
References: <20171103143059.20749-1-johan@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171103143059.20749-1-johan@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
List-Id: linux-serial@vger.kernel.org

Serdev does not use the file abstraction and specifically there will
never be anyone polling a file descriptor for POLLOUT events.

Just use plain wake_up_interruptible() in the write_wakeup callback and
document why it's there.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/tty/serdev/serdev-ttyport.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serdev/serdev-ttyport.c b/drivers/tty/serdev/serdev-ttyport.c
index 727664ef456c..ec07b903b7e5 100644
--- a/drivers/tty/serdev/serdev-ttyport.c
+++ b/drivers/tty/serdev/serdev-ttyport.c
@@ -67,7 +67,8 @@ static void ttyport_write_wakeup(struct tty_port *port)
 	    test_bit(SERPORT_ACTIVE, &serport->flags))
 		serdev_controller_write_wakeup(ctrl);
 
-	wake_up_interruptible_poll(&tty->write_wait, POLLOUT);
+	/* Wake up any tty_wait_until_sent() */
+	wake_up_interruptible(&tty->write_wait);
 
 	tty_kref_put(tty);
 }
-- 
2.15.0
