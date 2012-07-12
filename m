From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 05/10] 8250: propogate the bugs field
Date: Thu, 12 Jul 2012 13:00:06 +0100
Message-ID: <20120712120001.1321.78081.stgit@localhost.localdomain>
References: <20120712115643.1321.63498.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:59534 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030615Ab2GLLnQ (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 12 Jul 2012 07:43:16 -0400
In-Reply-To: <20120712115643.1321.63498.stgit@localhost.localdomain>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: greg@kroah.com, linux-serial@vger.kernel.org

From: Alan Cox <alan@linux.intel.com>

Now we are using the uart_8250_port this is trivial

Signed-off-by: Alan Cox <alan@linux.intel.com>
---

 drivers/tty/serial/8250/8250.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/8250/8250.c b/drivers/tty/serial/8250/8250.c
index 2b24685..ca42d16 100644
--- a/drivers/tty/serial/8250/8250.c
+++ b/drivers/tty/serial/8250/8250.c
@@ -3155,6 +3155,7 @@ int serial8250_register_8250_port(struct uart_8250_port *up)
 		uart->port.regshift     = up->port.regshift;
 		uart->port.iotype       = up->port.iotype;
 		uart->port.flags        = up->port.flags | UPF_BOOT_AUTOCONF;
+		uart->bugs		= up->bugs;
 		uart->port.mapbase      = up->port.mapbase;
 		uart->port.private_data = up->port.private_data;
 		if (up->port.dev)

