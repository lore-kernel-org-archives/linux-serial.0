From: Tobias Klauser <tklauser@distanz.ch>
Subject: [PATCH 1/5] tty: serial: altera_jtaguart: Don't use plain integer as NULL pointer
Date: Thu, 17 Feb 2011 21:28:36 +0100
Message-ID: <5690df685d18d66d7be2eb74ed3c316525c7d8af.1297974227.git.tklauser@distanz.ch>
References: <cover.1297974227.git.tklauser@distanz.ch>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mx1.zhaw.ch ([160.85.104.50]:39264 "EHLO mx1.zhaw.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753837Ab1BQU2h (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 17 Feb 2011 15:28:37 -0500
In-Reply-To: <cover.1297974227.git.tklauser@distanz.ch>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@suse.de>, linux-serial@vger.kernel.org
Cc: nios2-dev@sopc.et.ntust.edu.tw

This fixes a sparse warning.

Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
---
 drivers/tty/serial/altera_jtaguart.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/tty/serial/altera_jtaguart.c b/drivers/tty/serial/altera_jtaguart.c
index f9b49b5..0c0a8b6 100644
--- a/drivers/tty/serial/altera_jtaguart.c
+++ b/drivers/tty/serial/altera_jtaguart.c
@@ -384,7 +384,7 @@ static int __init altera_jtaguart_console_setup(struct console *co,
 	if (co->index < 0 || co->index >= ALTERA_JTAGUART_MAXPORTS)
 		return -EINVAL;
 	port = &altera_jtaguart_ports[co->index].port;
-	if (port->membase == 0)
+	if (port->membase == NULL)
 		return -ENODEV;
 	return 0;
 }
-- 
1.7.0.4

