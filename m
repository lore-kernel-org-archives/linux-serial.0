Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550E53FBB6A
	for <linux-serial@vger.kernel.org>; Thu, 28 May 2026 15:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779983438; cv=none; b=P0Npkpsvvs9cAL16ZYOnSL/jal7AkUMgLZqjl5+AfAiOv5MezHktAKR1iRdFhKcpqoksoGL7NoIHe0c8RGeWkiMn47aDJD674HfE8SocY3fSf2I6CG/JMcuHJtEEUNIm3sdhjm/81XXnahgAz0CmryT5zo1j4JzIoLYFLvWtdDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779983438; c=relaxed/simple;
	bh=WcBmjmk/ISWJMhUszl7o1a95GVVtLaJ+X1L9bMnSr7c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=tkoUoncLVsMEDItLTYldH6OqNoyaQfRUqZM13f2zYgf7jwVhA6By5WOhtZhEmRLghVoLv8hqvrT0mCh8eId0Ik+alYc7mDyP2mlkGbxrADTzR9sw4unbtfYT4qGbmiVrWfXRz+fRYWZObfMtrY0KBoQACD0ZF/S+A+mbOUuFOT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H59ztwBa; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H59ztwBa"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-8b7f937ef44so83991556d6.0
        for <linux-serial@vger.kernel.org>; Thu, 28 May 2026 08:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779983434; x=1780588234; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qNlnOA1DAQ1rF4tBNb/+VHnT9xc4QGgj3T49JVzI4iQ=;
        b=H59ztwBakF3H3IOgCco9K8uBjs2/YM+7QYBGw3NAd93Eu9jn1XkeJS1RyRae8X7NhZ
         14bEGOm6cP8YGhYA+cYZgAs6Rmyr8PBUMlkeXd1xiFfmjBgSS1uySwZRzoKePTyk2GUF
         oywVs6+uyM20up5PQOkZ6Tnhk5IeyzldYbl/vDGi8bHdzKvW+2PRTUGK92m6UvQZLDTk
         1GEhzIgfdVDodQ0PUb4pCD/l9aEATCEIZU6Y6Z0XAv698V2RzTnZ0kh/8rItqtrYzumc
         qdGiygOI5wTBY+uQJ6/tAXhRjaJ7nii7BG3v2NZSVfvjA0//lP/01npAqBTcE/8A/5j0
         xg8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779983434; x=1780588234;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qNlnOA1DAQ1rF4tBNb/+VHnT9xc4QGgj3T49JVzI4iQ=;
        b=MsfYRNNdR5l6/T836sy1jQ6cq3EymgFbz5lxSLwrkdz5Sfp9za3oHBukzSn5i7Bh0i
         EYVue/59uKa3K8jbknTPEnNq+0+uOoLcNqjJ+QEgToqoWf8WrhLAAODkRk4y5D6Hq2ca
         fk98UE+0F6xY+gqZRU098iMs0KVmY1NsLkGRY9AX5+VO+zabHmycVWEI8J7Ji5VHUd1K
         BZ2x1xlnVGQlbzKVd49o9KxhEYsphOSiZVfYHdRsoyUpMDd8Y7bkoJ3rZmlqyaptxb/j
         RnBUDxchGmS6zl+wT7nfynmdMaJGEkvTEumx0RJEVCeRaGP0BlfF1rLWT8QgkGhWohjp
         sVVg==
X-Forwarded-Encrypted: i=1; AFNElJ92ZC//L1epNOLiwGkk4QCjq/lBL7vGHht+w7r3h2evb0BktrXtiLQ8HhcZ1i+ycxDUxRYKGxk9uDdL6W4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkgMgdvEBS9PLxeHJsrQiwTA4Uis1ILZJkI+dEXqMJxRGP/fWH
	6+vONScU506f3BSQmq60bcLIjtvvKodhbpRTaDSu4ph50UgpM5PkIU+V
X-Gm-Gg: Acq92OFSEjC717vpMOhpM3ccyLU1twQqsq+HVoThdlQ6jtxjj/d6IKahDWkvAkOec7S
	J0oStvNftUJH6glha0ObFFn9CIe6vpAe6KmGvxc0jOpWkszscQ7QDQb3mD5jrUhF1G7FGUNqmDm
	GsaXAeNAFxIeYBWRB1RZ8rymzMZ+e67gcaTmIk0mdCKuCS5ITuHOga2WMGDcwFCIRNTHjSEbzD0
	icCb6oG48y49nvqx2qyI5H6eiw0em0Zy52oN5tDzwmmSiabRg19o/4vHYWBXGjdu8aRAD9xexCz
	Du6IAoARuZX6TwABlFenPJABJ3NDl0/RxtVYJY3RD5DRLaZRI4xoV7e1hgWopBFaRwxAcMToE2I
	jZDEB7l1WaKJg9ARYF50DwCUbQEzyAsWVlUVgh7h+Upj9mxisIUGugB3QmfWq2Wjkcd1rgQwkbZ
	9NFmZ+GklaF4R+pxCXxXtEsdreklypH5e+qBIhBDX+
X-Received: by 2002:a05:6214:27ef:b0:8ca:7f:89b8 with SMTP id 6a1803df08f44-8cc7b512329mr434826076d6.8.1779983434018;
        Thu, 28 May 2026 08:50:34 -0700 (PDT)
