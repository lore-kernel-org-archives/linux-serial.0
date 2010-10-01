From: akpm@linux-foundation.org
Subject: [patch 3/3] drivers/serial/serial_core.c: prevent reading uninitialized stack memory
Date: Fri, 01 Oct 2010 14:18:04 -0700
Message-ID: <201010012118.o91LI4lh021287@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:58813 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756642Ab0JAVSo (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 1 Oct 2010 17:18:44 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: greg@kroah.com
Cc: linux-serial@vger.kernel.org, akpm@linux-foundation.org, drosenberg@vsecurity.com, alan@lxorguk.ukuu.org.uk, dan.j.rosenberg@gmail.com

From: Dan Rosenberg <drosenberg@vsecurity.com>

The TIOCGICOUNT device ioctl allows unprivileged users to read
uninitialized stack memory, because the "reserved" member of the
serial_icounter_struct struct declared on the stack is not altered or
zeroed before being copied back to the user.  This patch takes care of it.

Signed-off-by: Dan Rosenberg <dan.j.rosenberg@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Greg KH <greg@kroah.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/serial/serial_core.c |    2 ++
 1 file changed, 2 insertions(+)

diff -puN drivers/serial/serial_core.c~drivers-serial-serial_corec-prevent-reading-uninitialized-stack-memory drivers/serial/serial_core.c
--- a/drivers/serial/serial_core.c~drivers-serial-serial_corec-prevent-reading-uninitialized-stack-memory
+++ a/drivers/serial/serial_core.c
@@ -1081,6 +1081,8 @@ static int uart_get_icount(struct tty_st
 	struct uart_icount cnow;
 	struct uart_port *uport = state->uart_port;
 
+	memset(&icount, 0, sizeof(struct serial_icounter_struct));
+
 	spin_lock_irq(&uport->lock);
 	memcpy(&cnow, &uport->icount, sizeof(struct uart_icount));
 	spin_unlock_irq(&uport->lock);
_
