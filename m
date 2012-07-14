From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 03/12] f81232: correct stubbed termios handler
Date: Sat, 14 Jul 2012 15:32:10 +0100
Message-ID: <20120714143158.26945.78860.stgit@localhost.localdomain>
References: <20120714142740.26945.98609.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:34135 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752655Ab2GNOPR (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 14 Jul 2012 10:15:17 -0400
In-Reply-To: <20120714142740.26945.98609.stgit@localhost.localdomain>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: greg@kroah.com, linux-serial@vger.kernel.org

From: Alan Cox <alan@linux.intel.com>

Signed-off-by: Alan Cox <alan@linux.intel.com>
---

 drivers/usb/serial/f81232.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/serial/f81232.c b/drivers/usb/serial/f81232.c
index 42c604b..79451ee 100644
--- a/drivers/usb/serial/f81232.c
+++ b/drivers/usb/serial/f81232.c
@@ -177,6 +177,7 @@ static void f81232_set_termios(struct tty_struct *tty,
 		return;
 
 	/* Do the real work here... */
+	tty_termios_copy_hw(&tty->termios, old_termios);
 }
 
 static int f81232_tiocmget(struct tty_struct *tty)

