From: Mike Frysinger <vapier@gentoo.org>
Subject: [PATCH] serial: bfin_sport_uart: restore transmit frame sync fix
Date: Sat, 28 Aug 2010 16:32:55 -0400
Message-ID: <1283027575-1686-1-git-send-email-vapier@gentoo.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp.gentoo.org ([140.211.166.183]:47547 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751996Ab0H1UXh (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Sat, 28 Aug 2010 16:23:37 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: uclinux-dist-devel@blackfin.uclinux.org, linux-kernel@vger.kernel.org, Sonic Zhang <sonic.zhang@analog.com>

From: Sonic Zhang <sonic.zhang@analog.com>

The large cleanup/rewrite of resources in commit ccf68e59e93181df9353c0cc
accidentally reverted an earlier fix in commit a19e8b205915b2925aca75b.
So restore it here.

Signed-off-by: Sonic Zhang <sonic.zhang@analog.com>
Signed-off-by: Mike Frysinger <vapier@gentoo.org>
---
 drivers/serial/bfin_sport_uart.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/serial/bfin_sport_uart.c b/drivers/serial/bfin_sport_uart.c
index e57fb3d..5318dd3 100644
--- a/drivers/serial/bfin_sport_uart.c
+++ b/drivers/serial/bfin_sport_uart.c
@@ -121,7 +121,7 @@ static int sport_uart_setup(struct sport_uart_port *up, int size, int baud_rate)
 	unsigned int sclk = get_sclk();
 
 	/* Set TCR1 and TCR2, TFSR is not enabled for uart */
-	SPORT_PUT_TCR1(up, (ITFS | TLSBIT | ITCLK));
+	SPORT_PUT_TCR1(up, (LATFS | ITFS | TFSR | TLSBIT | ITCLK));
 	SPORT_PUT_TCR2(up, size + 1);
 	pr_debug("%s TCR1:%x, TCR2:%x\n", __func__, SPORT_GET_TCR1(up), SPORT_GET_TCR2(up));
 
-- 
1.7.2.2

