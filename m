From: Zac Storer <zac.3.14159@gmail.com>
Subject: [PATCH 28/28] Drivers: tty: serial: ioc4_serial: fixed a brace coding style issue
Date: Thu, 17 Nov 2011 23:00:24 -0700
Message-ID: <1321596024-10923-1-git-send-email-zac.3.14159@gmail.com>
Return-path: <linux-ia64-owner@vger.kernel.org>
Sender: linux-ia64-owner@vger.kernel.org
To: pfg@sgi.com
Cc: linux-ia64@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Zac Storer <zac.3.14159@gmail.com>
List-Id: linux-serial@vger.kernel.org

Fixed a brace coding style issue.

Signed-off-by: Zac Storer <zac.3.14159@gmail.com>
---
 drivers/tty/serial/ioc4_serial.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/tty/serial/ioc4_serial.c b/drivers/tty/serial/ioc4_serial.c
index 6b36c15..bac4f07 100644
--- a/drivers/tty/serial/ioc4_serial.c
+++ b/drivers/tty/serial/ioc4_serial.c
@@ -2284,7 +2284,7 @@ static inline int do_read(struct uart_port *the_port, unsigned char *buf,
 								NCS_PARITY);
 					}
 					if ((*sc & IOC4_RXSB_FRAME_ERR) &&
-					   (port->ip_notify & N_FRAMING_ERROR)){
+					   (port->ip_notify & N_FRAMING_ERROR)) {
 						ioc4_cb_post_ncs(the_port,
 								NCS_FRAMING);
 					}
-- 
1.7.7.3

