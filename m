Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E422A367B93
	for <linux-serial@vger.kernel.org>; Fri, 29 May 2026 04:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780029397; cv=none; b=Lo27/1QMq6YYENmt1kwL/BPKTlzU5U+zMqgAlywVx1yntkNnWtLs23TqwKAaxEQjT+ebgS0BEXbM1QVIILpAb85tu9j1ASlPW9xYSo62QZu/ZvNJFidlEHIi7WBJsJKtBm8F4WxM8Z90FciCpZQMaFp7KObADtmNFo9IPAf+BIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780029397; c=relaxed/simple;
	bh=ABTgsPC5j0GXwcvHL4+byZOWF1PfrS+7wzoSIespi9g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=K7RAB4mop03v4L4B6XAzw4xE3JDEz4EM6VuXWjVGmiSOXtACSG9Cltg8LcpYYJu/JJVl6dHIo8icTHN1BpvOJISAQso0d/hVtSdxk2e9SdyXrujJtFPjQc7yGHnzrqxa0zcyHd12wHtjnIEu8ZiQxGfL18mrB8sM9kG8yWACJG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GtuKH4hI; arc=none smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GtuKH4hI"
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-137bd9ed2b1so45585c88.1
        for <linux-serial@vger.kernel.org>; Thu, 28 May 2026 21:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780029394; x=1780634194; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JdHuTzaGO/Qtw3uP6BWAkztOtnchQZI9Wb+dEcZgHDI=;
        b=GtuKH4hIkLZxdQ3rkQo/eYtlWyV8uu2Q6B5ZhFuJiYwcTyXAz82J2ym+qf1kDSNudM
         YX3GL8Faq7q62+FMNV4TkkfyhuXXHmzdxz6IWPJf/BuKxBAYXQNFSB2eEeapQH8byJzj
         eCYMc1PJEAkkDtTVNWEejPkvao9YA2WK5eJCYdzI9sH9xyBNyUA7ENgZhitoJD7ppArw
         60I297++fwDsqrjSCnQ0u/C7kseWwyFjlizPOeBCQGFIc9fOennx9APpraEo2XTfE69y
         ZcHFMx0Bs92nriTj1Xb2V2+G1CZtGiqWo0kn/e9fqmDWgLDA2+vz41N45zs+3pVkvv9H
         7eyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780029394; x=1780634194;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JdHuTzaGO/Qtw3uP6BWAkztOtnchQZI9Wb+dEcZgHDI=;
        b=Lkr5aBERNqe7FXO7z7Igd6XIoAa/+45bpOEmB1GhCBfwdvGMcXD35OFF68hHg21NtL
         5bVCGpdjqZ+8ZvBFPfrZELcEUMpW6t6UtGhJmHppT33hFvqazIOFQqQU0BQRfCPugw80
         2p/w3rReTy8fyFRJ2wVQWLSsZgZVQoQx4fojNj4G5QpRcVye1gRxh2bxPKnWIwcWbL5w
         5+GW83zbRIYBh/H0RrYM7VpTuIBW6lp7r9DVF/4iX7Vuy3ZuS5UtqbQ2JBWS0hvcRSaw
         CMiETFhEd+lj/1LoAXAQtHeYg7gpP36PkDQ4yh2xVXZ5DJwAoCFeUvPDT8yw9wbwOcRo
         Igkg==
X-Forwarded-Encrypted: i=1; AFNElJ/5DhcBTZrK3D80M3MKH5b+NcOwzbiJwiDfv9Tyc7+ZCK6QcAhzP30C7uREhhwmMmjoogxZTYiw55cC5E4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBjmlXn+s+01jUZ3odh/B/eoG3jhlYqFMSoe2ty4SU87aT1mrT
	0YIBkpbM3V9Vrt0TSzB3Sy8idBE24xy5I4LxBk5mdYmzL56xJHbTurnqGQWoDbur
X-Gm-Gg: Acq92OH55emHdoLSi65tl6fnGPgi8gAuhuIlNC/sdG+rW9llRSGcOenD9+nJ4m6A1Xd
	OPfWl1EchYKtIpuC9ewww/icthvBo+pLF4UufoqlGJ4F8IT25+puQ0iWPA1C16kr7v/Q+Lo7OU8
	KRHpTWtxDJ9Ac2ODFGuwRj4YKuZ/PRmO1fzhsUjKbEd6lAwjpr0/G6W+We8C1CAOhJxjJKOgTVi
	oei9ii+cpWk2l/52quDD0XrugF4vdqJDHBhtToRhBjdlUiWAf0ct2fI8URTTTzyzDY1gMSJI2KF
	+0lasxfkzrlOGaJUXIbXSmmspqPA54hBuEIOU8/sjb49PQexb+spB+KvJ+FaIGTuZiasZdb1WDI
	Chjat7vy3IgPvfXZVi0flDN4gFXPfv0vKhDQiCja2cDxVDjRErRGbwafqQDwl/Dxrrg/wP2MdPb
	05C/HIUUse8THsw7y2jvghrbqjzvM9X6JPOFTzDFta
