From: Alexander Shiyan <shc_work@mail.ru>
Subject: [PATCH 2/3] serial: sccnxp: Remove mask termios caps for SW flow control
Date: Mon, 24 Sep 2012 21:12:01 +0400
Message-ID: <1348506722-17457-2-git-send-email-shc_work@mail.ru>
References: <1348506722-17457-1-git-send-email-shc_work@mail.ru>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp24.mail.ru ([94.100.176.177]:36402 "EHLO smtp24.mail.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757238Ab2IXRIV (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 24 Sep 2012 13:08:21 -0400
In-Reply-To: <1348506722-17457-1-git-send-email-shc_work@mail.ru>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Alan Cox <alan@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alexander Shiyan <shc_work@mail.ru>

The kernel will handle IXON/IXOFF/IXANY in software if the hardware
doesn't do it.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 drivers/tty/serial/sccnxp.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/tty/serial/sccnxp.c b/drivers/tty/serial/sccnxp.c
index 478630b..22e9b8f 100644
--- a/drivers/tty/serial/sccnxp.c
+++ b/drivers/tty/serial/sccnxp.c
@@ -531,7 +531,6 @@ static void sccnxp_set_termios(struct uart_port *port,
 
 	/* Mask termios capabilities we don't support */
 	termios->c_cflag &= ~CMSPAR;
-	termios->c_iflag &= ~(IXON | IXOFF | IXANY);
 
 	/* Disable RX & TX, reset break condition, status and FIFOs */
 	sccnxp_port_write(port, SCCNXP_CR_REG, CR_CMD_RX_RESET |
-- 
1.7.8.6

