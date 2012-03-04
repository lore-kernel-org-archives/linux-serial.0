From: Matthieu CASTET <castet.matthieu@free.fr>
Subject: [PATCH 8/9] tty : kill receive_room usage in mxser
Date: Sun,  4 Mar 2012 18:59:19 +0100
Message-ID: <1330883960-8563-9-git-send-email-castet.matthieu@free.fr>
References: <1330883960-8563-1-git-send-email-castet.matthieu@free.fr>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:64359 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754594Ab2CDSAD (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 4 Mar 2012 13:00:03 -0500
Received: by wejx9 with SMTP id x9so1931882wej.19
        for <linux-serial@vger.kernel.org>; Sun, 04 Mar 2012 10:00:02 -0800 (PST)
In-Reply-To: <1330883960-8563-1-git-send-email-castet.matthieu@free.fr>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-serial@vger.kernel.org, Felipe Balbi <balbi@ti.com>, Toby Gray <toby.gray@realvnc.com>, Stefan Bigler <stefan.bigler@keymile.com>
Cc: Matthieu CASTET <castet.matthieu@free.fr>

Note this is need checking, the logic is a bit different.

Signed-off-by: Matthieu CASTET <castet.matthieu@free.fr>
---
 drivers/tty/mxser.c |   19 ++++++++-----------
 1 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/tty/mxser.c b/drivers/tty/mxser.c
index 8998d52..f349160 100644
--- a/drivers/tty/mxser.c
+++ b/drivers/tty/mxser.c
@@ -2056,12 +2056,9 @@ static void mxser_receive_chars(struct tty_struct *tty,
 	unsigned char ch, gdl;
 	int ignored = 0;
 	int cnt = 0;
-	int recv_room;
 	int max = 256;
+	int ret;
 
-	recv_room = tty->receive_room;
-	if (recv_room == 0 && !port->ldisc_stop_rx)
-		mxser_stoprx(tty);
 	if (port->board->chip_flag != MOXA_OTHER_UART) {
 
 		if (*status & UART_LSR_SPECIAL)
@@ -2076,13 +2073,13 @@ static void mxser_receive_chars(struct tty_struct *tty,
 
 		if (port->board->chip_flag == MOXA_MUST_MU150_HWID)
 			gdl &= MOXA_MUST_GDL_MASK;
-		if (gdl >= recv_room) {
-			if (!port->ldisc_stop_rx)
-				mxser_stoprx(tty);
-		}
 		while (gdl--) {
 			ch = inb(port->ioaddr + UART_RX);
-			tty_insert_flip_char(tty, ch, 0);
+			ret = tty_insert_flip_char(tty, ch, 0);
+			if (ret != 1) {
+				if (!port->ldisc_stop_rx)
+					mxser_stoprx(tty);
+			}
 			cnt++;
 		}
 		goto end_intr;
@@ -2121,9 +2118,9 @@ intr_old:
 				} else
 					flag = TTY_BREAK;
 			}
-			tty_insert_flip_char(tty, ch, flag);
+			ret = tty_insert_flip_char(tty, ch, flag);
 			cnt++;
-			if (cnt >= recv_room) {
+			if (ret != 1) {
 				if (!port->ldisc_stop_rx)
 					mxser_stoprx(tty);
 				break;
-- 
1.7.9.1

