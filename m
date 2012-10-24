From: Ivo Sieben <meltedpianoman@gmail.com>
Subject: [PATCH] [tty]: Report warning when low_latency flag is wrongly used
Date: Wed, 24 Oct 2012 14:35:42 +0200
Message-ID: <1351082142-28633-1-git-send-email-meltedpianoman@gmail.com>
References: <20121023111659.6f4427c7@bob.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-rt-users-owner@vger.kernel.org>
In-Reply-To: <20121023111659.6f4427c7@bob.linux.org.uk>
Sender: linux-rt-users-owner@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, RT <linux-rt-users@vger.kernel.org>
Cc: Ivo Sieben <meltedpianoman@gmail.com>
List-Id: linux-serial@vger.kernel.org

When a driver has the low_latency flag set and uses the schedule_flip()
function to initiate copying data to the line discipline, a workqueue is
scheduled in but never actually flushed. This is incorrect use of the
low_latency flag (driver should not support the low_latency flag, or use
the tty_flip_buffer_push() function instead). Make sure a warning is
reported to catch incorrect use of the low_latency flag.

This patch goes with: cee4ad1ed90a0959fc29f9d30a2526e5e9522cfa

Signed-off-by: Ivo Sieben <meltedpianoman@gmail.com>

---
 drivers/tty/tty_buffer.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/tty_buffer.c b/drivers/tty/tty_buffer.c
index 06725f5..6cf87d7 100644
--- a/drivers/tty/tty_buffer.c
+++ b/drivers/tty/tty_buffer.c
@@ -365,6 +365,7 @@ void tty_schedule_flip(struct tty_struct *tty)
 {
 	struct tty_bufhead *buf = &tty->port->buf;
 	unsigned long flags;
+	WARN_ON(tty->low_latency);
 
 	spin_lock_irqsave(&buf->lock, flags);
 	if (buf->tail != NULL)
-- 
1.7.9.5


