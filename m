From: Johan Hovold <johan@kernel.org>
Subject: [PATCH 3/9] USB: serial: ftdi_sio: remove broken alt-speed handling
Date: Tue,  6 Jun 2017 12:54:35 +0200
Message-ID: <20170606105441.689-4-johan@kernel.org>
References: <20170606105441.689-1-johan@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170606105441.689-1-johan@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>, Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, Samuel Ortiz <samuel@sortiz.org>, "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-serial@vger.kernel.org, Johan Hovold <johan@kernel.org>
List-Id: linux-serial@vger.kernel.org

Remove the broken alt_speed code, and warn when trying to set the line
speed using TIOCSSERIAL and SPD flags.

The use of SPD flags to set the line speed has been deprecated since
v2.1.69 and support for alt_speed (e.g. "warp") has even been removed
from TTY core in v3.10 by commit 6865ff222cca ("TTY: do not warn about
setting speed via SPD_*"), effectively breaking all driver
implementations of this except for serial core.

Also remove the verbose and outdated comment on how to set baud rates.

Note that setting a custom divisor will continue to work with the
caveat that 38400 must again be selected every time the divisor is
changed since v2.6.24 and commit 669a6db1037e ("USB: ftd_sio: cleanups
and updates for new termios work") which started reporting back the
actual baud rate used.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/ftdi_sio.c | 56 +++++++------------------------------------
 1 file changed, 9 insertions(+), 47 deletions(-)

diff --git a/drivers/usb/serial/ftdi_sio.c b/drivers/usb/serial/ftdi_sio.c
index df5c45a4b1d7..1cec03799cdf 100644
--- a/drivers/usb/serial/ftdi_sio.c
+++ b/drivers/usb/serial/ftdi_sio.c
@@ -1244,42 +1244,13 @@ static __u32 get_ftdi_divisor(struct tty_struct *tty,
 	int div_okay = 1;
 	int baud;
 
-	/*
-	 * The logic involved in setting the baudrate can be cleanly split into
-	 * 3 steps.
-	 * 1. Standard baud rates are set in tty->termios->c_cflag
-	 * 2. If these are not enough, you can set any speed using alt_speed as
-	 * follows:
-	 *    - set tty->termios->c_cflag speed to B38400
-	 *    - set your real speed in tty->alt_speed; it gets ignored when
-	 *      alt_speed==0, (or)
-	 *    - call TIOCSSERIAL ioctl with (struct serial_struct) set as
-	 *	follows:
-	 *      flags & ASYNC_SPD_MASK == ASYNC_SPD_[HI, VHI, SHI, WARP],
-	 *	this just sets alt_speed to (HI: 57600, VHI: 115200,
-	 *	SHI: 230400, WARP: 460800)
-	 * ** Steps 1, 2 are done courtesy of tty_get_baud_rate
-	 * 3. You can also set baud rate by setting custom divisor as follows
-	 *    - set tty->termios->c_cflag speed to B38400
-	 *    - call TIOCSSERIAL ioctl with (struct serial_struct) set as
-	 *	follows:
-	 *      o flags & ASYNC_SPD_MASK == ASYNC_SPD_CUST
-	 *      o custom_divisor set to baud_base / your_new_baudrate
-	 * ** Step 3 is done courtesy of code borrowed from serial.c
-	 *    I should really spend some time and separate + move this common
-	 *    code to serial.c, it is replicated in nearly every serial driver
-	 *    you see.
-	 */
-
-	/* 1. Get the baud rate from the tty settings, this observes
-	      alt_speed hack */
-
 	baud = tty_get_baud_rate(tty);
 	dev_dbg(dev, "%s - tty_get_baud_rate reports speed %d\n", __func__, baud);
 
-	/* 2. Observe async-compatible custom_divisor hack, update baudrate
-	   if needed */
-
+	/*
+	 * Observe deprecated async-compatible custom_divisor hack, update
+	 * baudrate if needed.
+	 */
 	if (baud == 38400 &&
 	    ((priv->flags & ASYNC_SPD_MASK) == ASYNC_SPD_CUST) &&
 	     (priv->custom_divisor)) {
@@ -1288,8 +1259,6 @@ static __u32 get_ftdi_divisor(struct tty_struct *tty,
 			__func__, priv->custom_divisor, baud);
 	}
 
-	/* 3. Convert baudrate to device-specific divisor */
-
 	if (!baud)
 		baud = 9600;
 	switch (priv->chip_type) {
@@ -1529,21 +1498,14 @@ static int set_serial_info(struct tty_struct *tty,
 check_and_exit:
 	write_latency_timer(port);
 
-	if ((priv->flags ^ old_priv.flags) & ASYNC_SPD_MASK) {
-		if ((priv->flags & ASYNC_SPD_MASK) == ASYNC_SPD_HI)
-			tty->alt_speed = 57600;
-		else if ((priv->flags & ASYNC_SPD_MASK) == ASYNC_SPD_VHI)
-			tty->alt_speed = 115200;
-		else if ((priv->flags & ASYNC_SPD_MASK) == ASYNC_SPD_SHI)
-			tty->alt_speed = 230400;
-		else if ((priv->flags & ASYNC_SPD_MASK) == ASYNC_SPD_WARP)
-			tty->alt_speed = 460800;
-		else
-			tty->alt_speed = 0;
-	}
 	if ((priv->flags ^ old_priv.flags) & ASYNC_SPD_MASK ||
 			((priv->flags & ASYNC_SPD_MASK) == ASYNC_SPD_CUST &&
 			 priv->custom_divisor != old_priv.custom_divisor)) {
+
+		/* warn about deprecation unless clearing */
+		if (priv->flags & ASYNC_SPD_MASK)
+			dev_warn_ratelimited(&port->dev, "use of SPD flags is deprecated\n");
+
 		change_speed(tty, port);
 		mutex_unlock(&priv->cfg_lock);
 	}
-- 
2.13.0
