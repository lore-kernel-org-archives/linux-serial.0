Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2845C3F58E7
	for <linux-serial@vger.kernel.org>; Wed,  8 Jul 2026 07:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783494867; cv=none; b=h0lNz5FoU128jyLWzMIuJgnePQMyNSksH+8kML18uhE3iA5qREcfaJBrLuaJ8cTsJlMy4/UexOEEiPP95qBtnjr5TVD7Krk2zf0bfSeTtvpj5Xlxhd2zP4ILM0XE/ikVbnT7liuK5++fGMc2DO7dev4sYHR/8vAX+dpzBzUdEnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783494867; c=relaxed/simple;
	bh=ZMP0AsNyIi3g/Gg6ywrf+2seC6a1MR+4eC5ynYyPbYU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=oBQdE56QSR9uSC2zGBNkl9Gs2G+4v4Uu2aPhEU+kqbpZeZ8Lt8ZNRkfYc91QQ+e6Dsa0YI93W3GTS5s6OVXi1WR3d67nX2WPpTylrqbmRv9V6PiDZVJk4t+Qtrrms9u11lAeUxmqe9hsNwgoySdJsJFS4b+V0vyuHlMgpbggQIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AbW62EZ+; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AbW62EZ+"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8483d01240bso281731b3a.2
        for <linux-serial@vger.kernel.org>; Wed, 08 Jul 2026 00:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783494853; x=1784099653; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lKLygG4qGv8FR12H0KBxqRmX2in8IQ085mqUwvJhRfs=;
        b=AbW62EZ+6veEnniU++JJHdraGNlsdqm/CKKTjv/2GJ3o9P+H8x0pIEJiWU7tZPGixa
         7MDglJmgVmDO0ttkpclHhZI4Bo88syGHR8cj3ci5vy4klsjHppTm7gNJE+zWLZfWQCWU
         iHpS7P4/RgltNR0qvhcXrVjgUgQIkk8iUEAEzEkUKd6vgDCtnD39j9YZJTroDwn8AYF/
         Db8x3xhGPul8RnXO9X1z9RDpDdXbCldYDqnP6s/SlM+E6qda7R935oo0DM2Gi34E36aj
         7jnp2MG+nciRXntfDEGgJ1ckbTOzuWA2LzxqXqmL92g5zyovJJV/dyV0S6KUVaT0fi3i
         JVjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783494853; x=1784099653;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lKLygG4qGv8FR12H0KBxqRmX2in8IQ085mqUwvJhRfs=;
        b=chnohSw82gDx2ktcknKBUJfj77cUtCyaCDYnek1GnmWJwaTNCdZOROgh8RVGQ3v+AW
         JYA+2tTrCmMTBv0ipgdVUm0y+ti9JkiBXeYm+R6JgLR4F7favgGpdE2HTfIE9WqPIHL8
         cSPGX12f21zhpPqYZSLO0LlzliLTC5E8ti48J5zg2QaZ+M/XG7xRZ2wSW30U+cBRc3Ax
         jEdAd3eC8AzP+H/9sav4swYgx3Zzje/1DnI42kh5vvvdtXDbHQ+Gnr41CSQy3lrlt5z6
         OJBRFLTIToz4kphzOL0yH/89i1mog8rNLC3jE4RQqd2cGLDwUYv76mWADMaF3G+hEoZc
         ZFMg==
X-Forwarded-Encrypted: i=1; AHgh+RrJKWSnioBUlqt7Ed4GJNhBLzL8em5nR2kQVcGfRfoP4SOZjHmF/GvY3SOlVfeLTGYGrvBnQs/0dYpyNmg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzEkJifHUuDSFNMhRz0lgszV5I0cfEE33T1ZK2MkfVtl4nhqTv
	8D2GpWtvRbvRDb2kOnwdaGqHgsq+MWTrTmoEXetH/sEyYuiypiJjxsNB
