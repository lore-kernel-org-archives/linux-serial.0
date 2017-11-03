From: Johan Hovold <johan@kernel.org>
Subject: [PATCH 6/8] serdev: ttyport: release tty lock sooner on open
Date: Fri,  3 Nov 2017 15:30:57 +0100
Message-ID: <20171103143059.20749-7-johan@kernel.org>
References: <20171103143059.20749-1-johan@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171103143059.20749-1-johan@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
List-Id: linux-serial@vger.kernel.org

Release the tty lock once tty-driver open returns to make it clear that
it does not protect neither tty->termios or the serport flags.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/tty/serdev/serdev-ttyport.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serdev/serdev-ttyport.c b/drivers/tty/serdev/serdev-ttyport.c
index 334bce00364f..a8ddcd2ac5ea 100644
--- a/drivers/tty/serdev/serdev-ttyport.c
+++ b/drivers/tty/serdev/serdev-ttyport.c
@@ -130,6 +130,8 @@ static int ttyport_open(struct serdev_controller *ctrl)
 	if (ret)
 		goto err_close;
 
+	tty_unlock(serport->tty);
+
 	/* Bring the UART into a known 8 bits no parity hw fc state */
 	ktermios = tty->termios;
 	ktermios.c_iflag &= ~(IGNBRK | BRKINT | PARMRK | ISTRIP |
@@ -143,7 +145,6 @@ static int ttyport_open(struct serdev_controller *ctrl)
 
 	set_bit(SERPORT_ACTIVE, &serport->flags);
 
-	tty_unlock(serport->tty);
 	return 0;
 
 err_close:
-- 
2.15.0
