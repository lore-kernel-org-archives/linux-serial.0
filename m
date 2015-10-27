From: Denys Vlasenko <dvlasenk@redhat.com>
Subject: [PATCH 07/15] serial/msm_serial: Deinline wait_for_xmitr, save 165 bytes
Date: Tue, 27 Oct 2015 18:46:39 +0100
Message-ID: <1445968007-12616-8-git-send-email-dvlasenk@redhat.com>
References: <1445968007-12616-1-git-send-email-dvlasenk@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1445968007-12616-1-git-send-email-dvlasenk@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Denys Vlasenko <dvlasenk@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Peter Hurley <peter@hurleysoftware.com>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

This function compiles to 141 bytes of machine code.

Signed-off-by: Denys Vlasenko <dvlasenk@redhat.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Peter Hurley <peter@hurleysoftware.com>
CC: Jiri Slaby <jslaby@suse.com>
CC: linux-serial@vger.kernel.org
---
 drivers/tty/serial/msm_serial.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/msm_serial.c b/drivers/tty/serial/msm_serial.c
index b73889c..da6f6e4 100644
--- a/drivers/tty/serial/msm_serial.c
+++ b/drivers/tty/serial/msm_serial.c
@@ -57,7 +57,7 @@ struct msm_port {
 	bool			break_detected;
 };
 
-static inline void wait_for_xmitr(struct uart_port *port)
+static void wait_for_xmitr(struct uart_port *port)
 {
 	while (!(msm_read(port, UART_SR) & UART_SR_TX_EMPTY)) {
 		if (msm_read(port, UART_ISR) & UART_ISR_TX_READY)
-- 
1.8.1.4
