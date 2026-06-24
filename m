Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33AE9175A9A
	for <linux-serial@vger.kernel.org>; Wed, 24 Jun 2026 01:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782264118; cv=none; b=h9/ukZLIDlNL0y9XRQR7LnWptc/wCiu+6KWeANaYmP3GqUGcbPAxsT7SmAii35fgBcHPcXG5wWHBh8pVnM/1F4WJAU4QBwwygLTzcHbeXUc9Dv0hWHo4Na5sVOeeuIfNiQAOVj+jAbUiuFlgL7ecEsjonvbn3NWrM2GMh5HVYJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782264118; c=relaxed/simple;
	bh=efXl1f4OYxs14GkrzQ7OCdeCvn66t0TFEoMHMmEiw3Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=eOTTaN+PHSIzBn5VWK/ITmUkoRr+K95BGWBg0JO9k+eTeu6wWqk1JUn2BDfNoB7pfVPW4BMSjKH1X+Y6hdypI270mydI13/0tCwBAeXk4Zkm4/FolC7ldOUym4F4W3mnLJSF9KDCvWBMuutHZzW9kd44MTaYt+RF4kQBwKP5N4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gXwbE5UV; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gXwbE5UV"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2c6c101aeafso2413315ad.0
        for <linux-serial@vger.kernel.org>; Tue, 23 Jun 2026 18:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782264116; x=1782868916; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AJHhfVLTPeloHTmnbQxwBsRlL991iUAzQ2rFPYm92bI=;
        b=gXwbE5UV/0yz72ZnwyWwOz0uS82+UDM/KQTZi8eWXf7QKA/2BOj5vRc7lY61BEODf2
         K0eOt/2GpY16bj7Vp/Jo8Y6AWl8e4HmT0UKpVRCGLUrnKuPUNqAoysKofNei8dbWo1aW
         RgNSBTkz+OMFgP/wT83dWUmRaFSVbvesqyjcmsWOiAX7D3eeznT00+U9aWJU95pWNG61
         SSHCJLQFzpuA2pjQ8KqaLLbVMcGs0wlUp6yvB9CkAle2jhwaDGOv1RQs6fCgTo+jcrGZ
         /n0HS+v3Ic6cZWLv81zznUdl2m50lT1QgBtoLd1/uQfSJqWjeKJtefl2ZjMKBqGNf8Bg
         rSLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782264116; x=1782868916;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AJHhfVLTPeloHTmnbQxwBsRlL991iUAzQ2rFPYm92bI=;
        b=EzXD79dRHAnen7Vx6q7crSoMxLJjvEzLl+zJesX32s2jY0pxMVmW03aUm+123FodZU
         TBOY8HSM//Q+1uyVDOaOJWlD9b+0QSB38lCILuriQFyMI4UC182q/lgfMJaO0Yf6JQke
         8nxLEAdIPnXxQsJCAJe2AniPnqhedrLUI42BlCDwOq2fQB2T1mSbXdfr3769cPMObQ3p
         NXqXSBFlc0bPfzQVOXFgM7I6EoPuGXHUr+fFjoKViHrIlq5uFFUyG2aaDUarugexnsCf
         q8SFLlSgMjCCN1WVRdtNa+I0zvJgJfO8FyOrZ9I3EzTUtTp/fT04T2DZ1riKV7V77SVu
         6IDA==
X-Forwarded-Encrypted: i=1; AHgh+RqhJdPTtlvfx4SnnrJT9SSE/i9d7bVGyLKkz4Ywe/h3Cv97G5VsDpViey7T8W/vspAvbaIJD/VUJq7I7Rc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzctnZK/1I2o+d1Qn6skuIOuTAjEqQ6Lk1vDexAJDvt/MBX7tdL
	TT1HJS8p1JwhtK9Q7J+HEGlAlUmvGgYRzPfrZ56CDp7e2I/DtcDOCs6e
