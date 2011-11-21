From: Shubhrajyoti D <shubhrajyoti@ti.com>
Subject: [PATCH] OMAP: UART: fix the return type of check_modem_status
Date: Mon, 21 Nov 2011 15:43:28 +0530
Message-ID: <1321870408-6109-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:53238 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755638Ab1KUKNf (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 21 Nov 2011 05:13:35 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id pALADW0r007524
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-serial@vger.kernel.org>; Mon, 21 Nov 2011 04:13:34 -0600
Received: from DBDE71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id pALADWP5015100
	for <linux-serial@vger.kernel.org>; Mon, 21 Nov 2011 15:43:32 +0530 (IST)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Shubhrajyoti D <shubhrajyoti@ti.com>

The function check_modem_status returns an int currently it
is stored in a char.

Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
---
 drivers/tty/serial/omap-serial.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index 5e713d3..f2a1380 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -399,7 +399,7 @@ static unsigned int serial_omap_tx_empty(struct uart_port *port)
 static unsigned int serial_omap_get_mctrl(struct uart_port *port)
 {
 	struct uart_omap_port *up = (struct uart_omap_port *)port;
-	unsigned char status;
+	unsigned int status;
 	unsigned int ret = 0;
 
 	status = check_modem_status(up);
-- 
1.7.1

