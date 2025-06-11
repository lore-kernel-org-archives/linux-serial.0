Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5595D2741B0;
	Wed, 11 Jun 2025 10:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749636252; cv=none; b=Xvp3M+dbTsOMkM0UKO+gprz0TyX3JZsArebKgmbaLb3FtLhrDTzj7FvNFNG2iWL9x7nc2nOzj+XApVtU6h9zRLCLL/RFqngYlXasqtyzfJ7HEN8DMGm6G1qAb/L9jvhuB3nZF1FciIDsPmed0YAwnJB52cF1bZUJeDWNlGyHpWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749636252; c=relaxed/simple;
	bh=rKS+4K+FzL8vD+6uKlsTZAKIzZuyv6esLcxPlYOcUz8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lBV3iIl0pU4VN7eQ1UFB28DLRNtIivrdRvPkq8i/CTSXIlUwthuTr7AxZ0jPyTOpPDOrNK95sMzc8lLM6cR7Z61IR2vOLddMRrc0HYEkDOTY2829xZH8V50oswfSd0zCWSmpHBmklvvTM9j0iXtOp3vRgf+csjprjR3DQP8j4R4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JkGoraFe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JkGoraFe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26DB8C4CEEE;
	Wed, 11 Jun 2025 10:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749636252;
	bh=rKS+4K+FzL8vD+6uKlsTZAKIzZuyv6esLcxPlYOcUz8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JkGoraFewgN/0jEinfQQORzp7pjyDQZcTWLx+TnJwwhZzEWWsiOVS/mpvWtsDs0Fz
	 vnNfgM7UG3gutvJM7W2K2LqRPRPVxM4Vsh0cE+mZ6QHfrc54WBqcld1fU99xlkaoCH
	 +4zwAvOaylq9bc/xU6NzjbUaw1HI5Apds7ajAMPUd4AFNBbT1Tg+BZiF6c8MrUn0uU
	 v5aI+cW1ZMNQIJ1yPQSeaEfVOH5HKQBbkJia/MACp/mqAfPAq/2pTSLuEgMEN8aQhk
	 xSSjIv4FKf0anoN14blA0drnm7pY0p565TsTCMl3sak1x9wlPD/jDrrq1u5ywo5PdY
	 h0MI9AaiEHxXA==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 27/33] serial: 8250: extract serial_get_or_create_irq_info()
Date: Wed, 11 Jun 2025 12:03:13 +0200
Message-ID: <20250611100319.186924-28-jirislaby@kernel.org>
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

This find-or-create-irq part of the serial_link_irq_chain()'s code is
logically bounded and self-standing. For easier-to-follow code flow,
extract the code to a separate function:
serial_get_or_create_irq_info().

This allows for an easier found-an-irq handling -- simple jump to the
'unlock' label and return. That results in one less 'if' levels.

Note when using guard()s in the upcoming patchset, the label can dropped
altogether.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/serial/8250/8250_core.c | 37 ++++++++++++++++++++---------
 1 file changed, 26 insertions(+), 11 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index 7a6050f1c094..d42ceb6ffdc2 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -129,11 +129,15 @@ static void serial_do_unlink(struct irq_info *i, struct uart_8250_port *up)
 	}
 }
 
-static int serial_link_irq_chain(struct uart_8250_port *up)
+/*
+ * Either:
+ * - find the corresponding info in the hashtable and return it, or
+ * - allocate a new one, add it to the hashtable and return it.
+ */
+static struct irq_info *serial_get_or_create_irq_info(const struct uart_8250_port *up)
 {
 	struct hlist_head *h;
 	struct irq_info *i;
-	int ret;
 
 	mutex_lock(&hash_mutex);
 
@@ -141,20 +145,31 @@ static int serial_link_irq_chain(struct uart_8250_port *up)
 
 	hlist_for_each_entry(i, h, node)
 		if (i->irq == up->port.irq)
-			break;
+			goto unlock;
 
+	i = kzalloc(sizeof(*i), GFP_KERNEL);
 	if (i == NULL) {
-		i = kzalloc(sizeof(struct irq_info), GFP_KERNEL);
-		if (i == NULL) {
-			mutex_unlock(&hash_mutex);
-			return -ENOMEM;
-		}
-		spin_lock_init(&i->lock);
-		i->irq = up->port.irq;
-		hlist_add_head(&i->node, h);
+		i = ERR_PTR(-ENOMEM);
+		goto unlock;
 	}
+	spin_lock_init(&i->lock);
+	i->irq = up->port.irq;
+	hlist_add_head(&i->node, h);
+unlock:
 	mutex_unlock(&hash_mutex);
 
+	return i;
+}
+
+static int serial_link_irq_chain(struct uart_8250_port *up)
+{
+	struct irq_info *i;
+	int ret;
+
+	i = serial_get_or_create_irq_info(up);
+	if (IS_ERR(i))
+		return PTR_ERR(i);
+
 	spin_lock_irq(&i->lock);
 
 	if (i->head) {
-- 
2.49.0

