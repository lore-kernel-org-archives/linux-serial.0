From: Sugaya Taichi <sugaya.taichi@socionext.com>
Subject: [PATCH] serial: Fix an invalid comparing statement
Date: Mon, 27 May 2019 14:01:27 +0900
Message-ID: <1558933288-30023-1-git-send-email-sugaya.taichi@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: Takao Orito <orito.takao@socionext.com>, Kazuhiro Kasai <kasai.kazuhiro@socionext.com>, Shinji Kanematsu <kanematsu.shinji@socionext.com>, Jassi Brar <jaswinder.singh@linaro.org>, Masami Hiramatsu <masami.hiramatsu@linaro.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Sugaya Taichi <sugaya.taichi@socionext.com>
List-Id: linux-serial@vger.kernel.org

Drop the if-statement which refers to 8th bit field of u8 variable.
The bit field is no longer used.

Fixes: ba44dc043004 ("serial: Add Milbeaut serial control")
Reported-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Sugaya Taichi <sugaya.taichi@socionext.com>
---
 drivers/tty/serial/milbeaut_usio.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/tty/serial/milbeaut_usio.c b/drivers/tty/serial/milbeaut_usio.c
index 949ab7e..d7207ab 100644
--- a/drivers/tty/serial/milbeaut_usio.c
+++ b/drivers/tty/serial/milbeaut_usio.c
@@ -56,7 +56,6 @@
 #define MLB_USIO_SSR_FRE		BIT(4)
 #define MLB_USIO_SSR_PE			BIT(5)
 #define MLB_USIO_SSR_REC		BIT(7)
-#define MLB_USIO_SSR_BRK		BIT(8)
 #define MLB_USIO_FCR_FE1		BIT(0)
 #define MLB_USIO_FCR_FE2		BIT(1)
 #define MLB_USIO_FCR_FCL1		BIT(2)
@@ -180,18 +179,14 @@ static void mlb_usio_rx_chars(struct uart_port *port)
 		if (status & MLB_USIO_SSR_ORE)
 			port->icount.overrun++;
 		status &= port->read_status_mask;
-		if (status & MLB_USIO_SSR_BRK) {
-			flag = TTY_BREAK;
+		if (status & MLB_USIO_SSR_PE) {
+			flag = TTY_PARITY;
 			ch = 0;
 		} else
-			if (status & MLB_USIO_SSR_PE) {
-				flag = TTY_PARITY;
+			if (status & MLB_USIO_SSR_FRE) {
+				flag = TTY_FRAME;
 				ch = 0;
-			} else
-				if (status & MLB_USIO_SSR_FRE) {
-					flag = TTY_FRAME;
-					ch = 0;
-				}
+			}
 		if (flag)
 			uart_insert_char(port, status, MLB_USIO_SSR_ORE,
 					 ch, flag);
-- 
1.9.1
