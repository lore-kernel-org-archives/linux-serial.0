Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793220532;
	b=2ang4litS8vDRA/mqesA3ggmlAr6cniNyffpe7iV8f5k71f1C1nghIgByds5fgksGVyv
	 0wOXljxulKQKoSjkX2I0YL61VRGLey0zz9SXmH9V33vzykerRO0kgaTolZnQ2IXaI8BsL
	 9UmUofyZm638C6PGXcSjs9fjF8J6fIiSqHTtoRYG3TJ5OH6KRh7R1ryOyjF2GSx+4M2Az
	 37fjuVm3My3nmMHYq77pyQxTHvVXsQw9FWI7XJLKPPFi4Mqfs5lLoTCz67I8RmiR7T+1q
	 xCO1Mx8uZ2oHAikiUu3SMqZrPpYNV+fNmROYJU0uCVj96vO8m9SgbsLt58Cuq+qaNSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793220532;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=BH2WnjXWwsl9S26zTcVnDiXysm6ntQCEcJClsDwXCEM=;
	b=me6fHacZ1SwuXd0ohZdKuEZvPgK6erfUMfdcbzDKV+4r7C7BCdl8cOeefC+1MKPZ/owX
	 KBnkU+OLs3l86Myp1b51LxYgbH20MdhI5bpmLtC67PkLoBBOdYBvXMb5z1EFg4r/wavbH
	 qvW5i4fMQEaWXhgmYoIZzGEIAg60ARK7nRpz5Fr5sQtn7Xh27t0NPhs1kUfTbao0iJFV+
	 OQLI9kyzniu9v8yDn7qLh7WmHAdOF7A1w45zVJVW5pLRJnogdXIq/MUiKLPR2dlGkPMsC
	 ZFp2ELGBPuYk+54+4VDUAHpOWNj9chJYLLahHZlwnuJwfCxTsaLTcbuZE6Lv2J6T+Cw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=hog+4gaD;
	arc=none smtp.remote-ip=209.85.167.169
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A5B606A31A
	for <linux-serial@vger.kernel.org>; Wed, 28 Oct 2026 20:48:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D3A5B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=hog+4gaD
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-4b28d9537bcso61299b6e.0
        for <linux-serial@vger.kernel.org>; Wed, 28 Oct 2026 13:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1793220531; x=1793825331; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BH2WnjXWwsl9S26zTcVnDiXysm6ntQCEcJClsDwXCEM=;
        b=hog+4gaDZTli+TgRjxtIwGVoRxDUgKto7QyHMopwPE8rBLtbEGuptiXO3jXrBCj8lT
         FITAoRDkRVDsPDpDFiCj3p+mqfTLmYJIOaQxB/2K83W+vRO7BmxeJHxOVevxU+ZtOMES
         KpK/jEAy08rS4gMFmGyeDGiPC2I1B2DKkVtSk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793220531; x=1793825331;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BH2WnjXWwsl9S26zTcVnDiXysm6ntQCEcJClsDwXCEM=;
        b=xiaxz7KxP/y/hyBbu+5wb2sIqEz2vHnIB4o0b9liMVCiaIgGkiKWpL17WEK3H/M7Uv
         gcKRq0xjMDBsN32p2X3BvviPFRh5VCVQAIjcXus62nZFESYVN9MmIt5MRfArfQlYxIxJ
         ydfAxelDhejZ1sfBTWtK0LEnbTuOnOPbiyM+fPG3w3zGFc5KmI6O1yKS+vGxpIou7NOL
         IU0KFmGqN+KZZRak71uGT7TBqnaseR/H64yjhFWaqShIhcH6KRCKGhEAnPWmBUTJo0N5
         izb7cMpXBCWEFIbOaQN2HqQ7FQP3DoF5eg5K+5LK0S0RUp7kGvbsy9XYIaQsjrbBuSSA
         DyfA==
X-Forwarded-Encrypted: i=1; AKwUvBzXh5OZmLaxv/MdzABydp2bxNIqGSEU5dRa+ULs6bWbW66X+Vb0i3Jgc5Ypd61EXR43iHqWcY0YJVsNBFQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYIyt2nFNWfUQ62DozjlCQpIoezQCYk0y1LFw2kIw2I7K4PSxvBy
	H+D3QwNbN2NZoe2S/oj2VwKVuQ3zXvH3zoJD1tw1ASxVbZ/jluBTxgTJK4bjNncNEA==
X-Gm-Gg: AYBFou2GtRRML6RyQaZaaxetpj1A5/eIBMqhkTeo47STGYYGTbsUBcn86zDxJ/Qxi+t
	AcKOnclEMWGqJnzh17YB2HejfT5Uv0GCqEhsFWmIGf7LFuox9R/r0LxwOD66KOYp9EnHJXM+3LB
	sXssh9ZW4+GrL5BaEylrWAD1XyqlvCtXT7k+4ArTYVdonnT1slJN9INk/FzyB36sFD8t5FZvCZG
	G1RELiGAdu5OkdQr/PR4diEEpmj3K8bAWEhrU8+4rJPG74z96/kdHh0W4dJymYchUr/1VTkzCwe
	0wCTdGCXFmxxFN2GakmqCKsAwYwlY000Xel7ytWHvLOtZ2ozJUJ7CxrEp3r/KVAr3nQqCYBETM/
	jNmLI4Lc8PHAWzrQzcTH9dHyYCo6S/HBQwyjN6C1PjCZkpuBb/ApSc8djtFKurDLMqkto0TwLTo
	fVV4aWNInEsAFo6Z9x0xKB8bO5+Cj/3+XNkUkHO7H90mqT+RKVi/wwFb70Alj9hyS3MnhtM/y23
	ZneiHUZ8AFCMxxqnBt87FuKcHKs1xpUjJTl+H4tRrNhbI+gmnpxQEXQQmuewL7bIadCcQfgtzrf
	vKmFzEubuXhPvHEZltFLCSoCNBbr58nIjcOo+K5n38WnnsUT723/+qBBf/y45f/Wtj8j/qMQPIp
	19pT+ykflALxS/0UkP4ltFIZ6yhxwR6C9hC45b3M=
