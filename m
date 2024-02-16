Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14FC41B96B
	for <linux-serial@vger.kernel.org>; Fri, 16 Feb 2024 08:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708070428; cv=none; b=Mvb1bpsmu+KlvRH8C4gyBq+HL3SlG6rDKyHCyu5dSLbsuPQ6NVPTlGX6XWA9qRFzcyMunRL4a0foHvM58kGtDvL8iZ5achBNOxtk66D+lyZjEnSkYBE7EAnUyA0+sjWDKiIyxqBiA7JE3C4UTEzYiboRC8JhdHKkbfzXO62S+Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708070428; c=relaxed/simple;
	bh=I7YQyvteIahvp42EiZA+1wJMmZSJKR2ugc165xDp9JA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qDaIKxbQ0880eNFFncwsHm4USH+m4dvvPITTUnL6Wr6U012RrqBQT9G/rvrwkVHyDkWRRhtf3anX7hEWMu6wAy5PWufe48qD1Yw6P233UhSvd1tjkQQgIT1R47lzwGgHKEVBKLQZ8+LgdZXwe620E/Mz9HmLYwZsdFDwVASm8Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FVUja+9u; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FVUja+9u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708070425;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LC1bKFmWstjcuRp0NCZgXGUr7lDByzyZO+jUi4bsRIg=;
	b=FVUja+9uErJ0XSk/Z5sdDO+MRLoOF6qtyQrJ8vDI8EaF45CNFdERswUCuB65X5p7NY/Cz6
	zP7QAbO5gV94egxcJC0Fzvq6CUNwZFrR4Gy6Q+PkPHZ0drI4eR0EAKRWFWPeoblA9TPG1j
	Pa4k6xo04kl2euOFtP2MYNrfru6yQKc=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-245-Z8plUM8kPOKw7nTDGXpGrA-1; Fri, 16 Feb 2024 03:00:21 -0500
X-MC-Unique: Z8plUM8kPOKw7nTDGXpGrA-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-781d8e14fd8so229610685a.3
        for <linux-serial@vger.kernel.org>; Fri, 16 Feb 2024 00:00:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708070420; x=1708675220;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LC1bKFmWstjcuRp0NCZgXGUr7lDByzyZO+jUi4bsRIg=;
        b=mblLyX+zn2LbCtWr1ECiS07MrU35ss8GP+PhqeZefZYtSxn4snMwAcaonULetU+eMV
         BHVt6uPmf13WP6FqETd9Dggg/f3gqyWtCndNxAjGaFhlb+jgD8AX+mI9wfdphox3cuVF
         5961TT9pC7Iharza/e0e2pWl2/WBNkL2r6Nm2WmzZDDEBprI5bJ/5b97+Tf36NorBbS2
         Ns6RBv/Smyo0QrHul57Mt+mpVIW7w2neeC4LjRCchfQbkkBt5NZiXs2xx2DTL6HLHfuN
         3q0sftofyQEq/u0v5y3FldL2wL7gV9PRwZvbJv+Db9J1XBXT6ZBNXQTi0qMlw469Fufl
         mGow==
X-Forwarded-Encrypted: i=1; AJvYcCX7DJTbg+rcvJ+Ej4wPsQaKDiD+f1KoDOoDBP7nBzZvUS3nmWcD0sxDwYTZ/QHX+QKjiKKbJ6uXPS84rheDnKFNXNALLSTSZbU+xNKB
X-Gm-Message-State: AOJu0YygSOk/i9yP0ERHeUTfNaYI/42KXInawvqymVfYGG2FVrKVxJVH
	o215muyZlxBvdsseNPYDbfp9jr/x/kK0sFuz571y4FZ/O1z/xnMGAO/id22/T3JvKA9j4tPgB9V
	RHqFmQCL+q4Hn/mw6YaTP6Otk8SfAPJsqqZSTyCh/s1QWAcVeg5gekqy3hp2H3w==
X-Received: by 2002:a05:620a:810:b0:787:28cb:5ab8 with SMTP id s16-20020a05620a081000b0078728cb5ab8mr4048027qks.41.1708070420528;
        Fri, 16 Feb 2024 00:00:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEzZCXcZ+QKr/cGMalNAF5gKgIDpVXp4WPWqbLnkgifvRtX29FergWTakc9zo0gqPSZwxJx4Q==
