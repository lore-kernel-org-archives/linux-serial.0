From: David Howells <dhowells@redhat.com>
Subject: [PATCH] Fix an uninitialised variable warning in the 8250 driver
Date: Fri, 14 Nov 2008 16:20:38 +0000
Message-ID: <20081114162038.23016.20581.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753513AbYKNQVb@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org, akpm@linux-foundation.org
Cc: alan@lxorguk.ukuu.org.uk, dhowells@redhat.com, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Fix an uninitialised variable warning in the 8250 driver:

  CC      drivers/serial/8250.o
drivers/serial/8250.c: In function 'serial8250_shutdown':
drivers/serial/8250.c:1612: warning: 'i' may be used uninitialized in this function

This has the added advantage of removing a conditional test from the main path
as the BUG_ON() that indicated the loop dropped off the end is now bypassed in
the event of a successful search.  Indeed that BUG_ON() can now be a BUG() as
the only way to reach it automatically makes its condition true.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 drivers/serial/8250.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)


diff --git a/drivers/serial/8250.c b/drivers/serial/8250.c
index 303272a..62cf7e5 100644
--- a/drivers/serial/8250.c
+++ b/drivers/serial/8250.c
@@ -1620,10 +1620,11 @@ static void serial_unlink_irq_chain(struct uart_8250_port *up)
 	hlist_for_each(n, h) {
 		i = hlist_entry(n, struct irq_info, node);
 		if (i->irq == up->port.irq)
-			break;
+			goto found;
 	}
+	BUG();
 
-	BUG_ON(n == NULL);
+found:
 	BUG_ON(i->head == NULL);
 
 	if (list_empty(i->head))
