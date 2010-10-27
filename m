From: Mike Frysinger <vapier@gentoo.org>
Subject: [PATCH 4/4] serial: bfin_5xx: grab port lock before making port termios changes
Date: Wed, 27 Oct 2010 04:16:50 -0400
Message-ID: <1288167410-31554-5-git-send-email-vapier@gentoo.org>
References: <1288167410-31554-1-git-send-email-vapier@gentoo.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp.gentoo.org ([140.211.166.183]:53090 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759526Ab0J0IQq (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 27 Oct 2010 04:16:46 -0400
In-Reply-To: <1288167410-31554-1-git-send-email-vapier@gentoo.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: uclinux-dist-devel@blackfin.uclinux.org, Sonic Zhang <sonic.zhang@analog.com>

From: Sonic Zhang <sonic.zhang@analog.com>

The port lock exists to protect these resources, so we need to grab it
before making changes.

Signed-off-by: Sonic Zhang <sonic.zhang@analog.com>
Signed-off-by: Mike Frysinger <vapier@gentoo.org>
---
 drivers/serial/bfin_5xx.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/serial/bfin_5xx.c b/drivers/serial/bfin_5xx.c
index c6774de..80f15ca 100644
--- a/drivers/serial/bfin_5xx.c
+++ b/drivers/serial/bfin_5xx.c
@@ -851,6 +851,8 @@ bfin_serial_set_termios(struct uart_port *port, struct ktermios *termios,
 	if (termios->c_cflag & CMSPAR)
 		lcr |= STP;
 
+	spin_lock_irqsave(&uart->port.lock, flags);
+
 	port->read_status_mask = OE;
 	if (termios->c_iflag & INPCK)
 		port->read_status_mask |= (FE | PE);
@@ -880,8 +882,6 @@ bfin_serial_set_termios(struct uart_port *port, struct ktermios *termios,
 	if (termios->c_line != N_IRDA)
 		quot -= ANOMALY_05000230;
 
-	spin_lock_irqsave(&uart->port.lock, flags);
-
 	UART_SET_ANOMALY_THRESHOLD(uart, USEC_PER_SEC / baud * 15);
 
 	/* Disable UART */
-- 
1.7.3.2

