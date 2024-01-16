Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2019111B2
	for <linux-serial@vger.kernel.org>; Tue, 16 Jan 2024 07:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dE02NQqJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705390634;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ev/EHro7bSIb21ohSGiRASekMY9/Fc0MaRbZNwxLwJc=;
	b=dE02NQqJCHt5i4JG9QwEV7PFhImqdK24fCBtiW1mPAmsDPfoP2J5N2AzfSPZpZmWPcBZw2
	CaS2k9NMUZrcxwFd1U0WxAkE2uZjMHsw4yXbzhSotaCrKdjIxjFkL87jKnESKYkNWH0aek
	ySdJm8Tc0VXZi3MClHA/YWI3E6ry36s=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-96-W7MRqHY-PcieeD8xmJqMXg-1; Tue, 16 Jan 2024 02:37:13 -0500
X-MC-Unique: W7MRqHY-PcieeD8xmJqMXg-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-681684ca881so10823296d6.2
        for <linux-serial@vger.kernel.org>; Mon, 15 Jan 2024 23:37:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705390632; x=1705995432;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ev/EHro7bSIb21ohSGiRASekMY9/Fc0MaRbZNwxLwJc=;
        b=l57OKwoJwm/TUWlSUGH31ObmEZDDtXxrvjFsUAwAOvs4/Fdsqh6ylTujHw3S5H8w1E
         dmyGI2UOiPtnkRO25NKcKXZg0SffcLRWRUxj3Bo3BsQ3KYE6Gk6QyC3H8gM4fYnyUg3O
         fNpfiBlZSYo69h4XkqtoT/v/YN9HMQNq70J6GXhhgSdU3LeLV8QY7mN0hcq3CFzxjfPV
         O5z2QXukQxZGg31jVcS6DeppmoiR6iQJDnzrD6P728AI8fpn7zx0VJXICfrHTq/m4r6i
         D1q7xHe48pmenAO1KHAuvXxTVsNfZOedX0AcsC6Ma18PqwDhS2CIldA8zpwhWW7B0LGV
         viDA==
X-Gm-Message-State: AOJu0YwfEP8DS2deuwGcHt6K5m4Vjf4nE6AAF9TdRuDky89MZ+id0ozs
	UO4tR/ldpW4+NCOfiToelpWHIWoy4xpFg9x35xQu1lcTXDZj8ugaPKUl6vKpSfDUjgksEGdkljz
	eSQBZS142JE1ypr0NV9P3i/KvhxGHb7QwX3q+XiAZ
X-Received: by 2002:ad4:5b8f:0:b0:681:5c24:723 with SMTP id 15-20020ad45b8f000000b006815c240723mr4640538qvp.46.1705390632761;
        Mon, 15 Jan 2024 23:37:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGrNcqol/OiEQ5ZrUIjTn7g2kuQvDjo2VGcjjAoLMRJtf3rUoTzhAFjIwMmgvbUMKAlwvpo2Q==
X-Received: by 2002:ad4:5b8f:0:b0:681:5c24:723 with SMTP id 15-20020ad45b8f000000b006815c240723mr4640532qvp.46.1705390632538;
        Mon, 15 Jan 2024 23:37:12 -0800 (PST)
Received: from LeoBras.redhat.com ([2804:1b3:a803:64aa:6db9:6544:60c:9e16])
        by smtp.gmail.com with ESMTPSA id jc4-20020a05622a714400b00429acfe5bb4sm4650206qtb.40.2024.01.15.23.37.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 23:37:12 -0800 (PST)
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
Subject: [RESEND RFC PATCH v1 2/2] serial/8250: Avoid getting lock in RT atomic context
Date: Tue, 16 Jan 2024 04:37:00 -0300
Message-ID: <20240116073701.2356171-3-leobras@redhat.com>
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

With PREEMPT_RT enabled, a spin_lock_irqsave() becomes a possibly sleeping
spin_lock(), without preempt_disable() or irq_disable().

This allows a task T1 to get preempted or interrupted while holding the
port->lock. If the preempting task T2 need the lock, spin_lock() code
will schedule T1 back until it finishes using the lock, and then go back to
T2.

There is an issue if a T1 holding port->lock is interrupted by an
IRQ, and this IRQ handler needs to get port->lock for writting (printk):
spin_lock() code will try to reschedule the interrupt handler, which is in
atomic context, causing a BUG() for trying to reschedule/sleep in atomic
context.

So for the case (PREEMPT_RT && in_atomic()) try to get the lock, and if it
fails proceed anyway, just like it's done in oops_in_progress case.

Signed-off-by: Leonardo Bras <leobras@redhat.com>
---
 drivers/tty/serial/8250/8250_port.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 8ca061d3bbb92..8480832846319 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -3397,7 +3397,7 @@ void serial8250_console_write(struct uart_8250_port *up, const char *s,
 
 	touch_nmi_watchdog();
 
-	if (oops_in_progress)
+	if (oops_in_progress || (IS_ENABLED(CONFIG_PREEMPT_RT) && in_atomic())
 		locked = uart_port_trylock_irqsave(port, &flags);
 	else
 		uart_port_lock_irqsave(port, &flags);
-- 
2.43.0

