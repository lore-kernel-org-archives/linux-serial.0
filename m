From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH 7/8] tty: mxser: Remove unused ASYNC_SHARE_IRQ flag
Date: Sat,  9 Apr 2016 17:53:26 -0700
Message-ID: <1460249607-8014-8-git-send-email-peter@hurleysoftware.com>
References: <1460249607-8014-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1460249607-8014-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Grant Edwards <grant.b.edwards@gmail.com>, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

ASYNC*_SHARE_IRQ is no longer used; remove.

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/mxser.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/tty/mxser.c b/drivers/tty/mxser.c
index 7e8c27b..98d2bd1 100644
--- a/drivers/tty/mxser.c
+++ b/drivers/tty/mxser.c
@@ -2392,7 +2392,6 @@ static int mxser_initbrd(struct mxser_board *brd,
 		if (brd->chip_flag != MOXA_OTHER_UART)
 			mxser_enable_must_enchance_mode(info->ioaddr);
 
-		info->port.flags = ASYNC_SHARE_IRQ;
 		info->type = brd->uart_type;
 
 		process_txrx_fifo(info);
-- 
2.8.1
