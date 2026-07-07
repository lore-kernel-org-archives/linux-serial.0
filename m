Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE9DE416122
	for <linux-serial@vger.kernel.org>; Tue,  7 Jul 2026 14:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783433191; cv=none; b=Uuetbp07/AKUfsbIkFi4JnSGyTfghufVi00jCJsS03112AZB253+npQkjtoI9vvFAvhwfcXn9Ja3m+4NJwACNAa6imbofuCYkVkK2xFhabglB0pEcGvHRnDpzB0YlB2+uKCc8VRb020wuh/D3QKgc+Atss2GJvExC0ldYepPmu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783433191; c=relaxed/simple;
	bh=Fg1ESJNAV5F1fb33xCvmAVNJe6UGUKE9I7ijyEZN3DY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=D9bcjttNieCyEGOii0H/VVgptBpS9G75pofTsU/IpgkI2hfXSM0DHgFUcqYTqZs9SNcaOVd8P4y9BqgN2LHvwkRCL44Mbn+7CcDrnhlwNokV/IKvicu1rmK1u6M6bo19qSyvJDWA5cnlF9SFZO0LXNO6RPWz2jDTN2rAO/AHGVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HMw8LX6A; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HMw8LX6A"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-84780c95e2eso3438380b3a.3
        for <linux-serial@vger.kernel.org>; Tue, 07 Jul 2026 07:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783433189; x=1784037989; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=bze9YJeBzZwYRUlFk08clxubzyw2xawgwLC17PMfX6w=;
        b=HMw8LX6AphDiQWqhkovIy67gh3TqFduJEkzlC9rHukAhNrHalDPSKHgqNCoCjCT/lj
         IU8Kca24Z4s+GXT3LgYxPqMEnJx3UNczWMbqX6N9ocXo5wAOQLXGhUGyULjADPEvb8W5
         evJEGdJKnL8knm/g6W+dnPNUqkOR0zxHwvJkzfZn7Yk+jADTESYKNayU/NlpdJcqwq+u
         pHL+84+FNQYUnYtEGxQ1l+m4Vgb/P6ZQ0DkIno6PwL0OLf1oJYWOhbPGu7a+i4Z6M7Gw
         zs+IPTO39zQuDS4Ao2WsGdLz9KBfy7jWBNKEDxuXCZI9DfAqat2SQlNBYyUn4TFdJnmY
         9eZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783433189; x=1784037989;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=bze9YJeBzZwYRUlFk08clxubzyw2xawgwLC17PMfX6w=;
        b=FfXEqnif5tB9Hi4PJGeNqCh/FM+NakXmV49dRildx8agmvx/3vmi3tgJub0unfWbp3
         0WrE7HFKol4H7kzpn3/CP47mQ9Q+u6uhUTvN1G3/KwY5/fY+3VJoOh4Nousosee6uJee
         W6+7/z+iP3RpvX+1OZgRjuf376czG4SkL2TXB/lriUKQOMLn+soQ8UjMxBP92+AFar+l
         F+KcS7cZGW3DgKb4H4r6hLT4Iz/ep3DfDUgSj/0O7G6VJwz9BP/wpk8CvnjHvrpVfxw4
         EAlB0ntLazt++x4zorvEWNaa++kDLQ5YWNO9LAUdfkhuoPMGyOb6cAow3Q8r86pvt5Sh
         MLFA==
X-Forwarded-Encrypted: i=1; AHgh+RpEhJhKzs9GuCJGm6MH7r5xUdys36kmad4GgwfhXgwucA1uSyF2UKBFGyD+gFU2q9S3cGPyrdU8iMOzdxI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2n79nWjukLYZT7Uzpi9F0FliEVQZM4PEGIQk4cpwGcll/DL8r
	L5G2/xjbX389k5d2KuN1CN+Z+F717u9xNzV2uGn/Q7GjbVMWMdwRFlbN
