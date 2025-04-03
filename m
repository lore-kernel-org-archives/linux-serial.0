Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B713EAFA;
	Thu,  3 Apr 2025 13:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743687966; cv=none; b=gGw5Aj3DKVLl164da2WJdJ8gowmkfVqTUDbN+mlE05FN6Pf0n395gzS/qXSpRp3PWMusUpzE2QsFXlnOQYq0x+Wlp0wqxjlL1+gkL8uF7O+TPaXyypSkG5DUM9WeVBThKy0qXMIb52jmlqTrMTF1oIL154s+rqw75MU6cumMrHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743687966; c=relaxed/simple;
	bh=8T3oj5qftOc5yR7rZEJRVCAEG1OT0Bw8oj7KVkE+K+Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YOM+vPgtF6Eif9RwC+36/fazSagljUOi7Z8aLWS6FBmElfj4tIhpZe3i/jMXi4Wf3+/RmZL0Hw0WKu0b7a077//PagYB+5Nefx5+Om2JCHvRio4g8pgzUWzbwGJqcz3Mc6fQ2DIOAgM/8gssIdrEgeeWXscDDi1QMAUaaJxLV6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gKdMUrRk; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6if7d3ON; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gKdMUrRk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6if7d3ON"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1743687962;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=joUQlRuw5q09H6+Otx+UiPvsgPa/pX5Q7pVi0WnRdDk=;
	b=gKdMUrRkqHXAFdkRKI8q1u2BG1r2Rs5YxixPMt0iKtMA3Gj6oZifS6z7GWWtoKwxMmgr3B
	oDTlw3qZ209yyCCkwUn7Xs7MWq0H5YpdK3pwdfBboWayzCh6hFDX/saGkMKMlQAveEpUiw
	ALgKafyrkIyKnlYvmSUq804dqLTv907LrWExwq0l52akmaMSyrboVlxZ9UgKaX+C/Ob78e
	cRxmANi+2CVlebI2TRsD/5PAvd/led1l9g7QRyWq/tVz/ZvGd1gdWbBmjQEHRsPh4EWWA+
	21EvN6xc9Dg/1k0x5bc/xUWutgClVrpj/FFOnMQlx5fcvGgF3sHzw/4mIynq5Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1743687962;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=joUQlRuw5q09H6+Otx+UiPvsgPa/pX5Q7pVi0WnRdDk=;
	b=6if7d3ONoxO5Xob6z2GTuX/hT6U9pfieuK1Sn2ac84VShOkHq9FKt7mSgndmzyu027qsjx
	u1TgzllqMaqAR2CA==
To: yunhui cui <cuiyunhui@bytedance.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org, pmladek@suse.com,
 arnd@arndb.de, andriy.shevchenko@linux.intel.com, namcao@linutronix.de,
 benjamin.larsson@genexis.eu, schnelle@linux.ibm.com,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [External] Re: [PATCH] serial: 8250: fix panic due to PSLVERR
In-Reply-To: <CAEEQ3wkOQUh03Ggpf=mBWzNt1_Qtcv53gNXm7JH5Nban3tOtvQ@mail.gmail.com>
References: <20250403090336.16643-1-cuiyunhui@bytedance.com>
 <84iknl5uex.fsf@jogness.linutronix.de>
 <CAEEQ3wkOQUh03Ggpf=mBWzNt1_Qtcv53gNXm7JH5Nban3tOtvQ@mail.gmail.com>
Date: Thu, 03 Apr 2025 15:52:01 +0206
Message-ID: <84cydt5peu.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2025-04-03, yunhui cui <cuiyunhui@bytedance.com> wrote:
>>> When the PSLVERR_RESP_EN parameter is set to 1, the device generates
>>> an error response if an attempt is made to read an empty RBR (Receive
>>> Buffer Register) while the FIFO is enabled.
>>>
>>> In serial8250_do_startup, calling serial_port_out(port, UART_LCR,
>>> UART_LCR_WLEN8) triggers dw8250_check_lcr(), which invokes
>>> dw8250_force_idle() and serial8250_clear_and_reinit_fifos(). The latter
>>> function enables the FIFO via serial_out(p, UART_FCR, p->fcr).
>>> Execution proceeds to the dont_test_tx_en label:
>>> ...
>>> serial_port_in(port, UART_RX);
>>> This satisfies the PSLVERR trigger condition.
>>>
>>> Because another CPU(e.g., using printk) is accessing the UART (UART
>>> is busy), the current CPU fails the check (value & ~UART_LCR_SPAR) ==
>>> (lcr & ~UART_LCR_SPAR), causing it to enter dw8250_force_idle().
>>
>> Didn't this[0] patch resolve this exact issue?
>>
>> John Ogness
>>
>> [0] https://lore.kernel.org/lkml/20220713131722.2316829-1-vamshigajjela@google.com
>
> No, these are two separate issues. This[0] patch is necessary, as
> expressed in this comment:
>
> /*
> * With PSLVERR_RESP_EN parameter set to 1, the device generates an
> * error response when an attempt to read an empty RBR with FIFO
> * enabled.
> */
>
> The current patch addresses the following scenario:
>
> cpuA is accessing the UART via printk(), causing the UART to be busy.
> cpuB follows the CallTrace path:
> -serial8250_do_startup()
> --serial_port_out(port, UART_LCR, UART_LCR_WLEN8);
> ---dw8250_serial_out32
> ----dw8250_check_lcr
> -----dw8250_force_idle (triggered by UART busy)
> ------serial8250_clear_and_reinit_fifos
> -------serial_out(p, UART_FCR, p->fcr); (enables FIFO here)
> cpuB proceeds to the dont_test_tx_en label:
>    ...
>    serial_port_in(port, UART_RX); //FIFO is enabled, and the UART has
> no data to read, causing the device to generate a PSLVERR error and
> panic.
>
> Our solution:
> Relevant serial_port_out operations should be placed in a critical section.
> Before reading UART_RX, check if data is available (e.g., by verifying
> the UART_LSR DR bit is set).

OK, now I see. The problem is the explicit reads of UART_RX near the end
of serial8250_do_startup().

>> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
>> index 3f256e96c722..6909c81109db 100644
>> --- a/drivers/tty/serial/8250/8250_port.c
>> +++ b/drivers/tty/serial/8250/8250_port.c
>> @@ -2264,13 +2264,16 @@ int serial8250_do_startup(struct uart_port *port)
>>  	 * Clear the FIFO buffers and disable them.
>>  	 * (they will be reenabled in set_termios())
>>  	 */
>> +	uart_port_lock_irqsave(port, &flags);
>>  	serial8250_clear_fifos(up);
>> +	uart_port_unlock_irqrestore(port, flags);

Can you clarify why serial8250_clear_fifos() needs to be in a critical
section?

serial8250_do_shutdown() and do_set_rxtrig() also call
serial8250_clear_fifos() without holding the port lock.

>>>  	/*
>>>  	 * Clear the interrupt registers.
>>>  	 */
>>> -	serial_port_in(port, UART_LSR);
>>> -	serial_port_in(port, UART_RX);
>>> +	lsr = serial_port_in(port, UART_LSR);
>>> +	if (lsr & UART_LSR_DR)
>>> +		serial_port_in(port, UART_RX);

Do we care about the unchecked UART_RX in serial8250_do_shutdown()?

	/*
	 * Read data port to reset things, and then unlink from
	 * the IRQ chain.
	 */
	serial_port_in(port, UART_RX);
	serial8250_rpm_put(up);

	up->ops->release_irq(up);
}

Otherwise all other UART_RX reads are either checking UART_LSR_DR first
or are under the port lock.

John