X-Received: by 2002:a05:6808:bca:b0:4b8:4703:db97 with SMTP id 5614622812f47-563efb4d666mr411105b6e.32.1793220530793;
        Wed, 28 Oct 2026 13:48:50 -0700 (PDT)
Received: from rrangel.c.googlers.com.com (202.168.136.34.bc.googleusercontent.com. [34.136.168.202])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-563c363902esm2281137b6e.2.2026.10.28.13.48.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 13:48:50 -0700 (PDT)
From: Raul E Rangel <rrangel@chromium.org>
To: James Hilliard <james.hilliard1@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Tony Lindgren <tony@atomide.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Richard Genoud <richard.genoud@bootlin.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Jacky Huang <ychuang3@nuvoton.com>,
	Shan-Chun Hung <schung@nuvoton.com>,
	=?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	"Maciej W. Rozycki" <macro@orcam.me.uk>,
	Timur Tabi <timur@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v7 2/5] serial: serialize asynchronous write wakeups with the port lock
Date: Wed, 28 Oct 2026 14:48:45 -0600
Message-ID: <20261028204847.3471382-1-rrangel@chromium.org>
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
In-Reply-To: <20261027-submit-serial-8250-dma-cancel-v1-v7-2-985a023ba4b4@gmail.com>
References: <20261027-submit-serial-8250-dma-cancel-v1-v7-0-985a023ba4b4@gmail.com> <20261027-submit-serial-8250-dma-cancel-v1-v7-2-985a023ba4b4@gmail.com>
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi James,

A few issues in this patch across the serial drivers:

1. Recursive self-deadlock on ltq_port->lock in drivers/tty/serial/lantiq.c:

> @@ -239,7 +239,8 @@ lqasc_tx_int(int irq, void *_port)
>  	spin_lock_irqsave(&ltq_port->lock, flags);
>  	__raw_writel(ASC_IRNCR_TIR, port->membase + LTQ_ASC_IRNCR);
>  	spin_unlock_irqrestore(&ltq_port->lock, flags);
> -	lqasc_start_tx(port);
> +	scoped_guard(uart_port_lock_irqsave, port)
> +		lqasc_start_tx(port);
>  	return IRQ_HANDLED;
>  }

Inside lqasc_start_tx():

	spin_lock_irqsave(&ltq_port->lock, flags);
	uart_port_tx(port, ch,
		lqasc_tx_ready(port),
		writeb(ch, port->membase + LTQ_ASC_TBUF));
	spin_unlock_irqrestore(&ltq_port->lock, flags);

uart_port_tx() invokes uart_write_wakeup(port) while ltq_port->lock is still
held (nested inside port->lock). If anything in the wakeup path or printk()
invokes lqasc_console_write() (which takes spin_lock_irqsave(&ltq_port->lock,
flags) at line 612), the CPU will immediately self-deadlock on ltq_port->lock.
ltq_port->lock should not be held across uart_write_wakeup(port).

2. Missed unlocked callers in drivers/tty/serial/dz.c, drivers/tty/serial/zs.c,
and drivers/tty/serial/jsm/jsm_cls.c:

The commit description states:
"Ensure every driver caller of uart_write_wakeup(), directly or through
uart_port_tx*() and uart_handle_cts_change(), holds the port lock first."

However:
- In drivers/tty/serial/dz.c: dz_transmit_chars() (lines 266-288) only locks
  &dport->port around dz_stop_tx(), calling uart_fifo_get(&dport->port, &tmp)
  at line 267 and uart_write_wakeup(&dport->port) at line 281 without holding
  dport->port.lock.
- In drivers/tty/serial/zs.c: zs_transmit_chars() (line 641) only acquires
  &scc->zlock, so zs_raw_transmit_chars() calls uart_fifo_get(&zport->port, &ch)
  (line 621) and uart_write_wakeup(&zport->port) (line 630) without holding
  zport->port.lock. In addition, zs_status_handle() (lines 673-680) drops
  &scc->zlock and calls uart_handle_cts_change(uport, ...) and
  uart_handle_dcd_change(uport, ...) with no lock held at all, which triggers
  lockdep_assert_held_once(&uport->lock) in serial_core.c.
- In drivers/tty/serial/jsm/jsm_cls.c: while jsm_neo.c wrapped
  neo_parse_modem() in scoped_guard(uart_port_lock_irqsave, &ch->uart_port),
  cls_parse_isr() in jsm_cls.c (line 585) still calls cls_parse_modem() ->
  uart_handle_dcd_change(&ch->uart_port, ...) without holding ch->uart_port.lock.

Also, in Patch 3/5, adding lockdep_assert_held_once(&port->lock); to
uart_write_wakeup() alongside uart_xmit_block() / uart_xmit_unblock() would
help catch any unlocked callers automatically.

Thanks,
Raul
