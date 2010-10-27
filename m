From: Mike Frysinger <vapier@gentoo.org>
Subject: [PATCH 2/4] serial: bfin_5xx: remove redundant SSYNC to improve TX speed
Date: Wed, 27 Oct 2010 04:16:48 -0400
Message-ID: <1288167410-31554-3-git-send-email-vapier@gentoo.org>
References: <1288167410-31554-1-git-send-email-vapier@gentoo.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp.gentoo.org ([140.211.166.183]:53078 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755215Ab0J0IQn (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 27 Oct 2010 04:16:43 -0400
In-Reply-To: <1288167410-31554-1-git-send-email-vapier@gentoo.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: uclinux-dist-devel@blackfin.uclinux.org, Sonic Zhang <sonic.zhang@analog.com>

From: Sonic Zhang <sonic.zhang@analog.com>

We don't need to force a SSYNC here as the LSR register will already
be updated by the time we get back to reading it.  This speeds up TX
throughput and lowers general system overhead (since SSYNC is system
wide, not peripheral-specific).

Signed-off-by: Sonic Zhang <sonic.zhang@analog.com>
Signed-off-by: Mike Frysinger <vapier@gentoo.org>
---
 drivers/serial/bfin_5xx.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/serial/bfin_5xx.c b/drivers/serial/bfin_5xx.c
index 9ea8265..01315a2 100644
--- a/drivers/serial/bfin_5xx.c
+++ b/drivers/serial/bfin_5xx.c
@@ -359,7 +359,6 @@ static void bfin_serial_tx_chars(struct bfin_serial_port *uart)
 		UART_PUT_CHAR(uart, xmit->buf[xmit->tail]);
 		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
 		uart->port.icount.tx++;
-		SSYNC();
 	}
 
 	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
-- 
1.7.3.2