X-Gm-Gg: AfdE7cmr4MJGkEPhHVLdBpM0BRi/MuRKJ8dGV2uXN2BZ/UQlCF7ym5SkTo6zutqCo6h
	2X3DZhH+xhcH1A34h3Xjw9oqfeKDvruNgo7trkeDsPDNfWTks0C8scal2I6TjL7S3ZEclTd8EwN
	13c2WADasDF7vjipE98f+K9tjWKC4XDJcy2y0UMh1QJzdu3WzY0qRsc5goN2BEDlMANdgB/uSLt
	k61WMFyZRgupTTFL6dk5VAQJvmt1l59U+7TInW8HmIjqOlSOVO1pVQqq8xzgTAvFgAwUKAehvTG
	62cd5FOt4FaIoWmvEyEjtIzZ5VOqM3cotuLK5U2m0/kYRT9Y/OcpIXuJiE7BYibVNIAO1xm+j1q
	rZP3BpbCIcyqMYfXNPMNDvUl3gu2zz0djmAqteqw5x/hR0NYYvBhKBDtU3QMFFvlx28ZZjVRFQC
	sXBxTlq0sQDk4=
X-Received: by 2002:a05:6a00:4c82:b0:847:e2c7:59b6 with SMTP id d2e1a72fcca58-84826be2b43mr5153777b3a.11.1783433188969;
        Tue, 07 Jul 2026 07:06:28 -0700 (PDT)
Received: from [127.0.1.1] ([61.144.108.37])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6b97bbesm5726239b3a.17.2026.07.07.07.06.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 07:06:28 -0700 (PDT)
From: Qiliang Yuan <realwujing@gmail.com>
Date: Tue, 07 Jul 2026 22:06:23 +0800
Subject: [PATCH v6] serial: 8250: fix use-after-free in IRQ chain handling
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260707-bug-221579-8250-shared-irq-race-v6-1-f8c499a90bdd@gmail.com>
X-B4-Tracking: v=1; b=H4sIAN4HTWoC/5XNPU4DMRCG4atErjGaGf/EpuIeEYVjj3ctkSzYY
 QWK9u44aYi2CSnfkeb5zqJxLdzEy+YsKs+llenYwz5tRBzDcWBZUm9BQBYMObn/GiQRmq2Xjgz
 INobKSZb6KWuILI1D1h4g4NaJrnxUzuX7urB76z2Wdprqz3Vwxsv1//aMEqUC7yDGAJTV63AI5
 f05TgdxsWd60KPugTUK+wsbndaeuvX8fU91L7NOWoGzFPza0w96unsxp2DVXmuCvPbMn2dJ3/d
 M99AkpzE7z8i33rIsv9QPBy8OAgAA
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, 
 Anton Vorontsov <avorontsov@ru.mvista.com>, Alan Cox <alan@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 Wang Zhaolong <wangzhaolong@fnnas.com>, Qiliang Yuan <realwujing@gmail.com>
X-Mailer: b4 0.13.0

serial_unlink_irq_chain() holds hash_mutex and calls free_irq() + kfree(i)
on an empty port list.  serial_link_irq_chain() used to release hash_mutex
after serial_get_or_create_irq_info() but before acquiring i->lock, so a
concurrent unlink could see list_empty() as true while a port was being
added, free i, and cause a use-after-free.

Dropping hash_mutex before request_irq() completes also lets another port
on the same IRQ join the chain and run the THRE test while IRQ startup is
still in progress, triggering "Unbalanced enable for IRQ" because
irq_shutdown() in the premature free_irq() path increments desc->depth and
breaks the disable_irq/enable_irq pairing in serial8250_THRE_test().

Hold hash_mutex across the whole first request_irq() completion (including
the error cleanup path) by taking it at the top of serial_link_irq_chain()
via guard(mutex)(&hash_mutex).  serial_unlink_irq_chain() already holds
hash_mutex throughout, so the race is closed.

With hash_mutex now taken by the caller, replace the guard in
serial_get_or_create_irq_info() with lockdep_assert_held() and add
__must_hold(&hash_mutex) for static analysis.

Fixes: 768aec0b5bcc ("serial: 8250: fix shared interrupts issues with SMP and RT kernels")
Reported-by: Wang Zhaolong <wangzhaolong@fnnas.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=221579
Signed-off-by: Qiliang Yuan <realwujing@gmail.com>
---
V5 -> V6:
- Keep guard(mutex) and scoped_guard(spinlock_irq) style instead of
  manual locking; the lock lifecycle fits the scope-based model.

V4 -> V5:
- Add __must_hold(&hash_mutex) annotation to
  serial_get_or_create_irq_info() for static analysis.

