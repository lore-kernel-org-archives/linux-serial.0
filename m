From: Tobias Klauser <tklauser@distanz.ch>
Subject: [PATCH 4/5] tty: serial: altera_jtaguart: Fixup type usage of port flags
Date: Thu, 17 Feb 2011 21:29:33 +0100
Message-ID: <6ec5e2b660dbacc52e89611f19c3e0e11e8ffd69.1297974227.git.tklauser@distanz.ch>
References: <cover.1297974227.git.tklauser@distanz.ch>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mx1.zhaw.ch ([160.85.104.50]:39303 "EHLO mx1.zhaw.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753837Ab1BQU3e (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 17 Feb 2011 15:29:34 -0500
In-Reply-To: <cover.1297974227.git.tklauser@distanz.ch>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@suse.de>, linux-serial@vger.kernel.org
Cc: nios2-dev@sopc.et.ntust.edu.tw

port->flags is of type upf_t, which corresponds to UPF_* flags.

Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
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
1.7.0.4

