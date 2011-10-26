From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 24/79] serial/imx: support to handle break character
Date: Wed, 26 Oct 2011 14:12:29 +0200
Message-ID: <1319631204-23262-24-git-send-email-gregkh@suse.de>
References: <20111026114236.GA22180@kroah.com>
 <1319631204-23262-1-git-send-email-gregkh@suse.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:60972 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932871Ab1JZMNi (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 26 Oct 2011 08:13:38 -0400
In-Reply-To: <1319631204-23262-1-git-send-email-gregkh@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Hui Wang <jason77.wang@gmail.com>, Greg Kroah-Hartman <gregkh@suse.de>

From: Hui Wang <jason77.wang@gmail.com>

The imx UART hardware controller can identify BREAK character and the
imx_set_termios() can accept BRKINT set by users, but current existing
imx_rxint() can't pass BREAK character and TTY_BREAK to the tty layer
as other serial drivers do (8250.c omap_serial.c).

Here add code to handle BREAK character and pass it to tty layer.

To detect error occurrence, i use URXD_ERR to replace (URXD_OVRRUN |
URXD_FRMERR | ...) because any kind of error occurs, URXD_ERR will
always be set to 1.

I put the URXD_BRK to the first place to check since when BREAK error
occurs, not only URXD_BRK is set to 1, but also URXD_PRERR and
URXD_FRMERR are all set to 1. This arrangement can filter out fake
parity and frame errors when BREAK error occurs.

Signed-off-by: Hui Wang <jason77.wang@gmail.com>
Acked-by: Sascha Hauer <s.hauer@pengutronix.de>
Acked-by: Alan Cox <alan@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/tty/serial/imx.c |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 7e91b3d..54ffdc6 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -508,8 +508,10 @@ static irqreturn_t imx_rxint(int irq, void *dev_id)
 		if (uart_handle_sysrq_char(&sport->port, (unsigned char)rx))
 			continue;
 
-		if (rx & (URXD_PRERR | URXD_OVRRUN | URXD_FRMERR) ) {
-			if (rx & URXD_PRERR)
+		if (unlikely(rx & URXD_ERR)) {
+			if (rx & URXD_BRK)
+				sport->port.icount.brk++;
+			else if (rx & URXD_PRERR)
 				sport->port.icount.parity++;
 			else if (rx & URXD_FRMERR)
 				sport->port.icount.frame++;
@@ -524,7 +526,9 @@ static irqreturn_t imx_rxint(int irq, void *dev_id)
 
 			rx &= sport->port.read_status_mask;
 
-			if (rx & URXD_PRERR)
+			if (rx & URXD_BRK)
+				flg = TTY_BREAK;
+			else if (rx & URXD_PRERR)
 				flg = TTY_PARITY;
 			else if (rx & URXD_FRMERR)
 				flg = TTY_FRAME;
-- 
1.7.7