V3 -> V4:
- Move cleanup under hash_mutex on request_irq() failure to prevent a
  second port from joining the chain before the irq_info is cleaned up.
- Fix inaccurate description of irq_shutdown() in commit message.

V2 -> V3:
- Hold hash_mutex across the first request_irq() completion to prevent a
  second port from joining the chain and running the shared-IRQ THRE test
  while IRQ startup is still in progress.

V1 -> V2:
- Add Reported-by tag from Wang Zhaolong.

v5: https://lore.kernel.org/r/20260624-bug-221579-8250-shared-irq-race-v5-1-15d841f89e1e@gmail.com
v4: https://lore.kernel.org/r/20260529-bug-221579-8250-shared-irq-race-v4-1-cfda63b4420f@gmail.com
v3: https://lore.kernel.org/r/20260529-bug-221579-8250-shared-irq-race-v3-1-fe4d430862a9@gmail.com
v2: https://lore.kernel.org/r/20260528-bug-221579-8250-shared-irq-race-v2-1-06531202e54d@gmail.com
v1: https://lore.kernel.org/r/20260528-bug-221579-8250-shared-irq-race-v1-1-30980cca02f3@gmail.com
---
 drivers/tty/serial/8250/8250_core.c | 32 +++++++++++++++++++++++++++-----
 1 file changed, 27 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index a428e88938eb7..6fd3bb2eee233 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -131,10 +131,11 @@ static void serial_do_unlink(struct irq_info *i, struct uart_8250_port *up)
  * - allocate a new one, add it to the hashtable and return it.
  */
 static struct irq_info *serial_get_or_create_irq_info(const struct uart_8250_port *up)
+	__must_hold(&hash_mutex)
 {
 	struct irq_info *i;
 
-	guard(mutex)(&hash_mutex);
+	lockdep_assert_held(&hash_mutex);
 
 	hash_for_each_possible(irq_lists, i, node, up->port.irq)
 		if (i->irq == up->port.irq)
@@ -151,19 +152,37 @@ static struct irq_info *serial_get_or_create_irq_info(const struct uart_8250_por
 	return i;
 }
 
+/*
+ * serial_link_irq_chain() hooks the given 8250 port into the IRQ chain.
+ *
+ * hash_mutex must be held from the hash lookup through the first
+ * request_irq() completion.  Dropping it earlier allows a concurrent
+ * serial_unlink_irq_chain() to race in after i->head is published but
+ * before the IRQ is fully set up — another port sharing the IRQ can then
+ * join the chain and run the shared-IRQ THRE test while IRQ startup is
+ * still in progress, triggering an "Unbalanced enable for IRQ" warning
+ * in kernel/irq/manage.c.
+ */
 static int serial_link_irq_chain(struct uart_8250_port *up)
 {
 	struct irq_info *i;
 	int ret;
 
+	guard(mutex)(&hash_mutex);
+
 	i = serial_get_or_create_irq_info(up);
 	if (IS_ERR(i))
 		return PTR_ERR(i);
 
+	/*
+	 * Serialise against the list manipulation in the interrupt handler
+	 * and in serial_unlink_irq_chain().  hash_mutex is still held which
+	 * prevents serial_unlink_irq_chain() from entering and freeing the
+	 * irq_info until the first request_irq() completes.
+	 */
 	scoped_guard(spinlock_irq, &i->lock) {
 		if (i->head) {
 			list_add(&up->list, i->head);
-
 			return 0;
 		}
 
@@ -171,11 +190,14 @@ static int serial_link_irq_chain(struct uart_8250_port *up)
 		i->head = &up->list;
 	}
 
-	ret = request_irq(up->port.irq, serial8250_interrupt, up->port.irqflags, up->port.name, i);
-	if (ret < 0)
+	ret = request_irq(up->port.irq, serial8250_interrupt,
+			  up->port.irqflags, up->port.name, i);
+	if (ret < 0) {
 		serial_do_unlink(i, up);
+		return ret;
+	}
 
-	return ret;
+	return 0;
 }
 
 static void serial_unlink_irq_chain(struct uart_8250_port *up)

---
base-commit: eb3f4b7426cfd2b79d65b7d37155480b32259a11
change-id: 20260528-bug-221579-8250-shared-irq-race-581e4900a178

Best regards,
-- 
Jing Wu <realwujing@gmail.com>