X-Received: by 2002:a05:7022:6b86:b0:136:e4f:d2b2 with SMTP id a92af1059eb24-137aeed3126mr530048c88.29.1780029393850;
        Thu, 28 May 2026 21:36:33 -0700 (PDT)
Received: from wujing.localdomain ([23.254.208.9])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-137b3c69bdfsm439633c88.9.2026.05.28.21.36.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 21:36:33 -0700 (PDT)
From: Qiliang Yuan <realwujing@gmail.com>
Date: Fri, 29 May 2026 12:36:30 +0800
Subject: [PATCH v3] serial: 8250: fix use-after-free in IRQ chain handling
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260529-bug-221579-8250-shared-irq-race-v3-1-fe4d430862a9@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/5XNQQ6CMBCF4auQrh0zHSgUV97DuKhlgCYC2mqjI
 dzdwsqlLv9J5nuzCOwdB3HIZuE5uuCmMUW+y4TtzdgxuCa1IKQSFWm4PDsgkqqqQZNCCL3x3ID
 zd/DGMigtuagRjay0SMrNc+te28LpnLp34TH59zYY5Xr93Y4SJORYa7TWILX5sRuMu+7tNIjVj
 vSnR8nDUuUyvbAqmm9vWZYPsdDjHx4BAAA=
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
irq_shutdown() in the premature free_irq() path hard-sets desc->depth
to 1, breaking the disable_irq/enable_irq pairing in
serial8250_THRE_test().

Fix by pulling hash_mutex into serial_link_irq_chain() and holding it
across the first request_irq() completion so that no concurrent
unlink or second-port join can race with IRQ setup.
serial_unlink_irq_chain() already holds hash_mutex throughout, so the
race window is closed.

Fixes: 768aec0b5bcc ("serial: 8250: fix shared interrupts issues with SMP and RT kernels")
Reported-by: Wang Zhaolong <wangzhaolong@fnnas.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=221579
Signed-off-by: Qiliang Yuan <realwujing@gmail.com>
---
V2 -> V3:
- Hold hash_mutex across the first request_irq() completion to prevent a
  second port from joining the chain and running the shared-IRQ THRE test
  while IRQ startup is still in progress.

V1 -> V2:
- Add Reported-by tag from Wang Zhaolong.

v2: https://lore.kernel.org/r/20260528-bug-221579-8250-shared-irq-race-v2-1-06531202e54d@gmail.com
v1: https://lore.kernel.org/r/20260528-bug-221579-8250-shared-irq-race-v1-1-30980cca02f3@gmail.com
---
 drivers/tty/serial/8250/8250_core.c | 49 ++++++++++++++++++++++++++++---------
 1 file changed, 38 insertions(+), 11 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index a428e88938eb7..55a1a0515397f 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -134,7 +134,7 @@ static struct irq_info *serial_get_or_create_irq_info(const struct uart_8250_por
 {
 	struct irq_info *i;
 
-	guard(mutex)(&hash_mutex);
+	lockdep_assert_held(&hash_mutex);
 
 	hash_for_each_possible(irq_lists, i, node, up->port.irq)
 		if (i->irq == up->port.irq)
@@ -151,27 +151,54 @@ static struct irq_info *serial_get_or_create_irq_info(const struct uart_8250_por
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
+	INIT_LIST_HEAD(&up->list);
+	i->head = &up->list;
+	spin_unlock_irq(&i->lock);
+
+	ret = request_irq(up->port.irq, serial8250_interrupt,
+			  up->port.irqflags, up->port.name, i);
+
+	mutex_unlock(&hash_mutex);
+
 	if (ret < 0)
 		serial_do_unlink(i, up);
 

---
base-commit: eb3f4b7426cfd2b79d65b7d37155480b32259a11
change-id: 20260528-bug-221579-8250-shared-irq-race-581e4900a178

Best regards,
-- 
Qiliang Yuan <realwujing@gmail.com>