X-Gm-Gg: AfdE7cndLb4TBhg4LaE2FoL8v0E6CKdJKAQbEILd3MFxe/DjHNzFU1OFhV+sM6p68o+
	MlcfobMVr9bMaKQYRl5lAngvgk99xuSsvagojBrdamVQ5wIknyC1ID/Y7Kc5zFuQ/eX80r+ECcI
	yp4WEXTc8qLCW2y2t2jCIzOZfhlwp8tTA/0dhijxFHWzWLEgRk6I1TPTR2VhJ/Zi8dGFPmfxptP
	c2mCrnbpWvaqV/FmlbaESNi/+z9n0v8sa82A21hkQiETDU9IfYU/3bjh9EhojvHIT4RO6LWgKb7
	RQ3zPwaRAfvU8727M3ZJ9sd/257oxsR2Tcz9LlTpxoX24NevDQ+VnC1Uva6LIV9e+TZ/XDuvwj2
	27ftdJEU6NMoN4NSfn1+06iM4Jfvi+PmJIMLo/uShZeES1jx5gjYkPlpyS+hknRg0prysdEVO9f
	pRluTYEAsIPjQ=
X-Received: by 2002:a17:903:1107:b0:2ba:7881:948d with SMTP id d9443c01a7336-2c7e1412c1fmr13001095ad.1.1782264116431;
        Tue, 23 Jun 2026 18:21:56 -0700 (PDT)
Received: from [127.0.1.1] ([138.199.21.246])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c742fdd411sm133046475ad.0.2026.06.23.18.21.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 18:21:56 -0700 (PDT)
From: Qiliang Yuan <realwujing@gmail.com>
Date: Wed, 24 Jun 2026 09:21:53 +0800
Subject: [PATCH v5] serial: 8250: fix use-after-free in IRQ chain handling
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260624-bug-221579-8250-shared-irq-race-v5-1-15d841f89e1e@gmail.com>
X-B4-Tracking: v=1; b=H4sIADAxO2oC/5XNwW4CIRDG8VcxnB0zDLCCp76H6QFh2CVR14Ldt
 Nnsu4uejJfW43+S+X2zqFwyV7FbzaLwlGsezy3MeiXC4M89Q46tBSF1aMjC4bsHImm2DiwZhDr
 4whFy+YLiA4OxkrVD9HJrRVMuhVP+eSzsP1sPuV7H8vsYnOT9+n97kiBBobMYgkdK6qM/+Xzch
 PEk7vZEb3rUPOyMku2FjY6vnnr23N+eal5iHbVC25F3r55+09PNCyn6Th20JkzP3rIsNxsvAmm
 +AQAA
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, 
 Anton Vorontsov <avorontsov@ru.mvista.com>, Alan Cox <alan@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 Wang Zhaolong <wangzhaolong@fnnas.com>, Qiliang Yuan <realwujing@gmail.com>
X-Mailer: b4 0.13.0

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

v4: https://lore.kernel.org/r/20260529-bug-221579-8250-shared-irq-race-v4-1-cfda63b4420f@gmail.com
v3: https://lore.kernel.org/r/20260529-bug-221579-8250-shared-irq-race-v3-1-fe4d430862a9@gmail.com
v2: https://lore.kernel.org/r/20260528-bug-221579-8250-shared-irq-race-v2-1-06531202e54d@gmail.com
v1: https://lore.kernel.org/r/20260528-bug-221579-8250-shared-irq-race-v1-1-30980cca02f3@gmail.com
---
 drivers/tty/serial/8250/8250_core.c | 56 ++++++++++++++++++++++++++++---------
 1 file changed, 43 insertions(+), 13 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index a428e88938eb7..a86505c3dcb67 100644
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
@@ -151,31 +152,60 @@ static struct irq_info *serial_get_or_create_irq_info(const struct uart_8250_por
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
Jing Wu <realwujing@gmail.com>

