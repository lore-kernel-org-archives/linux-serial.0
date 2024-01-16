Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C233710A3E
	for <linux-serial@vger.kernel.org>; Tue, 16 Jan 2024 07:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="geOl491H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705390631;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t9a7YoYgTaMNvrbxSQpm4NYpVm30/3iqFRoXOjmXJSA=;
	b=geOl491HCYTX4AQ4ZPRbxTrrvI269qUNckeg12T7DQerxfsRJW+vTJt4l7CpGJNUKWxGcm
	AsD7bc3HFYc17xEwF3fLx5N1Q1wRBtvpm7uEi/txwvj+JR7D0Cvtmh/vwMoQ94dxpgkP1u
	HvbEc2VkOvkV5QXC2XzqgUcP2vyv5UA=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-j5BVxaOXOlOoAy9lpm7MPQ-1; Tue, 16 Jan 2024 02:37:10 -0500
X-MC-Unique: j5BVxaOXOlOoAy9lpm7MPQ-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-429f3c43c66so16579251cf.1
        for <linux-serial@vger.kernel.org>; Mon, 15 Jan 2024 23:37:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705390630; x=1705995430;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t9a7YoYgTaMNvrbxSQpm4NYpVm30/3iqFRoXOjmXJSA=;
        b=cL5p6AwylEg9K2AzEwIvBaSlzFsagEIvtQjJjl0w59S5d/J9MRoeYNIdRHP3d6/oNA
         6q/q1n5GHOWeht2U5R+iy5U9VlSm2JubjPy7ueXw+DHtss7g8PAvPjplHA6tCjvKa3Qd
         1Ye90t0ZcieMOGUSj35BKoGEWV0NYVG6HcqrQUXzr0ZIElojyEZvfXbl+I0qZuLSBNGW
         CU47IaBqyRhOsbjqk5ZgPg6t2U3aSPp5Dxy8q62EEC2ESDED007e/Jw0/dSWe1rACT9f
         mk4bu/niu2DaE41uofLpzsc98Bvb9Unep42NP1RtJH5MOk75TNTayGsLvG2SIEQFGr0A
         cuJg==
X-Gm-Message-State: AOJu0Yyjkdkn3KkMOZxnN4kVb7bx6ugVvRtrQwbfQ+MM+Ui2dxSpG288
	sdgkk8pwWrU5adXYTChMCg4QOQxU2DseSeeDB8/iDIXJJnDdpJYHeHaoRW298svVfHLy69Zrfrb
	H9vkc/q1FFXGp2MUiIdtufHk3eqSK2jpY
X-Received: by 2002:ac8:7d82:0:b0:42a:165:a216 with SMTP id c2-20020ac87d82000000b0042a0165a216mr853360qtd.136.1705390630234;
        Mon, 15 Jan 2024 23:37:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEoBXmiC8fe9ZYUdR4WPMlWlaDwt97enJcNUHmw2NJlRzZEKeUUWUQutGVSJwOkOdiSj1cATw==
X-Received: by 2002:ac8:7d82:0:b0:42a:165:a216 with SMTP id c2-20020ac87d82000000b0042a0165a216mr853351qtd.136.1705390630010;
        Mon, 15 Jan 2024 23:37:10 -0800 (PST)
Received: from LeoBras.redhat.com ([2804:1b3:a803:64aa:6db9:6544:60c:9e16])
        by smtp.gmail.com with ESMTPSA id jc4-20020a05622a714400b00429acfe5bb4sm4650206qtb.40.2024.01.15.23.37.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 23:37:09 -0800 (PST)
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
Subject: [RESEND RFC PATCH v1 1/2] irq/spurious: Reset irqs_unhandled if an irq_thread handles one IRQ request
Date: Tue, 16 Jan 2024 04:36:59 -0300
Message-ID: <20240116073701.2356171-2-leobras@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116073701.2356171-1-leobras@redhat.com>
References: <20240116073701.2356171-1-leobras@redhat.com>
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

