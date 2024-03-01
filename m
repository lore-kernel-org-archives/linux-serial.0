Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB1E3B19B
	for <linux-serial@vger.kernel.org>; Fri,  1 Mar 2024 21:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709329973; cv=none; b=AePAZoj7xLKl8uaepwOFPpSDRhPqaLlDyT6AS/LyhxCTE1Hf6pNvapsFo9PnS2jqIFJAI/b7qjd8vj5u8LX/xDjzyd6Ez9CeW4sn/02U4iiFZjJt9jwQu0i5lxcsxrlyXhByim4PjTg0uHqrtBKM7+sPmZIxCm8AAk/Z50zEZ7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709329973; c=relaxed/simple;
	bh=jlPV1DYL9VBVcBbE3Bu/5bJMvVhoHv6Uo6Yu94DQcVk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=djNeHWeMWjmRmzcKAbageDA95dnVLqDSuMt0UCutFHVgMKTmXT9sUXUtt0rm1YEeuI1tGFt/0Rr2rbD9ICu3HXf5zp1on0sRdI00N/lonjS5+GIuRoSUQ8/e9ZXJ4Tv5DD8uqgHXir+eB3ZafCvGXiXlXQ/M8KIGF29NoHpOM40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=saFoIxg5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3h/WbNQO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="saFoIxg5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3h/WbNQO"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709329970;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rOlb6ikceE4M59+ogHkDifqxVc1ui/MBOsJv2E7BYL4=;
	b=saFoIxg5+G7idzzrNc0aMawxikvPEAEtV/b65twnW4PO8kjY6CHrQxJQsy+uF1ytuCIrvS
	yp747HNVykOhS5Ko7XGTYdak0UK6OBlGA6IPz1u9uB7t2UFD3xa8dveICr2lgTiNwU9JDs
	NbWMwUxg03ZAcH4c4DyUzfORw/w3TnhTlrz6z4HHtVyaEgHQJ2KdGY2wWhpZMMDIcvcx++
	D9drUxDxtTA62vC93uHmtvRawizygdJDKIAM8cMQKYmDrLJPkIVGecPksGiXhioXwHNgcu
	GyGgjefewU9s07I/3r+W1lDLk14qrVFjUuV2ETS3epNn6CqR4hLT7BMrYY4q1A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709329970;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rOlb6ikceE4M59+ogHkDifqxVc1ui/MBOsJv2E7BYL4=;
	b=3h/WbNQOetrhhANwz4XLsLbSCrgBCThddrMbE18qTZkHCNtKYpIQRYtB1Ff9svHaBaDA2M
	w1HqJ7c92jZF2aCQ==
To: linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 00/18] serial: Use uart_prepare_sysrq_char().
Date: Fri,  1 Mar 2024 22:45:13 +0100
Message-ID: <20240301215246.891055-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

A few driver do in their console_write() callback something like

|	local_irq_save(flags);
|	if (sysrq)
|		locked =3D 0;
|	else if (oops_in_progress)
|		locked =3D uart_port_trylock(port);
|	else
|		uart_port_lock(port);

which breaks on PREEMPT_RT because the uart_port lock becomes a sleeping
lock and it can not be acquired with disabled interrupts. The PREEMPT_RT
queue has workarounds for a few of them. I tackled ever UART driver with
that pattern. The changes are mostly the same:
- Replace direct sysrq handling with delayed by using
  uart_prepare_sysrq_char(). This removes the first 'if (sysrq)' check.

- Remove local_irq_save() und use the _irqsave suffix for both of the
  locking functions.

The drivers can be categorized as
- Did not handle sysrq at all but does now
  - lpc32xx_hs
  - owl
  - rda
  - sifive

- Dropped the uart_port while invoking the sysrq callback but
  console_write did not acquire uart_port-lock as it should.
  - amba-pl011
  - msm
  - rda

  Don't think this is a serious problem.

- The IRQ service routine is always invoked with disabled interrupts and
  the _irqsave() suffix was dropped while switching to
  uart_prepare_sysrq_char().
  - msm
  - owl

- Nothing special, just converted
  - ar933x
  - bcm63xx
  - meson
  - omap
  - pxa
  - sunplus

- Required love & cuddling to get on track
  - pch

The series has been compiles tested on x86-64, arm, arm64.

Sebastian
