Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9AF1B962
	for <linux-serial@vger.kernel.org>; Fri, 16 Feb 2024 08:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708070428; cv=none; b=W424d6/jU5+3iyAy/CMLJqKyrG168zobX1gmZlrHU1mlRKRMVjaItA1ad7pGt/khvfzUbSwvNlzu2PgHB5EITN8abxFyFTO/TM2feVVB5ZICFFzMKqOOvwF4JNfxGZTMGJL3GRgGiplwYy7psGl+LrNc6e1Mqlh69zHfkRjXSis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708070428; c=relaxed/simple;
	bh=aEHy6hiozJg0zLqSV3cEv145/oODe8VbFXoxgPA/6rM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B8pOa+i/diiJZnz7/AY/CG7DGw173SSvdGzTlIYTMybWPeO49hq+ZY/iovCiBgQ8ONxYSI0r4v03XojC8ppytoJYFP9dobxjJnlcUQxGseYHwZ5fEIi0mjPrphWfoq6l0iZ4d6oy50fbNBr6WHDqnlkwBnYZ/OGf/VhaVEfYJwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S26B1SIS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S26B1SIS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708070425;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d3/GSmZNXXq4OmuXU9kp4Oh7aTznSf//j0PB7MhvXcY=;
	b=S26B1SISfjWZK6nGOXmi1T80Q1zG2SGSfeqZJJ4nVeX7bxBwt8LyBK8vWtZSDz+86n1xNw
	aPt9aDAD/fmtZjbMmEabcZ8Fs5/4P9Yz43JP3sFvKXIN9iA+4FzI+nrFf+OCC8kEPao8lu
	QCtCD7QtHUCayThFPkvyBMevnmKps4I=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-410-AT6p03SmPCiNo5jf5jfDNw-1; Fri, 16 Feb 2024 03:00:23 -0500
X-MC-Unique: AT6p03SmPCiNo5jf5jfDNw-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-78732274d13so43725085a.1
        for <linux-serial@vger.kernel.org>; Fri, 16 Feb 2024 00:00:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708070423; x=1708675223;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d3/GSmZNXXq4OmuXU9kp4Oh7aTznSf//j0PB7MhvXcY=;
        b=ol42LZaUaVGWUe0gHai3CvG/g6NcaX3Euh7Px/lhSt9FkhKbwXeiK28m7Zhw2lGQCF
         jUT4VA0PbhkLeKtfrUiQGeOgAYGlEPZba5bA6WnawgY3js5X+2dLLRsNLtPQ/y4JVQbL
         h9FvwvHv/g3HIJB/MpifM8ouZGOieXWjbaXmD8ngPKgF2ZQgIzA1yJkGvoBYF9nzvjod
         K77A8g1WWEdVaqvcffcaXQDn+bI6/nOWIOlM3mHvXA71VWBqcbmFEz/urKTVm3E5nHH/
         B8ick6G24CQRjIXVO4dA3Cah6uUZd2F9ZmCFq/kaDFit18oS642AYpkSSCyd+qjMyU6T
         2byQ==
X-Forwarded-Encrypted: i=1; AJvYcCVLtZQHdVLlfzsGILpgDTwpRDb3yAcvyP0g7Bx/rPGQjhdKSsKmWXl+Izk/Kc0wOKVL/LssoHLiD1D3LQUAMgRIEcQJuIjlR+hsr5S2
X-Gm-Message-State: AOJu0YwOLm0GZKztff/C2ERkzMkcPTsRy9fHG78guBxVMfoCSlOhvwAq
	TE3GskVI9l3fMWWq1Kv9cGe5gq+cNeqgA2Z76+/7E9Ne2iV8mY764VC3QmO4MO+a7Tbo7YoSis8
	j788RpniKhu0I/i+pTVlYhYUQm5vmkBfeEfIVQbKYgXeRga/yQ5CQrHbJpr2wKw==
X-Received: by 2002:a05:620a:20dc:b0:785:bd25:e5f7 with SMTP id f28-20020a05620a20dc00b00785bd25e5f7mr4327147qka.40.1708070423379;
        Fri, 16 Feb 2024 00:00:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHDRyKi0XcKVQ1C8Z+dCIrgkoC1k7NPLTiBJp4VU065CynceYB7WcSQnoLO8F0WxfTXSA0FUQ==
X-Received: by 2002:a05:620a:20dc:b0:785:bd25:e5f7 with SMTP id f28-20020a05620a20dc00b00785bd25e5f7mr4327129qka.40.1708070423128;
        Fri, 16 Feb 2024 00:00:23 -0800 (PST)
Received: from LeoBras.redhat.com ([2804:1b3:a800:4770:9d0:4bac:1782:4637])
        by smtp.gmail.com with ESMTPSA id br37-20020a05620a462500b00787346f1edasm1300756qkb.54.2024.02.16.00.00.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 00:00:22 -0800 (PST)
