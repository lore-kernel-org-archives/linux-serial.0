From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] tty/serial/8250: unlock on error in
 serial8250_register_8250_port()
Date: Tue, 28 Jun 2016 12:15:22 +0300
Message-ID: <20160628091522.GA7720@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
Sender: kernel-janitors-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Yegor Yefremov <yegorslists@googlemail.com>
Cc: Jiri Slaby <jslaby@suse.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Anton Wuerfel <anton.wuerfel@fau.de>, Phillip Raffeck <phillip.raffeck@fau.de>, Peter Hurley <peter@hurleysoftware.com>, Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>, linux-serial@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

We need to unlock before returning here.

Fixes: 4ef03d328769 ('tty/serial/8250: use mctrl_gpio helpers')
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index 13ad5c3..a2b849e 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -1015,8 +1015,10 @@ int serial8250_register_8250_port(struct uart_8250_port *up)
 
 		gpios = mctrl_gpio_init(&uart->port, 0);
 		if (IS_ERR(gpios)) {
-			if (PTR_ERR(gpios) != -ENOSYS)
-				return PTR_ERR(gpios);
+			if (PTR_ERR(gpios) != -ENOSYS) {
+				ret = PTR_ERR(gpios);
+				goto unlock;
+			}
 		} else
 			uart->gpios = gpios;
 
@@ -1068,6 +1070,7 @@ int serial8250_register_8250_port(struct uart_8250_port *up)
 			ret = 0;
 		}
 	}
+unlock:
 	mutex_unlock(&serial_mutex);
 
 	return ret;
