From: Alexander Shiyan <shc_work@mail.ru>
Subject: [PATCH 1/2] serial: max310x: Fix sparse warnings
Date: Sat, 15 Feb 2014 14:59:01 +0400
Message-ID: <1392461942-19328-1-git-send-email-shc_work@mail.ru>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp33.i.mail.ru ([94.100.177.93]:40961 "EHLO smtp33.i.mail.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752800AbaBOK7M (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Sat, 15 Feb 2014 05:59:12 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Alexander Shiyan <shc_work@mail.ru>

sparse warnings: (new ones prefixed by >>)

>> drivers/tty/serial/max310x.c:906:45: sparse: incorrect type in argument 2 (different address spaces)
 drivers/tty/serial/max310x.c:906:45: expected void const [noderef] <asn:1>*from
 drivers/tty/serial/max310x.c:906:45: got struct serial_rs485 *<noident>
>> drivers/tty/serial/max310x.c:938:35: sparse: incorrect type in argument 1 (different address spaces)
 drivers/tty/serial/max310x.c:938:35: expected void [noderef] <asn:1>*to
 drivers/tty/serial/max310x.c:938:35: got struct serial_rs485 *<noident>

Reported-by: kbuild test robot <fengguang.wu@intel.com>
Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 drivers/tty/serial/max310x.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index 5836168..471dbc1 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -882,8 +882,7 @@ static int max310x_ioctl(struct uart_port *port, unsigned int cmd,
 
 	switch (cmd) {
 	case TIOCSRS485:
-		if (copy_from_user(&rs485, (struct serial_rs485 *)arg,
-				   sizeof(rs485)))
+		if (copy_from_user(&rs485, (void __user *)arg, sizeof(rs485)))
 			return -EFAULT;
 		if (rs485.delay_rts_before_send > 0x0f ||
 		    rs485.delay_rts_after_send > 0x0f)
@@ -914,8 +913,7 @@ static int max310x_ioctl(struct uart_port *port, unsigned int cmd,
 		val = max310x_port_read(port, MAX310X_HDPIXDELAY_REG);
 		rs485.delay_rts_before_send = val >> 4;
 		rs485.delay_rts_after_send = val & 0x0f;
-		if (copy_to_user((struct serial_rs485 *)arg, &rs485,
-				 sizeof(rs485)))
+		if (copy_to_user((void __user *)arg, &rs485, sizeof(rs485)))
 			return -EFAULT;
 		return 0;
 	default:
-- 
1.8.3.2

