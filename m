Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1A627511A;
	Wed, 11 Jun 2025 10:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749636260; cv=none; b=eMXcoChgkhD8Re0uvDhD7J8TUax4guvEmXkTefcXom7cy4ao2aULXnuzByj6qHABos/9zMQI8zrzunkBCD2OxHteM8eOZY+b2ztQGPiKXJ2aVfpBo6c2D1cdHp2isP5GepbUaYyS0YCAzhW8vCBTtyIAF4NCKIOgKephHhP9KoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749636260; c=relaxed/simple;
	bh=mkbFe4ug8CJGhd1eJ9syIXDg0PrhGmkItDExnX2ZtgQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a9jh7RA59D5mLbooSg5bv/hCkoINVMAbxuywJYxJZGgUx804Fwl1QOvOnh+E85IoGxPoQwlNC3aJYKCaPX8YpFYalR8OLH56j25mOn9P+Lw5igN/s2BNFiELrhuuPaCMqC0Bk89hETv8Ggb0hkkkOyJPtgcSBJTcJSOjReIYQ4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TdfbvpAO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TdfbvpAO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF547C4CEEE;
	Wed, 11 Jun 2025 10:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749636259;
	bh=mkbFe4ug8CJGhd1eJ9syIXDg0PrhGmkItDExnX2ZtgQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TdfbvpAOhZh2f6lZQOKeTNEYGu87bfs1WFtonZBREsYRqXhOjffFVrx7+ju7gm81L
	 T5XMyP0zf/4nTXtKjE9ElznFuPvcN0vfdgvnA/4dnWdq6abzPnFJyWOCbbaPwz30gk
	 wKEp+2GfJtKYPWqZlpUdLhuYFF7hZZHqmcpYJPjPPEBAX3XVpWeLqqUBlVDRMufTIs
	 Z/tPhwmY79XC2QpTdwT6T4FWetFgz7x+0uOd+yd/MJawgTkVF00c6jVkTP+22MSbpJ
	 KrtWgDbTZeQBQyUg/OJmnQET9tltduQMz6On+yAuIQN1fZDYloztgu8lHE+Q9rM1FN
	 Eq/5irU9VWWYg==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 32/33] serial: 8250: use hashtable
Date: Wed, 11 Jun 2025 12:03:18 +0200
Message-ID: <20250611100319.186924-33-jirislaby@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250611100319.186924-1-jirislaby@kernel.org>
References: <20250611100319.186924-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of open-coding the hash table, use the one provided by
hashtable.h. The semantics is the same, except the code needs not to
compute the hash bucket on its own.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/serial/8250/8250_core.c | 24 ++++++++----------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index 10f25bae9f46..a6ecb8575da4 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -13,6 +13,7 @@
  */
 
 #include <linux/acpi.h>
+#include <linux/hashtable.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/ioport.h>
@@ -47,8 +48,8 @@ struct irq_info {
 	struct list_head	*head;
 };
 
-#define NR_IRQ_HASH		32	/* Can be adjusted later */
-static struct hlist_head irq_lists[NR_IRQ_HASH];
+#define IRQ_HASH_BITS		5	/* Can be adjusted later */
+static DEFINE_HASHTABLE(irq_lists, IRQ_HASH_BITS);
 static DEFINE_MUTEX(hash_mutex);	/* Used to walk the hash */
 
 /*
@@ -75,11 +76,8 @@ static irqreturn_t serial8250_interrupt(int irq, void *dev_id)
 
 	l = i->head;
 	do {
-		struct uart_8250_port *up;
-		struct uart_port *port;
-
-		up = list_entry(l, struct uart_8250_port, list);
-		port = &up->port;
+		struct uart_8250_port *up = list_entry(l, struct uart_8250_port, list);
+		struct uart_port *port = &up->port;
 
 		if (port->handle_irq(port)) {
 			handled = 1;
@@ -132,14 +130,11 @@ static void serial_do_unlink(struct irq_info *i, struct uart_8250_port *up)
  */
 static struct irq_info *serial_get_or_create_irq_info(const struct uart_8250_port *up)
 {
-	struct hlist_head *h;
 	struct irq_info *i;
 
 	mutex_lock(&hash_mutex);
 
-	h = &irq_lists[up->port.irq % NR_IRQ_HASH];
-
-	hlist_for_each_entry(i, h, node)
+	hash_for_each_possible(irq_lists, i, node, up->port.irq)
 		if (i->irq == up->port.irq)
 			goto unlock;
 
@@ -150,7 +145,7 @@ static struct irq_info *serial_get_or_create_irq_info(const struct uart_8250_por
 	}
 	spin_lock_init(&i->lock);
 	i->irq = up->port.irq;
-	hlist_add_head(&i->node, h);
+	hash_add(irq_lists, &i->node, i->irq);
 unlock:
 	mutex_unlock(&hash_mutex);
 
@@ -189,13 +184,10 @@ static int serial_link_irq_chain(struct uart_8250_port *up)
 static void serial_unlink_irq_chain(struct uart_8250_port *up)
 {
 	struct irq_info *i;
-	struct hlist_head *h;
 
 	mutex_lock(&hash_mutex);
 
-	h = &irq_lists[up->port.irq % NR_IRQ_HASH];
-
-	hlist_for_each_entry(i, h, node)
+	hash_for_each_possible(irq_lists, i, node, up->port.irq)
 		if (i->irq == up->port.irq)
 			break;
 
-- 
2.49.0