X-Gm-Gg: AfdE7ckQpQ+btHVN5AOtFZQs7Njm+DJZLFRRzDuhuBW4YwDNfbGnuCWaG6bhCzfRpPS
	bTcSv4TmGmdQh6KbHe/9nwKRegJYA1+q4YCdLNsnE0ddahrZbdgTfwBQTZ1o7czjA/qHUAvyyTb
	5PZXhkxh/iJ/3dNuDAoaap516VNiLJhQYgwMaf2iAYPFeXfZO5Fb/vgcTSAyzOcK6KCvzuwLBSp
	dbkCFlceAOSzjWtq8Gv6tztO8mogfwB+3pb63vE6sGxvd1Ge0vw0y8bQmz6GXsNid1h85lhVsPU
	6xdhOw9gWqXRBLAroXr8Yc5s5Z5B2qP1jvKLkxDrwA7MxvAzCNW6oE/h5n60MTNECu5VFPrq9fi
	5jMdKQBUHtfanBSyUlxWL/yGxiDxMc89NcrvZZ/teibuEBmeD0ab+X2O+Iz8ZSTwTX/cNWor4CA
	L0aU/goMvcy20=
X-Received: by 2002:a05:6a00:c88:b0:848:2a71:a48a with SMTP id d2e1a72fcca58-84842ec1f29mr1536331b3a.13.1783494852735;
        Wed, 08 Jul 2026 00:14:12 -0700 (PDT)
Received: from [127.0.1.1] ([61.144.108.37])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6bc9f5dsm6586975b3a.27.2026.07.08.00.14.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 00:14:12 -0700 (PDT)
From: Jing Wu <realwujing@gmail.com>
Date: Wed, 08 Jul 2026 15:14:07 +0800
Subject: [PATCH v7] serial: 8250: fix use-after-free in IRQ chain handling
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260708-bug-221579-8250-shared-irq-race-v7-1-0da8d89f6072@gmail.com>
X-B4-Tracking: v=1; b=H4sIAL74TWoC/5XQTU7DMBAF4KtUXmM0Hv/EZsU9EAvHHieWaFNsi
 EBV7o7TTSGb0OUbab6nmQurVDJV9nS4sEJzrnk6tdA9HFgY/WkgnmPLDAENaLS8/xw4otCd4xY
 18Dr6QpHn8s6LD8S1FaQcgBedZU05F0r569rw8trymOvHVL6vhbNYp/+3Z8EFl+AshOABk3wej
 j6/PYbpyFZ7xjs9bB4YLUVbIa3i1pO/PbfvyeYlUlFJsAa923rqTk81L6TojeyVQkhbT988g2r
 f080TOlolknUkaOuZm9dBt++Z9V4blHPeQR///G9Zlh9ILcHkXgIAAA==
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, 
 Anton Vorontsov <avorontsov@ru.mvista.com>, Alan Cox <alan@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 Wang Zhaolong <wangzhaolong@fnnas.com>, 
 Qiliang Yuan <yuanql9@chinatelecom.cn>, Jing Wu <realwujing@gmail.com>
X-Mailer: b4 0.13.0

serial_unlink_irq_chain() holds irq_chain_mutex and calls free_irq() +
kfree(i) on an empty port list.  serial_link_irq_chain() used to release
irq_chain_mutex after serial_get_or_create_irq_info() but before acquiring
i->lock, so a concurrent unlink could see list_empty() as true while a
port was being added, free i, and cause a use-after-free.

Dropping irq_chain_mutex before request_irq() completes also lets another
port on the same IRQ join the chain and run the THRE test while IRQ
startup is still in progress, triggering "Unbalanced enable for IRQ"
because irq_shutdown() in the premature free_irq() path increments
desc->depth and breaks the disable_irq/enable_irq pairing in
serial8250_THRE_test().

Hold irq_chain_mutex across the whole first request_irq() completion
(including the error cleanup path) by taking it at the top of
serial_link_irq_chain() via guard(mutex)(&irq_chain_mutex).
serial_unlink_irq_chain() already holds irq_chain_mutex throughout, so
the race is closed.

With irq_chain_mutex now taken by the caller, replace the guard in
serial_get_or_create_irq_info() with lockdep_assert_held() and add
__must_hold(&irq_chain_mutex) for static analysis.  Rename hash_mutex to
irq_chain_mutex to reflect its broader role beyond hash table locking.

Fixes: 768aec0b5bcc ("serial: 8250: fix shared interrupts issues with SMP and RT kernels")
Reported-by: Wang Zhaolong <wangzhaolong@fnnas.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=221579
Co-developed-by: Wang Zhaolong <wangzhaolong@fnnas.com>
Signed-off-by: Wang Zhaolong <wangzhaolong@fnnas.com>
Co-developed-by: Qiliang Yuan <yuanql9@chinatelecom.cn>
Signed-off-by: Qiliang Yuan <yuanql9@chinatelecom.cn>
Signed-off-by: Jing Wu <realwujing@gmail.com>
---
V6 -> V7:
- Rename hash_mutex to irq_chain_mutex to reflect its broader role
  beyond hash table locking.
