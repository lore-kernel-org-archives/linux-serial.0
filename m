From: "Ji-Ze Hong (Peter Hong)" <hpeter@gmail.com>
Subject: [PATCH V1 3/3] serial: 8250_fintek: fix warning reported from smatch
Date: Tue,  3 Oct 2017 11:08:35 +0800
Message-ID: <1507000116-13682-4-git-send-email-hpeter+linux_kernel@gmail.com>
References: <1507000116-13682-1-git-send-email-hpeter+linux_kernel@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1507000116-13682-1-git-send-email-hpeter+linux_kernel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.com
Cc: rel+kernel@agilox.net, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, peter_hong@fintek.com.tw, "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
List-Id: linux-serial@vger.kernel.org

This patch is fix the warning reported by smatch as following:

drivers/tty/serial/8250/8250_fintek.c:294 fintek_8250_goto_highspeed()
warn: inconsistent indenting

Signed-off-by: Ji-Ze Hong (Peter Hong) <hpeter+linux_kernel@gmail.com>
---
 drivers/tty/serial/8250/8250_fintek.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_fintek.c b/drivers/tty/serial/8250/8250_fintek.c
index f3b622f..96cc45f 100644
--- a/drivers/tty/serial/8250/8250_fintek.c
+++ b/drivers/tty/serial/8250/8250_fintek.c
@@ -290,7 +290,7 @@ static void fintek_8250_goto_highspeed(struct uart_8250_port *uart,
 			F81866_UART_CLK_MASK,
 			F81866_UART_CLK_14_769MHZ);
 
-			uart->port.uartclk = 921600 * 16;
+		uart->port.uartclk = 921600 * 16;
 		break;
 	default: /* leave clock speed untouched */
 		break;
-- 
1.9.1
