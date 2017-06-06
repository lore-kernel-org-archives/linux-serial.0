From: Johan Hovold <johan@kernel.org>
Subject: [PATCH 7/9] tty: rocket: drop broken alt-speed support
Date: Tue,  6 Jun 2017 12:54:39 +0200
Message-ID: <20170606105441.689-8-johan@kernel.org>
References: <20170606105441.689-1-johan@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170606105441.689-1-johan@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>, Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, Samuel Ortiz <samuel@sortiz.org>, "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-serial@vger.kernel.org, Johan Hovold <johan@kernel.org>
List-Id: linux-serial@vger.kernel.org

Setting an alt_speed using the ROCKET_SPD flags has been deprecated
since v2.1.69, and has been broken since commit 6865ff222cca ("TTY: do
not warn about setting speed via SPD_*") without anyone noticing.

To make things worse commit 6df3526b6649 ("rocket: first pass at termios
reporting") in v2.6.25 started reporting back the actual baud rate used,
something which also required 38400 to again be set whenever changing a
SPD flag.

Drop the broken alt-speed handling altogether, and add a ratelimited
warning about using TIOCCSERIAL to change speed as being deprecated.

Note that the rocket driver has never supported using a custom divisor
(ASYNC_SPD_CUST equivalent).

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/tty/rocket.c | 27 ++++++---------------------
 1 file changed, 6 insertions(+), 21 deletions(-)

diff --git a/drivers/tty/rocket.c b/drivers/tty/rocket.c
index b51a877da986..20d79a6007d5 100644
--- a/drivers/tty/rocket.c
+++ b/drivers/tty/rocket.c
@@ -947,18 +947,6 @@ static int rp_open(struct tty_struct *tty, struct file *filp)
 
 		tty_port_set_initialized(&info->port, 1);
 
-		/*
-		 * Set up the tty->alt_speed kludge
-		 */
-		if ((info->flags & ROCKET_SPD_MASK) == ROCKET_SPD_HI)
-			tty->alt_speed = 57600;
-		if ((info->flags & ROCKET_SPD_MASK) == ROCKET_SPD_VHI)
-			tty->alt_speed = 115200;
-		if ((info->flags & ROCKET_SPD_MASK) == ROCKET_SPD_SHI)
-			tty->alt_speed = 230400;
-		if ((info->flags & ROCKET_SPD_MASK) == ROCKET_SPD_WARP)
-			tty->alt_speed = 460800;
-
 		configure_r_port(tty, info, NULL);
 		if (C_BAUD(tty)) {
 			sSetDTR(cp);
@@ -1219,23 +1207,20 @@ static int set_config(struct tty_struct *tty, struct r_port *info,
 			return -EPERM;
 		}
 		info->flags = ((info->flags & ~ROCKET_USR_MASK) | (new_serial.flags & ROCKET_USR_MASK));
-		configure_r_port(tty, info, NULL);
 		mutex_unlock(&info->port.mutex);
 		return 0;
 	}
 
+	if ((new_serial.flags ^ info->flags) & ROCKET_SPD_MASK) {
+		/* warn about deprecation, unless clearing */
+		if (new_serial.flags & ROCKET_SPD_MASK)
+			dev_warn_ratelimited(tty->dev, "use of SPD flags is deprecated\n");
+	}
+
 	info->flags = ((info->flags & ~ROCKET_FLAGS) | (new_serial.flags & ROCKET_FLAGS));
 	info->port.close_delay = new_serial.close_delay;
 	info->port.closing_wait = new_serial.closing_wait;
 
-	if ((info->flags & ROCKET_SPD_MASK) == ROCKET_SPD_HI)
-		tty->alt_speed = 57600;
-	if ((info->flags & ROCKET_SPD_MASK) == ROCKET_SPD_VHI)
-		tty->alt_speed = 115200;
-	if ((info->flags & ROCKET_SPD_MASK) == ROCKET_SPD_SHI)
-		tty->alt_speed = 230400;
-	if ((info->flags & ROCKET_SPD_MASK) == ROCKET_SPD_WARP)
-		tty->alt_speed = 460800;
 	mutex_unlock(&info->port.mutex);
 
 	configure_r_port(tty, info, NULL);
-- 
2.13.0
