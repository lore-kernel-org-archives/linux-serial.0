From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH] tty/serial: Fix uninitialized variable warning
Date: Mon,  4 Mar 2013 09:35:07 +0800
Message-ID: <1362360907-4439-1-git-send-email-grant.likely@secretlab.ca>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Grant Likely <grant.likely@secretlab.ca>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-serial@vger.kernel.org

drivers/tty/serial/8250/8250.c: In function 'serial_unlink_irq_chain':
drivers/tty/serial/8250/8250.c:1676:19: warning: 'i' may be used uninitialized in this function

There isn't an actual bug here since the function tests the condition
that would cause i to be uninitialized before dereferencing i. However,
at least some versions of GCC complain as shown above. (in my case,
powerpc gcc 2.5.2). Initializing i to NULL makes it clear to GCC and the
casual code reviewer that i will not be dereferenced to a random
address.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
Greg, some may argue that this is a tool problem, not a kernel problem,
but it is useful to me. If anyone objects I'm not going to spend any
time championing for this patch.

g.

 drivers/tty/serial/8250/8250.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250.c b/drivers/tty/serial/8250/8250.c
index 0efc815..cbbedcf 100644
--- a/drivers/tty/serial/8250/8250.c
+++ b/drivers/tty/serial/8250/8250.c
@@ -1673,7 +1673,7 @@ static int serial_link_irq_chain(struct uart_8250_port *up)
 
 static void serial_unlink_irq_chain(struct uart_8250_port *up)
 {
-	struct irq_info *i;
+	struct irq_info *i = NULL;
 	struct hlist_node *n;
 	struct hlist_head *h;
 
-- 
1.7.10.4
