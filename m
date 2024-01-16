Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE9C11181
	for <linux-serial@vger.kernel.org>; Tue, 16 Jan 2024 07:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G4VcMkzm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705390517;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=t9a7YoYgTaMNvrbxSQpm4NYpVm30/3iqFRoXOjmXJSA=;
	b=G4VcMkzmeH/TAT/AL+1x4nnXZFE2LF7h36Y+lcVIu+hHYxUQfJ5ttH8VZAOJwsXQCUGYQ+
	EDzkqGUmwyK/X8sejzsSROMrOROh9cfwNFeiHm431J1ahHYzz0Habqecg0YmhQl8kEPW1h
	dBIl+KOP8WdgRZ8MIK5i0p8GDLTm6KY=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-YxzYvI2XMc6Wms3DamsheQ-1; Tue, 16 Jan 2024 02:35:08 -0500
X-MC-Unique: YxzYvI2XMc6Wms3DamsheQ-1
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-5f240ace2efso138949597b3.1
        for <linux-serial@vger.kernel.org>; Mon, 15 Jan 2024 23:35:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705390508; x=1705995308;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t9a7YoYgTaMNvrbxSQpm4NYpVm30/3iqFRoXOjmXJSA=;
        b=lEtV+7RhQBbewv7VqZ1zsiCg6Y9O4RvYpV3NIrBYcm0L/H9aHRz2d9unqQD9w8woEB
         L/SYwNtUNu565/lwXBjazXLCiJCgIm+CYw3p93wmQ7dXQfiMw2LGiXZ3NYaDnsBWX8aq
         1hwYRUJ0ZoQdrI8AWKyF73f+oPNKxzQnzQ7yoApEEPFQfNMjDxiIzOS/kbP20tfdJlor
         rI6uUeGPk7Pw1kEWoc7E4CSj535AqcIT5ppByMjBAPcwjoq/oTdQWgO3IYkB09whaoWE
         nCkeuzDUtrOOBG8ORZVyX+u2QO2hm8T32gqsspU0wG68hWsoN0Ej7qh+l3FKqG+tFjFA
         dNpw==
X-Gm-Message-State: AOJu0YyHl0H3LuQ7u5HzyURY9wUVaPEdzx66KWtyIoS3yPpoiGlRtTaL
	/E6PPmG2FTm1+jf5iOzwHPK3o172Gf/lOGQnknm5Cr7dIWk1XDOOwDRK56JPOcSvkBStXuqpWyq
	W0D/rnY1Kba2QTUpAolV1v1vMr6vXBPUU
X-Received: by 2002:a0d:e601:0:b0:5ff:50ad:11a2 with SMTP id p1-20020a0de601000000b005ff50ad11a2mr399983ywe.21.1705390508317;
        Mon, 15 Jan 2024 23:35:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHWZSu9/bTKy6f7poFspHtkX5aG+TnbxTIauQYab4L8lwEFl7nqYxAEZEXiHv3v1c6IaylsNQ==
X-Received: by 2002:a0d:e601:0:b0:5ff:50ad:11a2 with SMTP id p1-20020a0de601000000b005ff50ad11a2mr399976ywe.21.1705390508110;
        Mon, 15 Jan 2024 23:35:08 -0800 (PST)
Received: from LeoBras.redhat.com ([2804:1b3:a803:64aa:6db9:6544:60c:9e16])
        by smtp.gmail.com with ESMTPSA id x22-20020a05620a0ed600b007831c7989a4sm3541913qkm.22.2024.01.15.23.35.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 23:35:07 -0800 (PST)
From: Leonardo Bras <leobras@redhat.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	John Ogness <john.ogness@linutronix.de>,
	Tony Lindgren <tony@atomide.com>,
	Marcelo Tosatti <mtosatti@redhat.com>
Cc: Leonardo Bras <leobras@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [RFC PATCH v1 1/2] irq/spurious: Reset irqs_unhandled if an irq_thread handles one IRQ request
Date: Tue, 16 Jan 2024 04:34:57 -0300
Message-ID: <20240116073502.2356090-1-leobras@redhat.com>
X-Mailer: git-send-email 2.43.0
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

When the IRQs are threaded, the part of the handler that runs in
interruption context can be pretty fast, as per design, while letting the
slow part to run into the thread handler.

In some cases, given IRQs can be triggered too fast, making it impossible
for the irq_thread to be able to keep up handling every request.

If two requests happen before any irq_thread handler is able to finish,
no increment to threads_handled happen, causing threads_handled and
threads_handled_last to be equal, which will ends up
causing irqs_unhandled to be incremented in note_interrupt().

Once irqs_unhandled gets to ~100k, the IRQ line gets disabled, disrupting
the device work.

As of today, the only way to reset irqs_unhandled before disabling the IRQ
line is to stay 100ms without having any increment to irqs_unhandled, which
can be pretty hard to happen if the IRQ is very busy.

On top of that, some irq_thread handlers can handle requests in batches,
effectively incrementing threads_handled only once despite dealing with a
lot of requests, which make the irqs_unhandled to reach 100k pretty fast
if the IRQ is getting a lot of requests.

This IRQ line disable bug can be easily reproduced with a serial8250
console on a PREEMPT_RT kernel: it only takes the user to print a lot
of text to the console (or to ttyS0): around 300k chars should be enough.

To fix this bug, reset irqs_unhandled whenever irq_thread handles at least
one IRQ request.

This fix makes possible to avoid disabling IRQs which irq_thread handlers
can take long (while on heavy usage of the IRQ line), without losing the
ability of disabling IRQs that actually get unhandled for too long.

Signed-off-by: Leonardo Bras <leobras@redhat.com>
---
 kernel/irq/spurious.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/irq/spurious.c b/kernel/irq/spurious.c
index 02b2daf074414..b60748f89738a 100644
--- a/kernel/irq/spurious.c
+++ b/kernel/irq/spurious.c
@@ -339,6 +339,14 @@ void note_interrupt(struct irq_desc *desc, irqreturn_t action_ret)
 			handled |= SPURIOUS_DEFERRED;
 			if (handled != desc->threads_handled_last) {
 				action_ret = IRQ_HANDLED;
+
+				/*
+				 * If the thread handlers handle
+				 * one IRQ reset the unhandled
+				 * IRQ counter.
+				 */
+				desc->irqs_unhandled = 0;
+
 				/*
 				 * Note: We keep the SPURIOUS_DEFERRED
 				 * bit set. We are handling the
-- 
2.43.0

