From: Mike Frysinger <vapier@gentoo.org>
Subject: [PATCH 01/11] Blackfin SPORT UART: fix typo in sport_set_termios prototype
Date: Tue,  2 Jun 2009 03:11:30 -0400
Message-ID: <1243926700-30485-1-git-send-email-vapier@gentoo.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp.gentoo.org ([140.211.166.183]:46606 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754967AbZFBHLp (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 2 Jun 2009 03:11:45 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: uclinux-dist-devel@blackfin.uclinux.org, Bryan Wu <cooloney@kernel.org>

Signed-off-by: Mike Frysinger <vapier@gentoo.org>
Signed-off-by: Bryan Wu <cooloney@kernel.org>
---
 drivers/serial/bfin_sport_uart.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/serial/bfin_sport_uart.c b/drivers/serial/bfin_sport_uart.c
index 529c0ff..fd5cb95 100644
--- a/drivers/serial/bfin_sport_uart.c
+++ b/drivers/serial/bfin_sport_uart.c
@@ -419,7 +419,7 @@ static void sport_shutdown(struct uart_port *port)
 }
 
 static void sport_set_termios(struct uart_port *port,
-		struct termios *termios, struct termios *old)
+		struct ktermios *termios, struct ktermios *old)
 {
 	pr_debug("%s enter, c_cflag:%08x\n", __func__, termios->c_cflag);
 	uart_update_timeout(port, CS8 ,port->uartclk);
-- 
1.6.3.1

