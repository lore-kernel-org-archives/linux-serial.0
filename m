Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF6033F5B0
	for <linux-serial@vger.kernel.org>; Fri, 29 May 2026 08:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780043019; cv=none; b=Kpip4Dq6sFyypBkOAwWVRItbh0MLFp6aA8O/rvTR1HZf/1wViylkcGJzHmOd2JE5+/MsFT1eUVwz/10SlEeS+NpM5kJxVqGEvIuaH28FFlhW9PpvVcQYltTwpBqOXqKwkEh2lcoFMrQozToUnegfO3em9IkN9XLstrKfbpchy60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780043019; c=relaxed/simple;
	bh=phURFgmBunms5p7nHIAOnWmox6BpYNDaIYEz2FNmBv0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=XHKZ36nPvobAt7YR1zL43PQjWZchm33YoKRojfuO6R0ejv1GXtQPD7VwEe7Wb/S+7Cp/vpoVjSPy127ae9RO993be5UxLlql1IaEYePDaM0b1ikBjsZUJOlRgKsItwLClsrNj7RfiMcWFOjQaRa1l6RuCuqTe0n73naGYgaQavE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Frx0w6NS; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Frx0w6NS"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-304e83724bfso955492eec.0
        for <linux-serial@vger.kernel.org>; Fri, 29 May 2026 01:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780043017; x=1780647817; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qNVEzs85BVOZjm37IR2jH7cRK4GW/8BZIqqmnCO2ui4=;
        b=Frx0w6NSCZCiepXc45VqjlrdP7dejFZ4dTftsYh1AULJaCJ4Qxxu2LKDdkhp3U7W3R
         IXziGm2O3/QTcRBH4Uniuok9/Naa9CSlhYsr/jlyzH81oe1YW9MqouKgR8rnZD0XmMSW
         OLJ8ysdHK4jYaN2GY9x6WB0fgsbKP4gTzfc0t28T/FgJAp+u1XRzcD+rpM1SoM3k2rpn
         Bo+5T3uvgvqpUwz4G7rEfGYClD/+BtmPEyWnUA4bVYjt4sU+bAsjzZU64BQ91IpzWxBf
         Z92YRXD6zB35vHcN/U/GFVNSVhaKeRyalPUHDyX3h2QcRQtj3mXC1DK9Y5eOWsJ1/p2B
         SCQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780043017; x=1780647817;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qNVEzs85BVOZjm37IR2jH7cRK4GW/8BZIqqmnCO2ui4=;
        b=EXudRKmtx7sAVNv3MLAbb7hisk/Vgu8XT08IhUCgCtQXYn217cpwDgRP/pe2TEujOU
         zMg3gedwZCEvxh3r9BUEym8yirf17//2yZBh3gwEAZT+P4Al4ysMOlaCaB7Sq2AECxyO
         3+kWEjDVLJ4doo2NerSimNjxUHAd1TD5pR+shkJUhYwQeKj4fcLBC0Kd0A7NUt4gBhF6
         APuELEwhYTYg99Um5YjRGdLCpjDrDhG98CcyrPF6ml2CVCOzJkzu3G3LgkjKOHBsniFt
         hiDdUfvP4H4kjnv+nRoR9dbHcWHS8xIy3uZ4X0RjI09blqxK5HQ00kXfw+4c3S5JxoIG
         wR6w==
X-Forwarded-Encrypted: i=1; AFNElJ/TthZlA3IiHp3VgdGt9zSLQ0XSYIEZ2b2VrxbjiOn3rB3VNoIqg0jz7syMYfImiyeI6Y3nsHKdpcwHQHc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyArrjIGm/UiPU2XAHQ9+E//VT7NnnZu/4ETPxfcNUNvITn/qFp
	3dfySYRDo7xtJfNE8jWOXLBhXFFIXkBE1YNFVNsln1xEgb8Ju/S2u14U
X-Gm-Gg: Acq92OFkGkf7sliza4Zm4Z3D6zwXJTso+bW9lyp6YVvkaVZP9OWPmS04x7z1FDivoIO
	WsiShitSaCepKcRfUq3vzLpebU+ngzaTUvfoxH/DKPbc+e93NdedfpVEtYI8i5kkOJH8QTyxTiw
	vUDr3OMcI3GyaWhmYlJ6qWiGX3yilL5NH+Nhp3vZWv3k2DPMJgGdp7BiIemo1Jg+Zi+T3zRFwVx
	q26uKpP8VVvJb0gnusfdl0ECRFZUKcscbwc8FLLUUaqrI3i7AMv/FbeMWf6NXRrW0h1OpcOxevC
	uvDO9egqA4EgFmaBzgC0raIvetlYHRwuv8sdzmk+xoZ0vsvkeQpxGAGeHpFmj0ybiW4SA9yttXZ
	SB6YMlucnP1EukWwttr5TWR0diKDFIiqBhRsyMPiOuXK0eNgK+mKIT+XTdaxIEAzZ7R0PPfA1lR
	uMgX8zehs8hzXs4z6QiQmc/qr2Zko3vaiLXk58AKN9