Received: from wujing.localdomain ([23.254.208.9])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cc8131524esm202958526d6.40.2026.05.28.08.50.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 08:50:33 -0700 (PDT)
From: Qiliang Yuan <realwujing@gmail.com>
Date: Thu, 28 May 2026 23:50:30 +0800
Subject: [PATCH v2] serial: 8250: fix use-after-free in IRQ chain handling
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260528-bug-221579-8250-shared-irq-race-v2-1-06531202e54d@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42NQQ6CMBAAv0J6ds12sVI8+Q/DoZYFNhGqrRIN4
 e9WXuBx5jCzqMRROKlTsajIsyQJUwbaFcoPbuoZpM2sCOmIhixcXz0QaVPVYMkgpMFFbkHiA6L
 zDMZqPtSITldW5co9cifv7XBpMg+SniF+tuGsf/b/9qxBQ4m1Re8dUlee+9HJbe/DqJp1Xb/dR
 8tfzgAAAA==
X-Change-ID: 20260528-bug-221579-8250-shared-irq-race-581e4900a178
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, 
 Anton Vorontsov <avorontsov@ru.mvista.com>, Alan Cox <alan@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 wangzhaolong@fnnas.com, Qiliang Yuan <realwujing@gmail.com>
X-Mailer: b4 0.14.3

serial_unlink_irq_chain() holds hash_mutex and calls free_irq() + kfree(i)
when it sees an empty port list.  serial_link_irq_chain() released
hash_mutex after serial_get_or_create_irq_info() but before acquiring
i->lock.  This gap allowed a concurrent unlink to observe list_empty()
as true while a new port was still being added, free i, and trigger a
use-after-free.

The corrupted list/irq_info then causes an "Unbalanced enable for IRQ"
warning (kernel/irq/manage.c:774) because irq_shutdown() in the premature
free_irq() path hard-sets desc->depth to 1, breaking the disable_irq/
enable_irq pairing in serial8250_THRE_test().

Fix by pulling hash_mutex into serial_link_irq_chain() so that it covers
the i->head check and the list_add/INIT_LIST_HEAD under i->lock.
serial_unlink_irq_chain() already holds hash_mutex throughout, so the
race window is closed.

Closes: https://bugzilla.kernel.org/show_bug.cgi?id=221579
Reported-by: Wang Zhaolong <wangzhaolong@fnnas.com>
Fixes: 768aec0b5bcc ("serial: 8250: fix shared interrupts issues with SMP and RT kernels")
Signed-off-by: Qiliang Yuan <realwujing@gmail.com>
---
Changes in v2:
- EDITME: describe what is new in this series revision.
- EDITME: use bulletpoints and terse descriptions.
- Link to v1: https://lore.kernel.org/r/20260528-bug-221579-8250-shared-irq-race-v1-1-30980cca02f3@gmail.com
---
 drivers/tty/serial/8250/8250_core.c | 46 ++++++++++++++++++++++++++++---------
 1 file changed, 35 insertions(+), 11 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index a428e88938eb7..dfe76223ce10c 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -134,7 +134,7 @@ static struct irq_info *serial_get_or_create_irq_info(const struct uart_8250_por
 {
 	struct irq_info *i;
 
-	guard(mutex)(&hash_mutex);
+	lockdep_assert_held(&hash_mutex);
 
 	hash_for_each_possible(irq_lists, i, node, up->port.irq)
 		if (i->irq == up->port.irq)
@@ -151,27 +151,51 @@ static struct irq_info *serial_get_or_create_irq_info(const struct uart_8250_por
 	return i;
 }
 
+/*
+ * serial_link_irq_chain() hooks the given 8250 port into the IRQ chain.
+ *
+ * hash_mutex must be held across checking i->head and adding the port to
+ * the list.  Without this, a concurrent serial_unlink_irq_chain() can race
+ * in after hash_mutex is dropped but before i->lock is acquired, observe
+ * list_empty(i->head) as true, call free_irq() and kfree(i) — triggering a
+ * use-after-free and ultimately an "Unbalanced enable for IRQ" warning in
+ * kernel/irq/manage.c.
+ */
 static int serial_link_irq_chain(struct uart_8250_port *up)
 {
 	struct irq_info *i;
 	int ret;
 
+	mutex_lock(&hash_mutex);
+
 	i = serial_get_or_create_irq_info(up);
-	if (IS_ERR(i))
+	if (IS_ERR(i)) {
+		mutex_unlock(&hash_mutex);
 		return PTR_ERR(i);
+	}
 
-	scoped_guard(spinlock_irq, &i->lock) {
-		if (i->head) {
-			list_add(&up->list, i->head);
-
-			return 0;
-		}
+	/*
+	 * Serialise against the list manipulation in the interrupt handler
+	 * and in serial_unlink_irq_chain().  hash_mutex is still held which
+	 * prevents serial_unlink_irq_chain() from running concurrently.
+	 */
+	spin_lock_irq(&i->lock);
+	if (i->head) {
+		list_add(&up->list, i->head);
+		spin_unlock_irq(&i->lock);
+		mutex_unlock(&hash_mutex);
 
-		INIT_LIST_HEAD(&up->list);
-		i->head = &up->list;
+		return 0;
 	}
 
-	ret = request_irq(up->port.irq, serial8250_interrupt, up->port.irqflags, up->port.name, i);
+	INIT_LIST_HEAD(&up->list);
+	i->head = &up->list;
+	spin_unlock_irq(&i->lock);
+
+	mutex_unlock(&hash_mutex);
+
+	ret = request_irq(up->port.irq, serial8250_interrupt,
+			  up->port.irqflags, up->port.name, i);
 	if (ret < 0)
 		serial_do_unlink(i, up);
 

---
base-commit: eb3f4b7426cfd2b79d65b7d37155480b32259a11
change-id: 20260528-bug-221579-8250-shared-irq-race-581e4900a178

Best regards,
-- 
Qiliang Yuan <realwujing@gmail.com>

