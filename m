From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH] serial: 8250: Add missing module license for 8250_base.ko
Date: Wed, 23 Sep 2015 09:09:56 -0400
Message-ID: <1443013796-8298-1-git-send-email-peter@hurleysoftware.com>
References: <20150921202346.GA30262@earth.li>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150921202346.GA30262@earth.li>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Mikael Pettersson <mikpelinux@gmail.com>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>, Peter Hurley <peter@hurleysoftware.com>, Jonathan McDowell <noodles@earth.li>
List-Id: linux-serial@vger.kernel.org

From: Jonathan McDowell <noodles@earth.li>

The split of the 8250 driver into a 8250_base/8250.ko resulted in a
lack of a license for the 8250_base.ko module. This caused the module
to fail to load and the kernel to be tainted. Add the appropriate
MODULE_LICENSE to 8250_port.c, which is always compiled into
8250_base.ko

Reported-by: Mikael Pettersson <mikpelinux@gmail.com>
Signed-off-by: Jonathan McDowell <noodles@earth.li>
[pjh: Added MODULE_DESCRIPTION(); resent patch email w/ proper $subject]
Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/serial/8250/8250_port.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 54e6c8d..e34a37f 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -2910,3 +2910,6 @@ int serial8250_console_setup(struct uart_port *port, char *options, bool probe)
 }
 
 #endif /* CONFIG_SERIAL_8250_CONSOLE */
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("8250/16x50 base port operations");
-- 
2.5.3
