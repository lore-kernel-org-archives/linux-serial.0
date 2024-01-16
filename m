Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB53111B2
	for <linux-serial@vger.kernel.org>; Tue, 16 Jan 2024 07:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fGbu0LVZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705390376;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ev/EHro7bSIb21ohSGiRASekMY9/Fc0MaRbZNwxLwJc=;
	b=fGbu0LVZz+Wqk7i06JYmVGaC7V+dqwnvlq0cmwdD+QYKXqseGAQnj5epVCBEvfFmeu3NpK
	aG169ew7MKltDtD4fmvc1zXbmmC5ZSEXmM9R2bEYqCFE+fqpbHbZB5nLWKV1Uy3C7GpNuE
	xmbs3aADk4m/NN2zkqAEDsSkSd8pfYs=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-374-RS1fPBXPNl2DJcy9ujO_9g-1; Tue, 16 Jan 2024 02:32:55 -0500
X-MC-Unique: RS1fPBXPNl2DJcy9ujO_9g-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-42996d4e949so84501871cf.1
        for <linux-serial@vger.kernel.org>; Mon, 15 Jan 2024 23:32:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705390374; x=1705995174;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ev/EHro7bSIb21ohSGiRASekMY9/Fc0MaRbZNwxLwJc=;
        b=aWoW88lyzuD3Js28aUhxXi0sq+JON+/DXFc0HBOxeuygwmzqecw8BOEPAA7ArUP/vo
         E99c89cX2/IsWNwurRVLtNQ4ROKlTPrLF0jPnXNcZOgH9Br5qYry4iBOTFXa6D2DbjmA
         Py4uzFJb45CWDCh9tVjoKvv7ribmqbsN7F7ZQhi87tTtegmE22AIIPNvGuOTNU0SLGvY
         U/4MsXkZAxaxi6ITF6HaoyNqyT3LdqVEVMLT9T779pprX0rATk7XISAjziEtx9o2SFcd
         x0LeO1NsLWxCeFgp2tdS7SaJl5c5D8qN0v2yZy+OqQBuOplSJ5SGD3f+KpFrR7xSXobR
         mX1w==
X-Gm-Message-State: AOJu0YyL/XxNe52Y275FyiVHywJSGORnuVjEHtxjqrUrHMXzc8QKw2ij
	Zi14YNl5lS8tGyXJePgVy2KEVJiimessnHLRTjGoV6WCUi5dzTGk2+TvYO23Q0RgVhCnFYGD991
	pfTH7xsePthzZN9hCUbnJkVJ5qK84XzZG
X-Received: by 2002:ac8:5bd2:0:b0:429:bdfc:3680 with SMTP id b18-20020ac85bd2000000b00429bdfc3680mr8717446qtb.97.1705390374497;
        Mon, 15 Jan 2024 23:32:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGHJFpf/6ubQH2AthihuOoclhl9uHSJCCwkM4TRoRQC4bETdfKc++ioE0Ea8rqkV6W4u5nMvQ==
X-Received: by 2002:ac8:5bd2:0:b0:429:bdfc:3680 with SMTP id b18-20020ac85bd2000000b00429bdfc3680mr8717434qtb.97.1705390374251;
        Mon, 15 Jan 2024 23:32:54 -0800 (PST)
Received: from LeoBras.redhat.com ([2804:1b3:a803:64aa:6db9:6544:60c:9e16])
        by smtp.gmail.com with ESMTPSA id bs6-20020ac86f06000000b00429d6bd085csm3191262qtb.6.2024.01.15.23.32.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 23:32:53 -0800 (PST)
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
Subject: [RFC PATCH v1 2/2] serial/8250: Avoid getting lock in RT atomic context
Date: Tue, 16 Jan 2024 04:32:33 -0300
Message-ID: <20240116073234.2355850-4-leobras@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116073234.2355850-2-leobras@redhat.com>
References: <20240116073234.2355850-2-leobras@redhat.com>
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

