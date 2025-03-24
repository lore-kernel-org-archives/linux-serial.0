Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003B42627F5;
	Mon, 24 Mar 2025 15:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742829870; cv=none; b=WTVXlbX5dCjuwj8c/6BCHSXvc3iu47GKzgAY2gfxy5yqAmIfUCSOkBg395/2GIlw9ldD0WdUoezcHnWU+ejjqMn/WarwhDY4yA6crMYKyGGub99TxyR/6qvlYn3G/RvJ5iY24cZY/VorZ6E24kGB0o0rcBy4qAj1KJ2+6ylcHmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742829870; c=relaxed/simple;
	bh=7q+nKUbKNhyhktIiTR7GrBfCuyLAr0XwfMKzvmg511o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=a39nG3ZKLHtgPIIMh7uR2LDblc1xl5NrvhY3Q3GrDSxJsxvgCK5GFV/ne8T/btgNgIq13tGrSarO/xbYLyZESh2/NTM2d/LxUuAJTa1LAFyzOztO20hq9GF/ye57Sk7WeulxeWXsa16taOkjZgBtTTVFwdbER1ffjPGvWVMPu0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TGeVw+8p; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XaiCGOxd; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TGeVw+8p";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XaiCGOxd"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742829861;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jRrIB+zDteaSXRYqxWriyHX454y+VkB0De55x4GzBvk=;
	b=TGeVw+8pkcSvBNuPmnAf0Ivc1s2XnHagca3sg7spp526UKUSrce30RG8h0aA88YDXbrEiw
	pwJXg7R757B3Z0GaVLwDZONvnybOJ30Vnac4qpOXTwk34oF+ePSAKU3+ILln/rnVNUXOHS
	Pi3ukfmp0r0PD2WHvCPpttRugUa/g33TQPmMYMn1RSR8Iew3TcRY5Rkv004jpyA/O4bySF
	falp5ShQ64bFtNURR2teuoqVys2o1Ky21zqM0tzc2EjWeYJdyFwGWbWuRkayEh+yMdeBX0
	jyLdwqyHPv7BZyRc+Bh/zUKykF4aNwllVOs/IUI+0+domX7em/hsbhmOnlG/gQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742829861;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jRrIB+zDteaSXRYqxWriyHX454y+VkB0De55x4GzBvk=;
	b=XaiCGOxdtLXu/JxZ/a6rU1g0WPB1Doy+6lzB272lBaC+rGkX/RkUvaXyXKRfofNCOieFw+
	NvtPGMEA2YDS9BCg==
To: Ryo Takakura <ryotkkr98@gmail.com>, gregkh@linuxfoundation.org,
 jirislaby@kernel.org, paul.walmsley@sifive.com, samuel.holland@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, pmladek@suse.com
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 linux-riscv@lists.infradead.org, Ryo Takakura <ryotkkr98@gmail.com>
Subject: Re: [PATCH] serial: sifive: Switch to nbcon console
In-Reply-To: <20250323060603.388621-1-ryotkkr98@gmail.com>
References: <20250323060603.388621-1-ryotkkr98@gmail.com>
Date: Mon, 24 Mar 2025 16:30:20 +0106
Message-ID: <84sen2fo4b.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Ryo,

On 2025-03-23, Ryo Takakura <ryotkkr98@gmail.com> wrote:
> Add the necessary callbacks(write_atomic, write_thread, device_lock
> and device_unlock) and CON_NBCON flag to switch the sifive console
> driver to perform as nbcon console.
>
> Both ->write_atomic() and ->write_thread() will check for console
> ownership whenever they are accessing registers.
>
> The ->device_lock()/unlock() will provide the additional serilization
> necessary for ->write_thread() which is called from dedicated printing
> thread.
>
> Signed-off-by: Ryo Takakura <ryotkkr98@gmail.com>

This driver has the same issue that the 8250 previously had. The
->startup() and ->shutdown() callbacks are called without the port
lock. However, the sifive driver is accessing SIFIVE_SERIAL_IE_OFFS in
these callbacks and this register is also accessed by the ->write()
callback. This needs to be synchronized.

The related 8250 patches fixing this are startup [0] and shutdown [1]. I
am assuming the following change would be sufficient:

diff --git a/drivers/tty/serial/sifive.c b/drivers/tty/serial/sifive.c
index d032de6199af..1de1b2a5833d 100644
--- a/drivers/tty/serial/sifive.c
+++ b/drivers/tty/serial/sifive.c
@@ -564,8 +564,11 @@ static void sifive_serial_break_ctl(struct uart_port *port, int break_state)
 static int sifive_serial_startup(struct uart_port *port)
 {
 	struct sifive_serial_port *ssp = port_to_sifive_serial_port(port);
+	unsigned long flags;
 
+	uart_port_lock_irqsave(&ssp->port, &flags);
 	__ssp_enable_rxwm(ssp);
+	uart_port_unlock_irqrestore(&ssp->port, flags);
 
 	return 0;
 }
@@ -573,9 +576,12 @@ static int sifive_serial_startup(struct uart_port *port)
 static void sifive_serial_shutdown(struct uart_port *port)
 {
 	struct sifive_serial_port *ssp = port_to_sifive_serial_port(port);
+	unsigned long flags;
 
+	uart_port_lock_irqsave(&ssp->port, &flags);
 	__ssp_disable_rxwm(ssp);
 	__ssp_disable_txwm(ssp);
+	uart_port_unlock_irqrestore(&ssp->port, flags);
 }
 
 /**

The fix should be applied first (and likely Cc stable) since it is
fixing an existing mainline problem.

Your patch also needs the synchronization. The ->write_atomic() callback
does not use the port lock. However, the uart_port_*() functions also
take the nbcon console ownership, so they synchronize against
->write_atomic() callbacks.

Otherwise, this patch looks good. If the ->startup() and ->shutdown()
callbacks are fixed in a previous patch, feel free to add:

Reviewed-by: John Ogness <john.ogness@linutronix.de>

to this patch.

John Ogness

[0] https://lore.kernel.org/lkml/20230525093159.223817-2-john.ogness@linutronix.de
[1] https://lore.kernel.org/lkml/20230525093159.223817-9-john.ogness@linutronix.de
