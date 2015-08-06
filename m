From: Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH 2/2] tty: serial: men_z135_uart.c: Don't initialize port->lock
Date: Thu,  6 Aug 2015 09:16:38 +0200
Message-ID: <12fb311fcd1757b779ed0eed009c0eba3b2aa8c0.1438844880.git.jthumshirn@suse.de>
References: <cover.1438844880.git.jthumshirn@suse.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1438844880.git.jthumshirn@suse.de>
In-Reply-To: <cover.1438844880.git.jthumshirn@suse.de>
References: <cover.1438844880.git.jthumshirn@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>, Andreas Werner <andreas.werner@men.de>, Johannes Thumshirn <jthumshirn@suse.de>
List-Id: linux-serial@vger.kernel.org

port->lock get's initialized in uart_add_one_port(), no need to do it
in men_z135_probe().

Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/serial/men_z135_uart.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/tty/serial/men_z135_uart.c b/drivers/tty/serial/men_z135_uart.c
index 5a41b8fb..b90e7b3 100644
--- a/drivers/tty/serial/men_z135_uart.c
+++ b/drivers/tty/serial/men_z135_uart.c
@@ -839,7 +839,6 @@ static int men_z135_probe(struct mcb_device *mdev,
 	uart->port.membase = NULL;
 	uart->mdev = mdev;
 
-	spin_lock_init(&uart->port.lock);
 	spin_lock_init(&uart->lock);
 
 	err = uart_add_one_port(&men_z135_driver, &uart->port);
-- 
2.4.6
