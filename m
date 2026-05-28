Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331A63F39C2
	for <linux-serial@vger.kernel.org>; Thu, 28 May 2026 15:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779980899; cv=none; b=OfFpG2o+GEd5HhOZuHDGMJQT2BBGl+WKr4soi2vopK1UqLd0aNy9U986J/54Zojo3HqTVLI7xVr54W5XaXh9ea/7830xr+NScDLO4vrKmIhbSy2jRv5XlUeRmjt+scS+f0CkUaCpfdFh5NGF4Ng8Eqeblnn+QcqcAQsdRVjHi8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779980899; c=relaxed/simple;
	bh=+f7KO31VPHoMnuuAq+jhgt5I5faNl+QBytqyl+Qf9Jw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=uf0xUaevawTQISimjiRO2UYEi3Lu3AJ5YMTeZ6ffONY0I+oYy1B4kabIRIwXM+PTI59NEtW7BDseenZvjHFcKO3zacmU4gt1qNb9n6YKHFAJQbfB47kaiURbn2LQKBE19Vpa+8Fqvr1Ypf3K5C2aapRqb39lKOVvl+OxdI04VtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J1H+qYzf; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J1H+qYzf"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-914db83362aso486418085a.1
        for <linux-serial@vger.kernel.org>; Thu, 28 May 2026 08:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779980896; x=1780585696; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rOOB/h7V1R6nuzTrEgzPpTgDbbtW53vLtQhk6di2M5E=;
        b=J1H+qYzfUzKVCmFqQovfZk8ogu5iF5ycxEmRNaJkWWzZI+JLBTVwZBxl1OzTQj2vUz
         AZsUl5Uj9Yzc1K/uiayoJdirupF2j+Mje5uutqnOW2468SEctXOBYbqDleB2U0GMe4+u
         KUkt6CPfh9OBHaXwH279p8Q09kip6EKA3IqWN1kEVi3a1imvreYCWH/9AEHJZS4krCol
         hr/VY1ffrp1AYu2WdbWOIgkUhiRih5f9QFqIywJehGfL3LfKPo1TlGz2171SVqlfjFDB
         yIfWR7Vg8GFQdhzA3YCMoWU08cQ4/HWLr5XPj6I5BvZC/xcIyT9RDU7OaKeF/cYOlovv
         UWnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779980896; x=1780585696;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rOOB/h7V1R6nuzTrEgzPpTgDbbtW53vLtQhk6di2M5E=;
        b=KdA8LIMaZM5TDr2KdZagvFJpMnHgKl/ypVIlV6lTW/p7UQyU+dkaypgdQ9oFjakGfW
         CdZTVMypVvWNNUDkzbK2/xlJnOqIbhIFlj1XxC4tsA7xRsxsDDUVCPmOR7EgjrU1JZ2i
         czbiVWW5SNlkcew51aIP/ZErDdRBs+1J3F63Yctat4Wr4iW+MldVGCTSeAxz1qKIhsW4
         +9aXhkxUAMKvHmv7h4++1u4C9c2CrNVOgFdZB/M9BhL3dxxZW0b0v4uusbpQvVZpMSVM
         PldA3XBvSMLNXyaE74jIh8BpQuEE5V307Un8wFkERmy4B8ii1dEmCLXB4oZTppCHFPrt
         L7eA==
X-Forwarded-Encrypted: i=1; AFNElJ9IhUuaBc2ZBKdlTD7U9icyt0lIRJTl+84yZ9vhUi9z+znQmKBcvJuWMRAuwWtjwLHemHFrpGjTZ9ZMaec=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAI2Z9uEHhdL/yoim67Qvo8hXJZyhOUTicAjGEDJFh4UJMpNcV
	jzhDHYhElWsR33DPaY4RHuseNKXWml0z6qOppXebz3/3FPgZt41gJ42j
X-Gm-Gg: Acq92OFWuoOZqDQFfuKZP0fk9m8m5hhUY2+c4aRwTnA0tmNotVrZNYxgiXw7PQmIGae
	d7nZWIDNbvANoYLnMfNWJly5J6Q6/5C42qHbnuG+GCoa74gHzI98N0GXSr/Orh2+W8SBA3pacnH
	f4a+FTgTaS66jK74zACTCOLywEHxR+2x2Pne6CVXc+tom+FSxyTHPWwjC12Hacyhwwv+uBWdIf0
	DEZgbh8uIZRY//kwBjGMziHQYA8qASmNGCZJECfI3n+HGXhDAva5rK9MG4kied6RoPQkmCDSU6C
	FUfkSKjZnU0JEOi/fxKjSYsc847vCKzFRPl0fFhsGlUjSPFMZoafWgWADHSBWgvEPowNZ07eBWA
	ENEuvYhaG0tVGWKLojMg5xsRNu0xAbrgxEiPGQqhrGM1EwQFjNT8cTKt5elbt5H+UMlXqD9puAV
	AxDEKK8tjhhMHcYnxE6nfJUuHWp877eHYAhl1MlCNX
X-Received: by 2002:a05:620a:7108:b0:911:4885:9112 with SMTP id af79cd13be357-91521413f16mr235677985a.2.1779980895886;
        Thu, 28 May 2026 08:08:15 -0700 (PDT)
Received: from wujing.localdomain ([23.254.208.9])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-914f870c611sm836802485a.20.2026.05.28.08.08.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 08:08:15 -0700 (PDT)
From: Qiliang Yuan <realwujing@gmail.com>
Date: Thu, 28 May 2026 23:08:09 +0800
Subject: [PATCH] serial: 8250: fix use-after-free in IRQ chain handling
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260528-bug-221579-8250-shared-irq-race-v1-1-30980cca02f3@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3NTQqEMAxA4atI1hNIg9XqVQYXVaNm40/KDIJ4d
 4vLb/PeBUlMJUFbXGDy16TbmuE+BQxLXGdBHbOBiSvyHLD/zcjsfN1gYE+YlmgyotqBFgdBH5y
 UDVF0dYBc2U0mPd/Dt7vvB4X2y9hxAAAA
X-Change-ID: 20260528-bug-221579-8250-shared-irq-race-581e4900a178
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, 
 Anton Vorontsov <avorontsov@ru.mvista.com>, Alan Cox <alan@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 Qiliang Yuan <realwujing@gmail.com>
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
Fixes: 768aec0b5bcc ("serial: 8250: fix shared interrupts issues with SMP and RT kernels")
Signed-off-by: Qiliang Yuan <realwujing@gmail.com>
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

