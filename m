Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19CD6369990;
	Fri, 28 Aug 2026 15:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787932696; cv=none; b=XgaXEfZLj+Kzwis9+gBve2J8CAusi3DYF5uVZn378fGHdCZDdW7uFM6nAiPEnYC1uYOXX4Z6FCHgjYCXKG5iE8Ed+NuBFKCKsZrAqZNJk1Vik/N5pNBzlqZwbMZ2dkCUe3wKFeousF6W1MGwhO/AQRHXFKH+PdOVwaquLZofrqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787932696; c=relaxed/simple;
	bh=kXM3WPJ3tATewexzn4VGqmViCzed+eZI4E+a+H4nor4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VILi7mpx//wDXV3sD7P8VHbUpfVbGDUsb3ELCEJFKOY+p76zhtxvcVnXYHi4WQkc8lnfGHFDp8+Y9o1yA5plz1lt88Fk5LsR/IkED2o1QfQCpyNIL5cUB0Z/0RETi9IMJkgH2m3vqccgA96gYsHDRPerupYEEARLlpegJ/8TOsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FmDtGMSS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UEgv/RID; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FmDtGMSS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UEgv/RID"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1787932693;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rgh58MAGYvQ1Zn4PPu/6ZIsV583PSM009P5dtMEC4qE=;
	b=FmDtGMSSpOXDYDwZBIpC28V/aSH4s3DhJ/XLmB/I2Z9EL45UoHrsWVmSWU5J/xsa/60BdV
	i3ZpXmnkiMcw/iqqiDczYXu+/Gkg4F76ITexhujlTm8a3Yyjno1spz6vXPQJuXKRon7y+n
	NlV9gr+XN3E57NFSbW9CS2WXx3oKSKvUrxR1sS2SDrMJnwOUIvoAjODlU/O0+H+hHsWie0
	PGJJtFmsXPfX7b2706bX1QlQLsygyoN3JyOfaBMf4H2TD+K8gGyKCMpPtUl9HoTzXBSX2x
	KA4dSPvAUS0iuBYORGBdjumAVVTlreRwxQl0Ar3fSIW80YXg1bzcbPyRPvdwCg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1787932693;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rgh58MAGYvQ1Zn4PPu/6ZIsV583PSM009P5dtMEC4qE=;
	b=UEgv/RIDaj8i2JXw+Cp3eUR8uGYbZ2L0y9JycF+rtD5ge7ASgLNcQ/C9Vu+rIu1sIjlipW
	uPV4bVX51WOKY9BA==
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Petr Mladek <pmladek@suse.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Jon Hunter <jonathanh@nvidia.com>,
	Thierry Reding <thierry.reding@kernel.org>,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Crescent Hsieh <crescentcy.hsieh@moxa.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	linux-serial@vger.kernel.org
Subject: [PATCH tty 1/1] serial: 8250: Change console_msr_work to IRQ_WORK_LAZY
Date: Fri, 28 Aug 2026 18:04:08 +0206
Message-ID: <20260828155811.270462-2-john.ogness@linutronix.de>
In-Reply-To: <20260828155811.270462-1-john.ogness@linutronix.de>
References: <20260828155811.270462-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For some platforms it is a problem to queue irq_work when entering
cpuidle states. Since irq_work is used for deferred MSR handling,
any atomic console printing when entering cpuidle states can lead
to the affected hardware hanging. Tegra20 and Tegra30 are examples
of such platforms. Avoiding raising the irq_work IRQ has shown to
circumvent the problem.

Change the console_msr_work to be IRQ_WORK_LAZY, thus not raising
an IRQ upon irq_work queuing. The irq_work is then handled on the
next interrupt (worst case, kernel tick).

Link: https://lore.kernel.org/lkml/f3757a75-0ba1-4558-bf57-f19ab7e59a4c@nvidia.com
Fixes: d3539347022a ("serial: 8250: Switch to nbcon console, take 2")
Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 drivers/tty/serial/8250/8250_port.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 38fa45e74a37a..1acb73e45f8a0 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -3597,7 +3597,7 @@ int serial8250_console_setup(struct uart_port *port, char *options, bool probe)
 
 	up->console_line_ended = true;
 	up->console_msr_work_allow = true;
-	init_irq_work(&up->console_msr_work, console_msr_handler);
+	up->console_msr_work = IRQ_WORK_INIT_LAZY(console_msr_handler);
 
 	if (options)
 		uart_parse_options(options, &baud, &parity, &bits, &flow);
-- 
2.47.3

