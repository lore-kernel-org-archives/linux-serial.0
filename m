Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B14F407CC7
	for <linux-serial@vger.kernel.org>; Wed,  8 Jul 2026 09:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783501877; cv=none; b=TaQF4DnIBp2EJpV2JWm2Y+LN1R64Xc9K3jENy+jR77BC7h3z31G34HVr3A6WPUhAvrOtpD05pvxH7F8Xw8UQPBNjV3LsS95u+7QBdJDCaB66HT762FhZoUyjZGaKzD/3pHhpObH8TL6K8zcfyTrSnOTwt4LlnZPoDCCzmsyLcxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783501877; c=relaxed/simple;
	bh=oQNtRunvPMIM4Xv0EqwjVrExFo6RDAIPu/MPOikVLuU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=hwOnbOXquiD95srLb1ylUw9mP+h4aozobr8WVKO4u8AD8DRYklhhjQkqsvMSReR6K8vWCfUnPI+l/7VPl2SySkkOFVLEui4QIw4zcWq8MewBRXl/zqL10Hjt9yjkxhDmnbQvXELdL6THM+Q/NKrGO0sBXjyhlbOxT8GF6vMCJdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CMe5/j1N; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CMe5/j1N"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2cc8e87f29bso3725345ad.2
        for <linux-serial@vger.kernel.org>; Wed, 08 Jul 2026 02:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783501875; x=1784106675; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=uVCLGt4zKTd2DICuHMjbcSxNEEOmgYyKSSHE1nj4L2A=;
        b=CMe5/j1NE4qQmRTTJF2uKw2WEINVVgLX7avIOVhLN3BvDQAFe0+AMUNrSmyk9mIrVf
         IkaOzQw25E5ZTjhqvozfC/kM+s1DTJzCCNbelGZxBWSn4XIs3YFuT/YnGxsKO07qBfzw
         4gDyW1MF582t4c95TEvulJjT2hw5RDSGxIx4ICXtlCTOiziuSuZ7I9vHuHDQxSReo+2X
         Uc4X7j0k44JxX5YV/n2CCnrn7hNlNt9G/kOORPbDroAScVwZen+60V4OuRfMjoPe0m6O
         cD0j6shxWFqhLgolcKQ6qUGkmLKhnvGxGwqNajmS1JD+7RBlfYctkM4cAAGycULGSrfE
         WBeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783501875; x=1784106675;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=uVCLGt4zKTd2DICuHMjbcSxNEEOmgYyKSSHE1nj4L2A=;
        b=QJc7nkiwL7i6XDIOCBdtza+TP3T7pTmWyQ89R7s/9kgb9nGNef6nMSshxatg9jLnRV
         fRzugD5LQLkA4swAHrYDXc1VP9lvcYdwPT0Jjsb+jUaocfpxphMVZQW44JYUC0z/nREh
         lpjSoGQ3ytMGeZT9qLxTY2IDGuwdGWJlLEvv0UGnQC1UpkoqKyl8q0CAoo1GvGfntNi3
         NYIcNcggo5e3TMgKLHq8cPlmhtaf2qKF4bxgKN80InpIFPiytNAO4WtiiFXObwuF36/X
         CmmnHCXuTZhuy2gX1doJB7JrOyV+pX6FfY+jiaTeqq5HsDMe0lcoZmyr54CkxPeWoR0f
         1hBA==
X-Forwarded-Encrypted: i=1; AHgh+RrEtNg0P3KraRMGBEIoaRpq6LmGkMJWYYACuzv05MWVqJZnW/TlIVJxoWdLSm04HGIqiLrwRAcDWbHHayo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1mzxDgLBl56CL40VaXuQNZZ12eAcTWSIaTKpHAPvrFsa5DUT1
	h/DYq8RoW/+wsAFnyu2GGxD4zw3ddIHho4uC257QrtrEn5Yv+VPrXxRFOcf4guqoEXE=
X-Gm-Gg: AfdE7cmk480V2z/YjsliHlAv1/yVK1rgEYyHBTUqHPAREMIIAIQ2DQ38d05nrtN28Bj
	JgiorLjihntjL7H2La9IxX6yL++Jzhmdf8jZsCxarLJEPOzwEFSlJHIKIcxSlameIwq41FBiegU
	gL0mr3U83KxWr1HH07owL5zVHfbxP1jhOD7ELY/khMtn/dJEWquzfOeOv1DFNlPnzr88aLoLxBR
	P8njBM3QthcBohTFZtlNUV3dnEbKYOip5S/B0wHEi71rl1bScqT28veUlG1dp23U0V7T8wp9wBZ
	blRXC+KePVBe7vjAtvZGWUMeWnEOq8bcQTciVwOXG5aIrmwkGM4AmlsI+6ebQxSQQWADQtbRgMM
	MYuOnrzOn3epn3y7Bd9z9WHVi3XPFhIiT9IZMq/XRCSeVu9fIB7aNhE1IJaYTyH6+v3tpS9DCH9
	jyiH+CYXcN96g=
X-Received: by 2002:a17:902:fdad:b0:2cb:2b69:8d53 with SMTP id d9443c01a7336-2ccea3a7a85mr19391795ad.37.1783501875181;
        Wed, 08 Jul 2026 02:11:15 -0700 (PDT)
Received: from [127.0.1.1] ([61.144.108.37])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9bf737bsm24455035ad.19.2026.07.08.02.11.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 02:11:14 -0700 (PDT)
From: Jing Wu <realwujing@gmail.com>
Date: Wed, 08 Jul 2026 17:11:11 +0800
Subject: [PATCH v8] serial: 8250: fix use-after-free in IRQ chain handling
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260708-bug-221579-8250-shared-irq-race-v8-1-0ae10b073dd9@gmail.com>
X-B4-Tracking: v=1; b=H4sIAC4UTmoC/5XRzU7DMAwH8FeZcibIcb458R6IQ5o4bSS2QgoVa
 Oq7k+6yUQ7bjn9L/lm2j2yiWmhiT7sjqzSXqYyHFtzDjsUhHHriJbXMENCARse7r54jCm09d6i
 BT0OolHipH7yGSFw7QcoDBGEda8p7pVy+TxNeXlseyvQ51p/TwFms1dvtWXDBJXgHMQbALJ/7f
 Shvj3Hcs9We8U4PmwdGS9FaSKu09eSl5697snmZVFISnMHgt56601PNizkFIzulEPLW02fPoLr
 u6eYJnZwS2XkStPXM2bNgr3tm3ddF5X3w0KV/97OX3g3/sM1zyWiMxkrZ/fnvsiy/9E+53q4CA
 AA=
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
Tested-by: Wang Zhaolong <wangzhaolong@fnnas.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=221579
Co-developed-by: Qiliang Yuan <yuanql9@chinatelecom.cn>
Signed-off-by: Qiliang Yuan <yuanql9@chinatelecom.cn>
Signed-off-by: Jing Wu <realwujing@gmail.com>
---
V7 -> V8:
- Remove Co-developed-by: Wang Zhaolong and his Signed-off-by.  Wang
  reported the bug and confirmed our v3 fixed his reproducer, which
  warrants Tested-by, not co-developer credit.
- Add Tested-by: Wang Zhaolong.

V6 -> V7:
- Rename hash_mutex to irq_chain_mutex to reflect its broader role
  beyond hash table locking.
- Drop unrelated blank-line and return-value changes.
- Add Co-developed-by: Qiliang Yuan.

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

v7: https://lore.kernel.org/r/20260708-bug-221579-8250-shared-irq-race-v7-1-0da8d89f6072@gmail.com
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