- Drop unrelated blank-line and return-value changes.
- Add Co-developed-by: Wang Zhaolong and Qiliang Yuan.

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

v6: https://lore.kernel.org/r/20260707-bug-221579-8250-shared-irq-race-v6-1-f8c499a90bdd@gmail.com
v5: https://lore.kernel.org/r/20260624-bug-221579-8250-shared-irq-race-v5-1-15d841f89e1e@gmail.com
v4: https://lore.kernel.org/r/20260529-bug-221579-8250-shared-irq-race-v4-1-cfda63b4420f@gmail.com
v3: https://lore.kernel.org/r/20260529-bug-221579-8250-shared-irq-race-v3-1-fe4d430862a9@gmail.com
v2: https://lore.kernel.org/r/20260528-bug-221579-8250-shared-irq-race-v2-1-06531202e54d@gmail.com
v1: https://lore.kernel.org/r/20260528-bug-221579-8250-shared-irq-race-v1-1-30980cca02f3@gmail.com
---
 drivers/tty/serial/8250/8250_core.c | 30 +++++++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index a428e88938eb7..7e6bbac094091 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -50,7 +50,7 @@ struct irq_info {
 
 #define IRQ_HASH_BITS		5	/* Can be adjusted later */
 static DEFINE_HASHTABLE(irq_lists, IRQ_HASH_BITS);
-static DEFINE_MUTEX(hash_mutex);	/* Used to walk the hash */
+static DEFINE_MUTEX(irq_chain_mutex);	/* Serializes link/unlink on the IRQ chains */
 
 static bool skip_txen_test;
 module_param(skip_txen_test, bool, 0644);
@@ -131,10 +131,11 @@ static void serial_do_unlink(struct irq_info *i, struct uart_8250_port *up)
  * - allocate a new one, add it to the hashtable and return it.
  */
 static struct irq_info *serial_get_or_create_irq_info(const struct uart_8250_port *up)
+	__must_hold(&irq_chain_mutex)
 {
 	struct irq_info *i;
 
-	guard(mutex)(&hash_mutex);
+	lockdep_assert_held(&irq_chain_mutex);
 
 	hash_for_each_possible(irq_lists, i, node, up->port.irq)
 		if (i->irq == up->port.irq)
@@ -151,15 +152,34 @@ static struct irq_info *serial_get_or_create_irq_info(const struct uart_8250_por
 	return i;
 }
 
+/*
+ * serial_link_irq_chain() hooks the given 8250 port into the IRQ chain.
+ *
+ * irq_chain_mutex must be held from the hash lookup through the first
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
 
+	guard(mutex)(&irq_chain_mutex);
+
 	i = serial_get_or_create_irq_info(up);
 	if (IS_ERR(i))
 		return PTR_ERR(i);
 
+	/*
+	 * Serialise against the list manipulation in the interrupt handler
+	 * and in serial_unlink_irq_chain().  irq_chain_mutex is still held
+	 * which prevents serial_unlink_irq_chain() from entering and freeing
+	 * the irq_info until the first request_irq() completes.
+	 */
 	scoped_guard(spinlock_irq, &i->lock) {
 		if (i->head) {
 			list_add(&up->list, i->head);
@@ -171,7 +191,8 @@ static int serial_link_irq_chain(struct uart_8250_port *up)
 		i->head = &up->list;
 	}
 
-	ret = request_irq(up->port.irq, serial8250_interrupt, up->port.irqflags, up->port.name, i);
+	ret = request_irq(up->port.irq, serial8250_interrupt,
+			  up->port.irqflags, up->port.name, i);
 	if (ret < 0)
 		serial_do_unlink(i, up);
 
@@ -182,8 +203,7 @@ static void serial_unlink_irq_chain(struct uart_8250_port *up)
 {
 	struct irq_info *i;
 
-	guard(mutex)(&hash_mutex);
-
+	guard(mutex)(&irq_chain_mutex);
 	hash_for_each_possible(irq_lists, i, node, up->port.irq)
 		if (i->irq == up->port.irq) {
 			if (WARN_ON(i->head == NULL))

---
base-commit: eb3f4b7426cfd2b79d65b7d37155480b32259a11
change-id: 20260528-bug-221579-8250-shared-irq-race-581e4900a178

Best regards,
-- 
Jing Wu <realwujing@gmail.com>

