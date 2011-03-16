From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 46/76] tty: serial: altera_jtaguart: Don't use plain integer as NULL pointer
Date: Wed, 16 Mar 2011 14:12:16 -0700
Message-ID: <1300309966-5745-46-git-send-email-gregkh@suse.de>
References: <20110316205746.GA2938@kroah.com>
 <1300309966-5745-1-git-send-email-gregkh@suse.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:32879 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754897Ab1CPVOa (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 16 Mar 2011 17:14:30 -0400
In-Reply-To: <1300309966-5745-1-git-send-email-gregkh@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Tobias Klauser <tklauser@distanz.ch>, Greg Kroah-Hartman <gregkh@suse.de>

From: Tobias Klauser <tklauser@distanz.ch>

This fixes a sparse warning.

Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
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
1.7.4.1

