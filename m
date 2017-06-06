From: Johan Hovold <johan@kernel.org>
Subject: [PATCH 2/9] USB: serial: ftdi_sio: simplify TIOCSSERIAL flag logic
Date: Tue,  6 Jun 2017 12:54:34 +0200
Message-ID: <20170606105441.689-3-johan@kernel.org>
References: <20170606105441.689-1-johan@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170606105441.689-1-johan@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>, Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, Samuel Ortiz <samuel@sortiz.org>, "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-serial@vger.kernel.org, Johan Hovold <johan@kernel.org>
List-Id: linux-serial@vger.kernel.org

Simplify TIOCSSERIAL flag logic somewhat.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/ftdi_sio.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/serial/ftdi_sio.c b/drivers/usb/serial/ftdi_sio.c
index aba74f817dc6..df5c45a4b1d7 100644
--- a/drivers/usb/serial/ftdi_sio.c
+++ b/drivers/usb/serial/ftdi_sio.c
@@ -1505,8 +1505,7 @@ static int set_serial_info(struct tty_struct *tty,
 	/* Do error checking and permission checking */
 
 	if (!capable(CAP_SYS_ADMIN)) {
-		if (((new_serial.flags & ~ASYNC_USR_MASK) !=
-		     (priv->flags & ~ASYNC_USR_MASK))) {
+		if ((new_serial.flags ^ priv->flags) & ~ASYNC_USR_MASK) {
 			mutex_unlock(&priv->cfg_lock);
 			return -EPERM;
 		}
@@ -1530,8 +1529,7 @@ static int set_serial_info(struct tty_struct *tty,
 check_and_exit:
 	write_latency_timer(port);
 
-	if ((old_priv.flags & ASYNC_SPD_MASK) !=
-	     (priv->flags & ASYNC_SPD_MASK)) {
+	if ((priv->flags ^ old_priv.flags) & ASYNC_SPD_MASK) {
 		if ((priv->flags & ASYNC_SPD_MASK) == ASYNC_SPD_HI)
 			tty->alt_speed = 57600;
 		else if ((priv->flags & ASYNC_SPD_MASK) == ASYNC_SPD_VHI)
@@ -1543,10 +1541,9 @@ static int set_serial_info(struct tty_struct *tty,
 		else
 			tty->alt_speed = 0;
 	}
-	if (((old_priv.flags & ASYNC_SPD_MASK) !=
-	     (priv->flags & ASYNC_SPD_MASK)) ||
-	    (((priv->flags & ASYNC_SPD_MASK) == ASYNC_SPD_CUST) &&
-	     (old_priv.custom_divisor != priv->custom_divisor))) {
+	if ((priv->flags ^ old_priv.flags) & ASYNC_SPD_MASK ||
+			((priv->flags & ASYNC_SPD_MASK) == ASYNC_SPD_CUST &&
+			 priv->custom_divisor != old_priv.custom_divisor)) {
 		change_speed(tty, port);
 		mutex_unlock(&priv->cfg_lock);
 	}
-- 
2.13.0
