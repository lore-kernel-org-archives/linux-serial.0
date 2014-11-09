From: Konrad Zapalowicz <bergo.torino@gmail.com>
Subject: [PATCH 3/5] serial: jsm: Fix the alignment of the switch satement
Date: Sun,  9 Nov 2014 02:22:18 +0100
Message-ID: <1415496140-14997-4-git-send-email-bergo.torino@gmail.com>
References: <1415496140-14997-1-git-send-email-bergo.torino@gmail.com>
 <1415496140-14997-2-git-send-email-bergo.torino@gmail.com>
 <1415496140-14997-3-git-send-email-bergo.torino@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1415496140-14997-3-git-send-email-bergo.torino@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: cascardo@linux.vnet.ibm.com
Cc: gregkh@linuxfoundation.org, jslaby@suse.cz, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Konrad Zapalowicz <bergo.torino@gmail.com>
List-Id: linux-serial@vger.kernel.org

This commit fixes the alignment of the 'case's i the switch statement.

Signed-off-by: Konrad Zapalowicz <bergo.torino@gmail.com>
---
 drivers/tty/serial/jsm/jsm_neo.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/tty/serial/jsm/jsm_neo.c b/drivers/tty/serial/jsm/jsm_neo.c
index 4b8196d..5de6dffb 100644
--- a/drivers/tty/serial/jsm/jsm_neo.c
+++ b/drivers/tty/serial/jsm/jsm_neo.c
@@ -1019,19 +1019,19 @@ static void neo_param(struct jsm_channel *ch)
 		lcr |= UART_LCR_STOP;
 
 	switch (ch->ch_c_cflag & CSIZE) {
-		case CS5:
-			lcr |= UART_LCR_WLEN5;
-			break;
-		case CS6:
-			lcr |= UART_LCR_WLEN6;
-			break;
-		case CS7:
-			lcr |= UART_LCR_WLEN7;
-			break;
-		case CS8:
-		default:
-			lcr |= UART_LCR_WLEN8;
+	case CS5:
+		lcr |= UART_LCR_WLEN5;
+		break;
+	case CS6:
+		lcr |= UART_LCR_WLEN6;
+		break;
+	case CS7:
+		lcr |= UART_LCR_WLEN7;
 		break;
+	case CS8:
+	default:
+		lcr |= UART_LCR_WLEN8;
+	break;
 	}
 
 	ier = readb(&ch->ch_neo_uart->ier);
-- 
1.9.1
