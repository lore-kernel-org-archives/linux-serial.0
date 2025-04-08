Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D106426156E;
	Tue,  8 Apr 2025 12:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744115308; cv=none; b=QjFOCtWnir/J8ZnICY4gAdEm+Ygew8EP/EQSV5eYNE3O+fLVHBK0l9nKmmiof3psXnuS7N4XnsYnNdnO3/RcdvfORlREnCZ+sqU1//Fn3IvZH+qevPNoI8ixEjprnus6O+uf7CtyZDSLyZdZJNrcuMKhBNZRsNWnCcnghXT3Wec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744115308; c=relaxed/simple;
	bh=NCeWg0s9VQQlDDR6/jZTJWDMUKyOApEDxvm6/O7IKUc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RtTfc7k6c9uikS0vHeir6d1G+3dj4O0oIAaAkZeu+C2XktZJFCUThMHU69M+JeGHLULMl0j/UrbeTNOqPr/aRfNLXltBAwFB0ZjyFBrj9khDWwNcfJTV2JrEKyOgN0rYTofe7FD7jbJbDFQEHQNV8AEh8X1P2D3HWg6zYnUKkZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ensm72M9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cm16+ioB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ensm72M9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cm16+ioB"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744115305;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NCeWg0s9VQQlDDR6/jZTJWDMUKyOApEDxvm6/O7IKUc=;
	b=ensm72M9yZ2NX9fnKMJrXUDBN9SfqKWFo0VLf5Z7ORbIO5a15uWkG8ZymcWyRHjdtb32GE
	VWOvz0lhh6Epdg6Lm5ciDsRTooTkvG/93BqGzcnJvzSSo/TtO8yRi1ku9Sz3h9P0MZiPIw
	ddkQeKZt+dKDsvWdDNexpzdlkmmcjNoPU1a1eIM+Cs2+65ju8BT3VRo+SSpLA6UEOPrfnV
	gsYGpXwDSbXjoAFJho33PC4+XeGKTFJUo77SfRN/hxuRUyyWEKPjjU7C0kkIiVDBa0RZSS
	m9RSunBRcqdIoqKLGn+TrBI7Wh0csjV2P4kDCcMdtrd0VW5Mz1ax6bD++Q9Tdg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744115305;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NCeWg0s9VQQlDDR6/jZTJWDMUKyOApEDxvm6/O7IKUc=;
	b=cm16+ioBeLtQyOIkqIx0wHqDs7HT5AEpuR14XucWvfTJgBddrrHOmCbCbBDSKJFlfyIBsp
	2BrGcEz8XJnRMWBg==
To: Yunhui Cui <cuiyunhui@bytedance.com>, gregkh@linuxfoundation.org,
 jirislaby@kernel.org, pmladek@suse.com, arnd@arndb.de,
 andriy.shevchenko@linux.intel.com, namcao@linutronix.de,
 benjamin.larsson@genexis.eu, schnelle@linux.ibm.com,
 matt.porter@linaro.org, tim.kryger@linaro.org, markus.mayer@linaro.org,
 heikki.krogerus@linux.intel.com, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org
Cc: Yunhui Cui <cuiyunhui@bytedance.com>
Subject: Re: [PATCH v2] serial: 8250: fix panic due to PSLVERR
In-Reply-To: <20250408061200.76148-1-cuiyunhui@bytedance.com>
References: <20250408061200.76148-1-cuiyunhui@bytedance.com>
Date: Tue, 08 Apr 2025 14:34:24 +0206
Message-ID: <84bjt6rg5z.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2025-04-08, Yunhui Cui <cuiyunhui@bytedance.com> wrote:
> When the PSLVERR_RESP_EN parameter is set to 1, the device generates
> an error response if an attempt is made to read an empty RBR (Receive
> Buffer Register) while the FIFO is enabled.
>
> In serial8250_do_startup(), calling serial_port_out(port, UART_LCR,
> UART_LCR_WLEN8) triggers dw8250_check_lcr(), which invokes
> dw8250_force_idle() and serial8250_clear_and_reinit_fifos(). The latter
> function enables the FIFO via serial_out(p, UART_FCR, p->fcr).
> Execution proceeds to the dont_test_tx_en label:
> ...
> serial_port_in(port, UART_RX);
> This satisfies the PSLVERR trigger condition.
>
> Because another CPU(e.g., using printk()) is accessing the UART (UART
> is busy), the current CPU fails the check (value & ~UART_LCR_SPAR) ==
> (lcr & ~UART_LCR_SPAR), causing it to enter dw8250_force_idle().
>
> To resolve this issue, relevant serial_port_out() operations should be
> placed in a critical section, and UART_RX data should only be read
> when the UART_LSR DR bit is set.

The UART_LSR_DR check still has a race condition if the console is in
RS485 mode and !SER_RS485_RX_DURING_TX. It seems DW supports this mode
as there is code in dw8250_rs485_config() that sets DW_UART_TCR
differently for this.

In this mode, serial8250_console_write() will call the callback
->rs485_stop_tx(), which for DW is serial8250_em485_stop_tx(). And this
calls serial8250_clear_and_reinit_fifos().

To really close this race, all UART_RX reads would need to be under the
port lock. Most of them already are.

John Ogness
