From: Jiri Prchal <jiri.prchal@aksignal.cz>
Subject: [PATCH] serial: prepare for 9bit data
Date: Mon, 23 Sep 2013 14:07:32 +0200
Message-ID: <1379938052-6026-1-git-send-email-jiri.prchal@aksignal.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org
Cc: gregkh@linuxfoundation.org, Jiri Prchal <jiri.prchal@aksignal.cz>, nicolas.ferre@atmel.com
List-Id: linux-serial@vger.kernel.org

This patch adds 9bit data possibility for serial_core. Please confirm that I did it right way at right place. I'll make atmel_serial driver for 9bit data later.

Signed-off-by: Jiri Prchal <jiri.prchal@aksignal.cz>
---
 drivers/tty/serial/serial_core.c    |    4 ++++
 include/uapi/asm-generic/termbits.h |    3 ++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 0f02351..cbe83db 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -283,9 +283,13 @@ uart_update_timeout(struct uart_port *port, unsigned int cflag,
 	case CS7:
 		bits = 9;
 		break;
+	case CS8:
 	default:
 		bits = 10;
 		break; /* CS8 */
+	case CS9:
+		bits = 11;
+		break;
 	}
 
 	if (cflag & CSTOPB)
diff --git a/include/uapi/asm-generic/termbits.h b/include/uapi/asm-generic/termbits.h
index 232b478..120650d 100644
--- a/include/uapi/asm-generic/termbits.h
+++ b/include/uapi/asm-generic/termbits.h
@@ -128,7 +128,7 @@ struct ktermios {
 #define  B38400	0000017
 #define EXTA B19200
 #define EXTB B38400
-#define CSIZE	0000060
+#define CSIZE	004000000060
 #define   CS5	0000000
 #define   CS6	0000020
 #define   CS7	0000040
@@ -157,6 +157,7 @@ struct ktermios {
 #define  B3500000 0010016
 #define  B4000000 0010017
 #define CIBAUD	  002003600000	/* input baud rate */
+#define CS9	  004000000000	/* 9bit data */
 #define CMSPAR	  010000000000	/* mark or space (stick) parity */
 #define CRTSCTS	  020000000000	/* flow control */
 
-- 
1.7.9.5
