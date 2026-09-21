Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC63C4A485B;
	Mon, 21 Sep 2026 14:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790001585; cv=none; b=hW6zbyvgC2CsBqmlpjtmoeyD4e2f1rM5bsSBHYHCpYNogJpL1LbQTBxKtoB5zxRuZ92ij8hWIDAjEd3f5Dlp5P/Zjgx1p1MNtAYSLCxCOZUqm3i8C2QPOkyncWjqOxCl9cuM27OoVYZ5kdI4MWOylu5NR1s4mf7LMEXLZKY9gK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790001585; c=relaxed/simple;
	bh=dEs0EeFokSewEqO3rTrKgpg/CaLxRnu6jz4mUmfIUhI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uFYw21mlTAcQkIJ83kwtFixGvQ3bq0WhzJroocPzC1Z1/0/2hhAhOm1Z+HdNFtZP+nrJQzx4BU6nVMmaqmHtkr1N+Sl5GkPUhv7Kl01Wu5sQ9MuKdB15x/3eQi3DRI8B7wt9k81A9noUm6p3nZpYVKrl+B5uP0rE6Z95aq11xLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=m5F3mPAz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UpJyVfbO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="m5F3mPAz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UpJyVfbO"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1790001579;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rrPv/sjCWK03ZBOx8OWtcHgD7XKExSRFEuIO5bJxcwg=;
	b=m5F3mPAzAUBXyfcNt/leno2o2kNc5ZbxNvREk5xpEsmlVTlh6bNrqT7zwgu6799Mlj/Pg9
	r42f0J+Hs+r7WtXHCswxqHhtypZ2g9x1MKPtrtaeFKXeV6r1O9xN4n7BSl6bTfAV+HTk8M
	eAveb2fcfKtOwBzQ9urdND5VvELMqhJzcWa3NkE/HGI43EV/M0kl1tkKNJxi8GR87SIYEF
	UJC3cN6S5bwJqTUBgXx0mBGnsFqZMdh2QP7TkiYOIir4DorO9vowZm+kQnaUr2BBDvD8J6
	igIoO0Hg/aTFRXUAiIFxVLCksXjjvc55N5w/HIsm/gciGoi1bgO85TJF++zujw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1790001579;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rrPv/sjCWK03ZBOx8OWtcHgD7XKExSRFEuIO5bJxcwg=;
	b=UpJyVfbOHN9rW8l/H0HZLVYeXiUJeQDd289HRvsOKqkHkP7hp5dul6vJHWfx5vOdSycubK
	efa/Jj5PhdP1SIAQ==
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
Subject: [PATCH tty v2] serial: 8250: Change console_msr_work to IRQ_WORK_LAZY
Date: Mon, 21 Sep 2026 16:45:36 +0206
Message-ID: <20260921143939.170314-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change console_msr_work (defers MSR handling) to be IRQ_WORK_LAZY,
thus not raising an IRQ upon irq_work queueing. The irq_work is then
handled on the next kernel tick. This additional delay is acceptable
because any pending MSR handling is also performed in the interrupt
handler, if mctrl is queried, and during console resume. Using
IRQ_WORK_LAZY has the benefit of not needing to raise an IRQ for
each line of atomic console printing when modem control is active.

On a side note, the Tegra20 and Tegra30 platforms can hang if an
irq_work IRQ is raised while entering cpuidle states. This problem
was reproducible by performing atomic printing while entering cpuidle.
So this change also provides a workaround for these platforms (as
long as they are not running tickless). The discussion on this topic
is linked below.

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

base-commit: de7f683ff9e070ca19565373c546d736663e5512
-- 
2.47.3