X-Received: by 2002:a05:620a:810:b0:787:28cb:5ab8 with SMTP id s16-20020a05620a081000b0078728cb5ab8mr4047996qks.41.1708070420262;
        Fri, 16 Feb 2024 00:00:20 -0800 (PST)
Received: from LeoBras.redhat.com ([2804:1b3:a800:4770:9d0:4bac:1782:4637])
        by smtp.gmail.com with ESMTPSA id br37-20020a05620a462500b00787346f1edasm1300756qkb.54.2024.02.16.00.00.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 00:00:19 -0800 (PST)
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
Subject: [RFC PATCH v2 1/4] irq: Move spurious_deferred bit from BIT(31) to BIT(0)
Date: Fri, 16 Feb 2024 04:59:43 -0300
Message-ID: <20240216075948.131372-3-leobras@redhat.com>
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

Makes sure the threads_handled reserve a bit for that.
This will be useful in the next patch in this series.

Signed-off-by: Leonardo Bras <leobras@redhat.com>
---
 include/linux/irqdesc.h | 9 +++++++++
 kernel/irq/manage.c     | 4 ++--
 kernel/irq/spurious.c   | 6 ++----
 3 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/include/linux/irqdesc.h b/include/linux/irqdesc.h
index d9451d456a733..62aff209315fe 100644
--- a/include/linux/irqdesc.h
+++ b/include/linux/irqdesc.h
@@ -251,4 +251,13 @@ irq_set_lockdep_class(unsigned int irq, struct lock_class_key *lock_class,
 		__irq_set_lockdep_class(irq, lock_class, request_class);
 }
 
+#define SPURIOUS_DEFERRED (0x1)
+#define SPURIOUS_DEFERRED_SHIFT (1)
+
+static inline void irq_add_handled(struct irq_desc *desc, int i)
+{
+	i <<= SPURIOUS_DEFERRED_SHIFT;
+	atomic_add(i, &desc->threads_handled);
+}
+
 #endif
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 1782f90cd8c6c..5bc609c7b728c 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -1191,7 +1191,7 @@ irq_forced_thread_fn(struct irq_desc *desc, struct irqaction *action)
 		local_irq_disable();
 	ret = action->thread_fn(action->irq, action->dev_id);
 	if (ret == IRQ_HANDLED)
-		atomic_inc(&desc->threads_handled);
+		irq_add_handled(desc, 1);
 
 	irq_finalize_oneshot(desc, action);
 	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
@@ -1212,7 +1212,7 @@ static irqreturn_t irq_thread_fn(struct irq_desc *desc,
 
 	ret = action->thread_fn(action->irq, action->dev_id);
 	if (ret == IRQ_HANDLED)
-		atomic_inc(&desc->threads_handled);
+		irq_add_handled(desc, 1);
 
 	irq_finalize_oneshot(desc, action);
 	return ret;
diff --git a/kernel/irq/spurious.c b/kernel/irq/spurious.c
index 02b2daf074414..d92f33b2e31ee 100644
--- a/kernel/irq/spurious.c
+++ b/kernel/irq/spurious.c
@@ -267,8 +267,6 @@ try_misrouted_irq(unsigned int irq, struct irq_desc *desc,
 	return action && (action->flags & IRQF_IRQPOLL);
 }
 
-#define SPURIOUS_DEFERRED	0x80000000
-
 void note_interrupt(struct irq_desc *desc, irqreturn_t action_ret)
 {
 	unsigned int irq;
@@ -312,7 +310,7 @@ void note_interrupt(struct irq_desc *desc, irqreturn_t action_ret)
 		if (action_ret == IRQ_WAKE_THREAD) {
 			int handled;
 			/*
-			 * We use bit 31 of thread_handled_last to
+			 * We use bit 0 of thread_handled_last to
 			 * denote the deferred spurious detection
 			 * active. No locking necessary as
 			 * thread_handled_last is only accessed here
@@ -328,7 +326,7 @@ void note_interrupt(struct irq_desc *desc, irqreturn_t action_ret)
 			 * returned IRQ_HANDLED since the last
 			 * interrupt happened.
 			 *
-			 * For simplicity we just set bit 31, as it is
+			 * For simplicity we just set bit 0, as it is
 			 * set in threads_handled_last as well. So we
 			 * avoid extra masking. And we really do not
 			 * care about the high bits of the handled
-- 
2.43.2

