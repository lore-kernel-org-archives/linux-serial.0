From: Konrad Zapalowicz <bergo.torino@gmail.com>
Subject: [PATCH 2/5] serial: jsm: Remove unnecessary if statement
Date: Sun,  9 Nov 2014 02:22:17 +0100
Message-ID: <1415496140-14997-3-git-send-email-bergo.torino@gmail.com>
References: <1415496140-14997-1-git-send-email-bergo.torino@gmail.com>
 <1415496140-14997-2-git-send-email-bergo.torino@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1415496140-14997-2-git-send-email-bergo.torino@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: cascardo@linux.vnet.ibm.com
Cc: gregkh@linuxfoundation.org, jslaby@suse.cz, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Konrad Zapalowicz <bergo.torino@gmail.com>
List-Id: linux-serial@vger.kernel.org

The flow of {neo,cls}_param() shows that at this stage the baud rate
has a non-zero value. This fact makes the if clausule obsolete and
acknowledges it's removal.

Signed-off-by: Konrad Zapalowicz <bergo.torino@gmail.com>
---
 drivers/tty/serial/jsm/jsm_cls.c | 3 ---
 drivers/tty/serial/jsm/jsm_neo.c | 3 ---
 2 files changed, 6 deletions(-)

diff --git a/drivers/tty/serial/jsm/jsm_cls.c b/drivers/tty/serial/jsm/jsm_cls.c
index 3df9112..bfb0681 100644
--- a/drivers/tty/serial/jsm/jsm_cls.c
+++ b/drivers/tty/serial/jsm/jsm_cls.c
@@ -767,9 +767,6 @@ static void cls_param(struct jsm_channel *ch)
 	ier = readb(&ch->ch_cls_uart->ier);
 	uart_lcr = readb(&ch->ch_cls_uart->lcr);
 
-	if (baud == 0)
-		baud = 9600;
-
 	quot = ch->ch_bd->bd_dividend / baud;
 
 	if (quot != 0) {
diff --git a/drivers/tty/serial/jsm/jsm_neo.c b/drivers/tty/serial/jsm/jsm_neo.c
index b9faee7..4b8196d 100644
--- a/drivers/tty/serial/jsm/jsm_neo.c
+++ b/drivers/tty/serial/jsm/jsm_neo.c
@@ -1037,9 +1037,6 @@ static void neo_param(struct jsm_channel *ch)
 	ier = readb(&ch->ch_neo_uart->ier);
 	uart_lcr = readb(&ch->ch_neo_uart->lcr);
 
-	if (baud == 0)
-		baud = 9600;
-
 	quot = ch->ch_bd->bd_dividend / baud;
 
 	if (quot != 0) {
-- 
1.9.1
