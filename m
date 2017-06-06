From: Johan Hovold <johan@kernel.org>
Subject: [PATCH 5/9] tty: amiserial: drop broken alt-speed support
Date: Tue,  6 Jun 2017 12:54:37 +0200
Message-ID: <20170606105441.689-6-johan@kernel.org>
References: <20170606105441.689-1-johan@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170606105441.689-1-johan@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>, Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, Samuel Ortiz <samuel@sortiz.org>, "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-serial@vger.kernel.org, Johan Hovold <johan@kernel.org>
List-Id: linux-serial@vger.kernel.org

Setting an alt_speed using the ASYNC_SPD flags has been deprecated since
v2.1.69, and has been broken since v3.10 and commit 6865ff222cca ("TTY:
do not warn about setting speed via SPD_*") without anyone noticing.

Drop the broken alt-speed handling altogether, and add a ratelimited
warning about using TIOCCSERIAL to change speed as being deprecated.

Note that using ASYNC_SPD_CUST is still supported.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/tty/amiserial.c | 23 +++--------------------
 1 file changed, 3 insertions(+), 20 deletions(-)

diff --git a/drivers/tty/amiserial.c b/drivers/tty/amiserial.c
index dea16bb8c46a..9820e20993db 100644
--- a/drivers/tty/amiserial.c
+++ b/drivers/tty/amiserial.c
@@ -570,18 +570,6 @@ static int startup(struct tty_struct *tty, struct serial_state *info)
 	info->xmit.head = info->xmit.tail = 0;
 
 	/*
-	 * Set up the tty->alt_speed kludge
-	 */
-	if ((port->flags & ASYNC_SPD_MASK) == ASYNC_SPD_HI)
-		tty->alt_speed = 57600;
-	if ((port->flags & ASYNC_SPD_MASK) == ASYNC_SPD_VHI)
-		tty->alt_speed = 115200;
-	if ((port->flags & ASYNC_SPD_MASK) == ASYNC_SPD_SHI)
-		tty->alt_speed = 230400;
-	if ((port->flags & ASYNC_SPD_MASK) == ASYNC_SPD_WARP)
-		tty->alt_speed = 460800;
-
-	/*
 	 * and set the speed of the serial port
 	 */
 	change_speed(tty, info, NULL);
@@ -1084,14 +1072,9 @@ static int set_serial_info(struct tty_struct *tty, struct serial_state *state,
 check_and_exit:
 	if (tty_port_initialized(port)) {
 		if (change_spd) {
-			if ((port->flags & ASYNC_SPD_MASK) == ASYNC_SPD_HI)
-				tty->alt_speed = 57600;
-			if ((port->flags & ASYNC_SPD_MASK) == ASYNC_SPD_VHI)
-				tty->alt_speed = 115200;
-			if ((port->flags & ASYNC_SPD_MASK) == ASYNC_SPD_SHI)
-				tty->alt_speed = 230400;
-			if ((port->flags & ASYNC_SPD_MASK) == ASYNC_SPD_WARP)
-				tty->alt_speed = 460800;
+			/* warn about deprecation unless clearing */
+			if (new_serial.flags & ASYNC_SPD_MASK)
+				dev_warn_ratelimited(tty->dev, "use of SPD flags is deprecated\n");
 			change_speed(tty, state, NULL);
 		}
 	} else
-- 
2.13.0