X-Received: by 2002:a05:7300:5720:b0:304:5b0d:489b with SMTP id 5a478bee46e88-304eb0f8dffmr963957eec.27.1780043016704;
        Fri, 29 May 2026 01:23:36 -0700 (PDT)
Received: from wujing.localdomain ([23.254.208.9])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-304ed2f2904sm882525eec.9.2026.05.29.01.23.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 01:23:36 -0700 (PDT)
From: Qiliang Yuan <realwujing@gmail.com>
Date: Fri, 29 May 2026 16:23:34 +0800
Subject: [PATCH v4] serial: 8250: fix use-after-free in IRQ chain handling
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260529-bug-221579-8250-shared-irq-race-v4-1-cfda63b4420f@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/5XNQQ7CIBCF4asY1o4ZBqjgynsYF0inLYlaBW00T
 e8uujJu1OU/yXxvFJlT5CxWs1EkHmKO/bGEns9E6PyxZYh1aUFIFRqysLu2QCTN0oElg5A7n7i
 GmM6QfGAwVrJ2iF4urSjKKXETb6+FzbZ0F/OlT/fX4CCf19/tQYIEhc5iCB6pUev24ON+EfqDe
 NoD/elR8bAySpYXNrr+9NS75757qngN61ortBV59+5N0/QAbbftfm4BAAA=
X-Change-ID: 20260528-bug-221579-8250-shared-irq-race-581e4900a178
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, 
 Anton Vorontsov <avorontsov@ru.mvista.com>, Alan Cox <alan@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 Wang Zhaolong <wangzhaolong@fnnas.com>, Qiliang Yuan <realwujing@gmail.com>
X-Mailer: b4 0.14.3

serial_unlink_irq_chain() holds hash_mutex and calls free_irq() + kfree(i)
when it sees an empty port list.  serial_link_irq_chain() released
hash_mutex after serial_get_or_create_irq_info() but before acquiring
i->lock.  This gap allowed a concurrent unlink to observe list_empty()
as true while a new port was still being added, free i, and trigger a
use-after-free.

Dropping hash_mutex before request_irq() completes also allows another
port sharing the same IRQ to join the chain and run the shared-IRQ THRE
test while IRQ startup is still in progress, which can also trigger the
"Unbalanced enable for IRQ" warning (kernel/irq/manage.c:774) because
irq_shutdown() in the premature free_irq() path increments desc->depth,
breaking the disable_irq/enable_irq pairing in serial8250_THRE_test().

Fix by pulling hash_mutex into serial_link_irq_chain() and holding it
across the first request_irq() completion (including the error path)
so that no concurrent unlink or second-port join can race with IRQ
setup or cleanup.
serial_unlink_irq_chain() already holds hash_mutex throughout, so the
race window is closed.

Fixes: 768aec0b5bcc ("serial: 8250: fix shared interrupts issues with SMP and RT kernels")
Reported-by: Wang Zhaolong <wangzhaolong@fnnas.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=221579
Signed-off-by: Qiliang Yuan <realwujing@gmail.com>
---
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

v3: https://lore.kernel.org/r/20260529-bug-221579-8250-shared-irq-race-v3-1-fe4d430862a9@gmail.com
v2: https://lore.kernel.org/r/20260528-bug-221579-8250-shared-irq-race-v2-1-06531202e54d@gmail.com
v1: https://lore.kernel.org/r/20260528-bug-221579-8250-shared-irq-race-v1-1-30980cca02f3@gmail.com
---
 drivers/tty/serial/8250/8250_core.c | 55 ++++++++++++++++++++++++++++---------
 1 file changed, 42 insertions(+), 13 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index a428e88938eb7..70d5acfa591bf 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -134,7 +134,7 @@ static struct irq_info *serial_get_or_create_irq_info(const struct uart_8250_por
 {
 	struct irq_info *i;
 
-	guard(mutex)(&hash_mutex);
+	lockdep_assert_held(&hash_mutex);
 
 	hash_for_each_possible(irq_lists, i, node, up->port.irq)
 		if (i->irq == up->port.irq)
@@ -151,31 +151,60 @@ static struct irq_info *serial_get_or_create_irq_info(const struct uart_8250_por
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
+	 * prevents serial_unlink_irq_chain() from entering and freeing the
+	 * irq_info until the first request_irq() completes.
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
-	if (ret < 0)
+	INIT_LIST_HEAD(&up->list);
+	i->head = &up->list;
+	spin_unlock_irq(&i->lock);
+
+	ret = request_irq(up->port.irq, serial8250_interrupt,
+			  up->port.irqflags, up->port.name, i);
+	if (ret < 0) {
 		serial_do_unlink(i, up);
+		mutex_unlock(&hash_mutex);
+		return ret;
+	}
 
-	return ret;
+	mutex_unlock(&hash_mutex);
+
+	return 0;
 }
 
 static void serial_unlink_irq_chain(struct uart_8250_port *up)

---
base-commit: eb3f4b7426cfd2b79d65b7d37155480b32259a11
change-id: 20260528-bug-221579-8250-shared-irq-race-581e4900a178

Best regards,
-- 
Qiliang Yuan <realwujing@gmail.com>

