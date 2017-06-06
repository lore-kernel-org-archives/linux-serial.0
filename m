From: Johan Hovold <johan@kernel.org>
Subject: [PATCH 6/9] tty: cyclades: drop broken alt-speed support
Date: Tue,  6 Jun 2017 12:54:38 +0200
Message-ID: <20170606105441.689-7-johan@kernel.org>
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
warning about using TIOCCSERIAL to to change speed as being deprecated.

Note that using ASYNC_SPD_CUST is still supported.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/tty/cyclades.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/tty/cyclades.c b/drivers/tty/cyclades.c
index 104f09c58163..d272bc4e7fb5 100644
--- a/drivers/tty/cyclades.c
+++ b/drivers/tty/cyclades.c
@@ -1975,18 +1975,6 @@ static void cy_set_line_char(struct cyclades_port *info, struct tty_struct *tty)
 	cflag = tty->termios.c_cflag;
 	iflag = tty->termios.c_iflag;
 
-	/*
-	 * Set up the tty->alt_speed kludge
-	 */
-	if ((info->port.flags & ASYNC_SPD_MASK) == ASYNC_SPD_HI)
-		tty->alt_speed = 57600;
-	if ((info->port.flags & ASYNC_SPD_MASK) == ASYNC_SPD_VHI)
-		tty->alt_speed = 115200;
-	if ((info->port.flags & ASYNC_SPD_MASK) == ASYNC_SPD_SHI)
-		tty->alt_speed = 230400;
-	if ((info->port.flags & ASYNC_SPD_MASK) == ASYNC_SPD_WARP)
-		tty->alt_speed = 460800;
-
 	card = info->card;
 	channel = info->line - card->first_line;
 
@@ -2295,12 +2283,16 @@ cy_set_serial_info(struct cyclades_port *info, struct tty_struct *tty,
 		struct serial_struct __user *new_info)
 {
 	struct serial_struct new_serial;
+	int old_flags;
 	int ret;
 
 	if (copy_from_user(&new_serial, new_info, sizeof(new_serial)))
 		return -EFAULT;
 
 	mutex_lock(&info->port.mutex);
+
+	old_flags = info->port.flags;
+
 	if (!capable(CAP_SYS_ADMIN)) {
 		if (new_serial.close_delay != info->port.close_delay ||
 				new_serial.baud_base != info->baud ||
@@ -2332,6 +2324,11 @@ cy_set_serial_info(struct cyclades_port *info, struct tty_struct *tty,
 
 check_and_exit:
 	if (tty_port_initialized(&info->port)) {
+		if ((new_serial.flags ^ old_flags) & ASYNC_SPD_MASK) {
+			/* warn about deprecation unless clearing */
+			if (new_serial.flags & ASYNC_SPD_MASK)
+				dev_warn_ratelimited(tty->dev, "use of SPD flags is deprecated\n");
+		}
 		cy_set_line_char(info, tty);
 		ret = 0;
 	} else {
-- 
2.13.0
