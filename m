From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 3/6] usb-serial: remove NULL check
Date: Sun, 11 Jan 2009 19:48:41 +0000
Message-ID: <20090111194839.16074.51741.stgit@localhost.localdomain>
References: <20090111194656.16074.14975.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:41724 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752355AbZAKTsz (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 11 Jan 2009 14:48:55 -0500
In-Reply-To: <20090111194656.16074.14975.stgit@localhost.localdomain>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: torvalds@osdl.org, linux-serial@vger.kernel.org

From: Alan Cox <alan@redhat.com>

Julia Lawell found a case where a NULL check was misplaced in the
usb-serial code. However as the object in question cannot be NULL the
check can simply be removed.

Signed-off-by: Alan Cox <alan@redhat.com>
---

 drivers/usb/serial/usb-serial.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)


diff --git a/drivers/usb/serial/usb-serial.c b/drivers/usb/serial/usb-serial.c
index 080ade2..cfcfd5a 100644
--- a/drivers/usb/serial/usb-serial.c
+++ b/drivers/usb/serial/usb-serial.c
@@ -511,9 +511,6 @@ static void usb_serial_port_work(struct work_struct *work)
 
 	dbg("%s - port %d", __func__, port->number);
 
-	if (!port)
-		return;
-
 	tty = tty_port_tty_get(&port->port);
 	if (!tty)
 		return;

