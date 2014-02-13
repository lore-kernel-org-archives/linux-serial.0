From: Alexander Shiyan <shc_work@mail.ru>
Subject: [PATCH v2] serial: max310x: Fix build error
Date: Thu, 13 Feb 2014 23:12:48 +0400
Message-ID: <1392318768-3190-1-git-send-email-shc_work@mail.ru>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from fallback8.mail.ru ([94.100.176.136]:41578 "EHLO
	fallback8.mail.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750809AbaBMTQr (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 13 Feb 2014 14:16:47 -0500
Received: from smtp9.mail.ru (smtp9.mail.ru [94.100.176.54])
	by fallback8.mail.ru (mPOP.Fallback_MX) with ESMTP id 5FFA5508E746
	for <linux-serial@vger.kernel.org>; Thu, 13 Feb 2014 23:13:13 +0400 (MSK)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Alexander Shiyan <shc_work@mail.ru>

This is a temporary solution to fix following issue:
config: make ARCH=alpha allyesconfig

All error/warnings:

 drivers/tty/serial/max310x.c: In function 'max310x_ioctl':
>> drivers/tty/serial/max310x.c:905:7: error: 'TIOCSRS485' undeclared (first use in this function)
 drivers/tty/serial/max310x.c:905:7: note: each undeclared identifier is reported only once for each function it appears in
>> drivers/tty/serial/max310x.c:906:3: error: implicit declaration of function 'copy_from_user' [-Werror=implicit-function-declaration]
>> drivers/tty/serial/max310x.c:929:7: error: 'TIOCGRS485' undeclared (first use in this function)
>> drivers/tty/serial/max310x.c:938:3: error: implicit declaration of function 'copy_to_user' [-Werror=implicit-function-declaration]
 cc1: some warnings being treated as errors

Reported-by: kbuild test robot <fengguang.wu@intel.com>
Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
Greg, this is a v2, so please revert previous fix first.
Sorry for noise. Thanks.
---
 drivers/tty/serial/max310x.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index 8a035d6..38d2fae 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -876,6 +876,7 @@ static void max310x_set_termios(struct uart_port *port,
 static int max310x_ioctl(struct uart_port *port, unsigned int cmd,
 			 unsigned long arg)
 {
+#if defined(TIOCSRS485) && defined(TIOCGRS485)
 	struct serial_rs485 rs485;
 	unsigned int val;
 
@@ -903,7 +904,7 @@ static int max310x_ioctl(struct uart_port *port, unsigned int cmd,
 			max310x_port_update(port, MAX310X_MODE2_REG,
 					    MAX310X_MODE2_ECHOSUPR_BIT, 0);
 		}
-		break;
+		return 0;
 	case TIOCGRS485:
 		memset(&rs485, 0, sizeof(rs485));
 		val = max310x_port_read(port, MAX310X_MODE1_REG);
@@ -916,12 +917,13 @@ static int max310x_ioctl(struct uart_port *port, unsigned int cmd,
 		if (copy_to_user((struct serial_rs485 *)arg, &rs485,
 				 sizeof(rs485)))
 			return -EFAULT;
-		break;
+		return 0;
 	default:
-		return -ENOIOCTLCMD;
+		break;
 	}
+#endif
 
-	return 0;
+	return -ENOIOCTLCMD;
 }
 
 static int max310x_startup(struct uart_port *port)
-- 
1.8.3.2

