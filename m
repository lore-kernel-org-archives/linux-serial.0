From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 66/75] fix for tty-serial-move-port
Date: Fri, 02 Jan 2009 13:49:32 +0000
Message-ID: <20090102134926.13472.19157.stgit@localhost.localdomain>
References: <20090102133822.13472.53912.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:37677 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757326AbZABNtR (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 2 Jan 2009 08:49:17 -0500
In-Reply-To: <20090102133822.13472.53912.stgit@localhost.localdomain>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: torvalds@osdl.org, linux-serial@vger.kernel.org

From: Alexander Beregalov <a.beregalov@gmail.com>

Hi Alan

next-20081204 crashes with the following message:

BUG: unable to handle kernel paging request at ffff88007d320248
IP: [<ffffffff803de934>] uart_remove_one_port+0xef/0x111
                kfree(info);
     393:       49 8d 7d 10             lea    0x10(%r13),%rdi
     397:       e8 00 00 00 00          callq  39c <uart_remove_one_port+0xef>

Signed-off-by: Alexander Beregalov <a.beregalov@gmail.com>
Signed-off-by: Alan Cox <alan@redhat.com>
---

 drivers/serial/serial_core.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)


diff --git a/drivers/serial/serial_core.c b/drivers/serial/serial_core.c
index daeba1c..9425ed6 100644
--- a/drivers/serial/serial_core.c
+++ b/drivers/serial/serial_core.c
@@ -2530,10 +2530,8 @@ int uart_remove_one_port(struct uart_driver *drv, struct uart_port *port)
 	/*
 	 * Kill the tasklet, and free resources.
 	 */
-	if (info) {
+	if (info)
 		tasklet_kill(&info->tlet);
-		kfree(info);
-	}
 
 	state->port = NULL;
 	mutex_unlock(&port_mutex);

