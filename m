From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 49/76] tty: serial: altera_jtaguart: Fixup type usage of port flags
Date: Wed, 16 Mar 2011 14:12:19 -0700
Message-ID: <1300309966-5745-49-git-send-email-gregkh@suse.de>
References: <20110316205746.GA2938@kroah.com>
 <1300309966-5745-1-git-send-email-gregkh@suse.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:33001 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754904Ab1CPVOh (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 16 Mar 2011 17:14:37 -0400
In-Reply-To: <1300309966-5745-1-git-send-email-gregkh@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Tobias Klauser <tklauser@distanz.ch>, Greg Kroah-Hartman <gregkh@suse.de>

From: Tobias Klauser <tklauser@distanz.ch>

port->flags is of type upf_t, which corresponds to UPF_* flags.

Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/tty/serial/altera_jtaguart.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/tty/serial/altera_jtaguart.c b/drivers/tty/serial/altera_jtaguart.c
index aa2a4ca..8f014bb 100644
--- a/drivers/tty/serial/altera_jtaguart.c
+++ b/drivers/tty/serial/altera_jtaguart.c
@@ -445,7 +445,7 @@ static int __devinit altera_jtaguart_probe(struct platform_device *pdev)
 	port->type = PORT_ALTERA_JTAGUART;
 	port->iotype = SERIAL_IO_MEM;
 	port->ops = &altera_jtaguart_ops;
-	port->flags = ASYNC_BOOT_AUTOCONF;
+	port->flags = UPF_BOOT_AUTOCONF;
 
 	uart_add_one_port(&altera_jtaguart_driver, port);
 
-- 
1.7.4.1