From: Leonardo Bras <leobras@redhat.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Tony Lindgren <tony@atomide.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	John Ogness <john.ogness@linutronix.de>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Leonardo Bras <leobras@redhat.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Shanker Donthineni <sdonthineni@nvidia.com>
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [RFC PATCH v2 2/4] irq/spurious: Account for multiple handles in note_interrupt
Date: Fri, 16 Feb 2024 04:59:44 -0300
Message-ID: <20240216075948.131372-4-leobras@redhat.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240216075948.131372-2-leobras@redhat.com>
References: <20240216075948.131372-2-leobras@redhat.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

Currently note_interrupt() will check threads_handled for changes and use
it to mark an IRQ as handled, in order to avoid having a threaded
interrupt to falsely trigger unhandled IRQ detection.

This detection can still be falsely triggered if we have many IRQ handled
accounted between each check of threads_handled, as those will be counted
as a single one in the unhandled IRQ detection.

In order to fix this, subtract from irqs_unhandled the number of IRQs
handled since the last check (threads_handled_last - threads_handled).

Signed-off-by: Leonardo Bras <leobras@redhat.com>
---
 include/linux/irqdesc.h |  2 +-
 kernel/irq/spurious.c   | 53 ++++++++++++++++++++++++++---------------
 2 files changed, 35 insertions(+), 20 deletions(-)

diff --git a/include/linux/irqdesc.h b/include/linux/irqdesc.h
index 62aff209315fe..957ac02e9ec2b 100644
--- a/include/linux/irqdesc.h
+++ b/include/linux/irqdesc.h
@@ -67,7 +67,7 @@ struct irq_desc {
 	unsigned long		last_unhandled;	/* Aging timer for unhandled count */
 	unsigned int		irqs_unhandled;
 	atomic_t		threads_handled;
-	int			threads_handled_last;
+	unsigned int		threads_handled_last;
 	raw_spinlock_t		lock;
 	struct cpumask		*percpu_enabled;
 	const struct cpumask	*percpu_affinity;
diff --git a/kernel/irq/spurious.c b/kernel/irq/spurious.c
index d92f33b2e31ee..4e8e2727b8beb 100644
--- a/kernel/irq/spurious.c
+++ b/kernel/irq/spurious.c
@@ -267,6 +267,28 @@ try_misrouted_irq(unsigned int irq, struct irq_desc *desc,
 	return action && (action->flags & IRQF_IRQPOLL);
 }
 
+static inline int get_handled_diff(struct irq_desc *desc)
+{
+	unsigned int handled;
+	int diff;
+
+	handled = (unsigned int)atomic_read(&desc->threads_handled);
+	handled |= SPURIOUS_DEFERRED;
+
+	diff = handled - desc->threads_handled_last;
+	diff >>= SPURIOUS_DEFERRED_SHIFT;
+
+	/*
+	 * Note: We keep the SPURIOUS_DEFERRED bit set. We are handling the
+	 * previous invocation right now. Keep it for the current one, so the
+	 * next hardware interrupt will account for it.
+	 */
+	if (diff != 0)
+		desc->threads_handled_last = handled;
+
+	return diff;
+}
+
 void note_interrupt(struct irq_desc *desc, irqreturn_t action_ret)
 {
 	unsigned int irq;
@@ -308,7 +330,7 @@ void note_interrupt(struct irq_desc *desc, irqreturn_t action_ret)
 		 * interrupt.
 		 */
 		if (action_ret == IRQ_WAKE_THREAD) {
-			int handled;
+			int diff;
 			/*
 			 * We use bit 0 of thread_handled_last to
 			 * denote the deferred spurious detection
@@ -325,27 +347,20 @@ void note_interrupt(struct irq_desc *desc, irqreturn_t action_ret)
 			 * Check whether one of the threaded handlers
 			 * returned IRQ_HANDLED since the last
 			 * interrupt happened.
-			 *
-			 * For simplicity we just set bit 0, as it is
-			 * set in threads_handled_last as well. So we
-			 * avoid extra masking. And we really do not
-			 * care about the high bits of the handled
-			 * count. We just care about the count being
-			 * different than the one we saw before.
 			 */
-			handled = atomic_read(&desc->threads_handled);
-			handled |= SPURIOUS_DEFERRED;
-			if (handled != desc->threads_handled_last) {
-				action_ret = IRQ_HANDLED;
+			diff = get_handled_diff(desc);
+			if (diff > 0) {
 				/*
-				 * Note: We keep the SPURIOUS_DEFERRED
-				 * bit set. We are handling the
-				 * previous invocation right now.
-				 * Keep it for the current one, so the
-				 * next hardware interrupt will
-				 * account for it.
+				 * Subtract from irqs_unhandled	the number of
+				 * IRQs handled since the last change in
+				 * threads_handled.
 				 */
-				desc->threads_handled_last = handled;
+				if (diff < desc->irqs_unhandled)
+					desc->irqs_unhandled -= diff;
+				else
+					desc->irqs_unhandled = 0;
+
+				action_ret = IRQ_HANDLED;
 			} else {
 				/*
 				 * None of the threaded handlers felt
-- 
2.43.2

