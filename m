From: Johan Hovold <johan@kernel.org>
Subject: [PATCH 5/8] serdev: ttyport: fix tty locking in close
Date: Fri,  3 Nov 2017 15:30:56 +0100
Message-ID: <20171103143059.20749-6-johan@kernel.org>
References: <20171103143059.20749-1-johan@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171103143059.20749-1-johan@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
List-Id: linux-serial@vger.kernel.org

Make sure to hold the tty lock as required when calling tty-driver
close() (e.g. to avoid racing with hangup()).

Note that the serport active flag is currently set under the lock at
controller open, but really isn't protected by it.

Fixes: cd6484e1830b ("serdev: Introduce new bus for serial attached devices")
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/tty/serdev/serdev-ttyport.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/serdev/serdev-ttyport.c b/drivers/tty/serdev/serdev-ttyport.c
index 31c05665a0e6..334bce00364f 100644
--- a/drivers/tty/serdev/serdev-ttyport.c
+++ b/drivers/tty/serdev/serdev-ttyport.c
@@ -162,8 +162,10 @@ static void ttyport_close(struct serdev_controller *ctrl)
 
 	clear_bit(SERPORT_ACTIVE, &serport->flags);
 
+	tty_lock(tty);
 	if (tty->ops->close)
 		tty->ops->close(tty, NULL);
+	tty_unlock(tty);
 
 	tty_release_struct(tty, serport->tty_idx);
 }
-- 
2.15.0
