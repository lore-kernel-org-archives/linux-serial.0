Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334F5274650;
	Tue, 31 Mar 2026 23:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775001020; cv=none; b=OB637HaYtD/ZWhA68idtpJ0ar/RYH1us6PxE4ZmviIpxt3Ooq7DFMV09yoSsuhdevtnoVSevP7FrhPFmw1ASbYGeSNUXjTFMfz7QAMApyCZjeXTrh8T/3JzbTHMGL7b97lqXREWGr5rjzkRTVQWteqVgU+b3LbOraZbEwDSVDNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775001020; c=relaxed/simple;
	bh=drBWOmQ7byl8tjzcT4MXX66PuWhQklngBRBjbExaFaI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uLbUnrVhH1ExCtyhXKLR8lGtpWAebY9yGi3lLlp2J9pHnikEatvTH56A/+JTk5QXyKNAZl+oD0naH/fb5vxVEO9FznNt/FLKGyFYBxcbPpfOrJyWPDfDJ+74NjvJ7UnY/xWCrlYTgfCBUzzSU4NVgM49nioABp1hmFeszW0y6M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mEaduT/4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NgsPiMZo; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mEaduT/4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NgsPiMZo"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1775001017;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=J7g0QGKZA6HDO+SbBBI7E1aJ5E0ki/algL9M0b78iys=;
	b=mEaduT/4OMEtGGJ7G19kD4FDX3LuIkX/yESQDTw1G+hvr0Mrjx4CZWnTfOWY2fnes63rMg
	tlJnUAFSOoVwdoifB8+uvhDBqAq35ggqmAQFHIkREyRvRTOLG8GLVGTq27cVYr/XdSUpss
	VlH3uK/U2AnQ4ScVGkUBozD0Zlmb9ehVx3OZx6sbNm/5wGsazBJwgqhjzcDK8lbEA4jdTF
	lOTt+xp2A031V119CDlLWTQ45pN1BDr4ZMZhM2RjcH5O9KEXumnz+fk36F2pzNkEPQhteC
	hAcEqxmCC4auKOHT/CZOy9U/UJJquaXkBuNwA+hHjtcDqZNlF8kXiLzwR8qg9w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1775001017;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=J7g0QGKZA6HDO+SbBBI7E1aJ5E0ki/algL9M0b78iys=;
	b=NgsPiMZoszQwD27/zVlkpvSULvuO/4w6HdeYSyplnB8CfO/j4OjYYMzRa6AXALOb6svzkN
	a8Qt+Jp2kDwK/HCA==
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
 <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org, Ilpo =?utf-8?Q?J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>, Thomas Gleixner <tglx@kernel.org>, Ingo
 Molnar <mingo@kernel.org>, Xin Zhao <jackzxcui1989@163.com>, Andy
 Shevchenko <andy.shevchenko@gmail.com>, "Dr. David Alan Gilbert"
 <linux@treblig.org>, Joseph Tilahun <jtilahun@astranis.com>,
 linux-serial@vger.kernel.org
Subject: Re: [PATCH tty v1] serial: 8250: Add support for console hardware
 flow control
In-Reply-To: <20260331141502.6233-1-john.ogness@linutronix.de>
References: <20260331141502.6233-1-john.ogness@linutronix.de>
Date: Wed, 01 Apr 2026 01:56:16 +0206
Message-ID: <87pl4jtv7r.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi,

Responding to Sashiko:

https://sashiko.dev/#/patchset/20260331141502.6233-1-john.ogness%40linutronix.de

On 2026-03-31, Sashiko wrote:
> This commit addresses issues with hardware flow control on the 8250 console.
> It modifies the driver and serial core to properly initialize CTS polling
> and handle the 'r' console option.
>
>> diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
>> index d2e2c5dfef99..4ca7cac6b8a7 100644
>> --- a/drivers/tty/serial/8250/8250_core.c
>> +++ b/drivers/tty/serial/8250/8250_core.c
>> @@ -716,6 +717,9 @@ int serial8250_register_8250_port(const struct uart_8250_port *up)
>>  	if (uart->port.type == PORT_8250_CIR)
>>  		return -ENODEV;
>>  
>> +	/* Preserve specified console hardware flow control. */
>> +	console_hwflow = uart->port.flags & UPF_CONS_FLOW;
>> +
>>  	if (uart->port.dev)
>>  		uart_remove_one_port(&serial8250_reg, &uart->port);
>>  
>> @@ -757,6 +761,9 @@ int serial8250_register_8250_port(const struct uart_8250_port *up)
>>  			goto err;
>>  	}
>>  
>> +	if (console_hwflow)
>> +		uart->port.flags |= UPF_CONS_FLOW;
>> +
>
> Can this create a race window where console flow control is temporarily
> disabled? The UPF_CONS_FLOW flag is saved, but uart->port.flags is
> overwritten earlier in this function. If an asynchronous printk (such as
> from an NMI) triggers serial8250_console_write() before the flag is
> restored, it seems uart_console_hwflow_active() will evaluate to false,
> bypassing CTS polling and potentially dropping characters.

Correct. I missed that serial8250_register_8250_port() is called after
the console is already registered via univ8250_console_init(). I can
remove the window with something like the following alternative change
to serial8250_register_8250_port():

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index a428e88938eb7..ff4c9972d4576 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -693,6 +693,7 @@ static void serial_8250_overrun_backoff_work(struct work_struct *work)
 int serial8250_register_8250_port(const struct uart_8250_port *up)
 {
 	struct uart_8250_port *uart;
+	upf_t console_hwflow;
 	int ret;
 
 	if (up->port.uartclk == 0)
@@ -716,6 +717,9 @@ int serial8250_register_8250_port(const struct uart_8250_port *up)
 	if (uart->port.type == PORT_8250_CIR)
 		return -ENODEV;
 
+	/* Preserve specified console hardware flow control. */
+	console_hwflow = uart->port.flags & UPF_CONS_FLOW;
+
 	if (uart->port.dev)
 		uart_remove_one_port(&serial8250_reg, &uart->port);
 
@@ -729,7 +733,7 @@ int serial8250_register_8250_port(const struct uart_8250_port *up)
 	uart->port.fifosize     = up->port.fifosize;
 	uart->port.regshift     = up->port.regshift;
 	uart->port.iotype       = up->port.iotype;
-	uart->port.flags        = up->port.flags | UPF_BOOT_AUTOCONF;
+	uart->port.flags        = up->port.flags | UPF_BOOT_AUTOCONF | console_hwflow;
 	uart->bugs		= up->bugs;
 	uart->port.mapbase      = up->port.mapbase;
 	uart->port.mapsize      = up->port.mapsize;

>> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
>> index 328711b5df1a..71edac12473e 100644
>> --- a/drivers/tty/serial/8250/8250_port.c
>> +++ b/drivers/tty/serial/8250/8250_port.c
>> @@ -1988,7 +1988,7 @@ static void wait_for_xmitr(struct uart_8250_port *up, int bits)
>>  	wait_for_lsr(up, bits);
>>  
>>  	/* Wait up to 1s for flow control if necessary */
>> -	if (up->port.flags & UPF_CONS_FLOW) {
>> +	if (uart_console_hwflow_active(&up->port)) {
>>  		for (tmout = 1000000; tmout; tmout--) {
>>  			unsigned int msr = serial_in(up, UART_MSR);
>>  			up->msr_saved_flags |= msr & MSR_SAVE_FLAGS;
>>  			if (msr & UART_MSR_CTS)
>>  				break;
>>  			udelay(1);
>>  			touch_nmi_watchdog();
>>  		}
>>  	}
>>  }
>
> Does this sequence of checks cause data loss when CTS is deasserted?
> If wait_for_lsr() times out because the UART halts transmission, the holding
> register remains full. When CTS is subsequently asserted, the loop breaks
> and the function returns immediately without waiting for the holding register
> to actually empty. Will the next character overwrite the current one before it
> can be shifted out?

Correct. My patch does not address errors in the CTS polling, but
perhaps it should (since I am activating CTS polling). In this case I
suppose one final wait_for_lsr() is appropriate. Something like:

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 88f5309a940e9..18bc5600df181 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -1984,16 +1984,20 @@ static bool wait_for_lsr(struct uart_8250_port *up, int bits)
 static void wait_for_xmitr(struct uart_8250_port *up, int bits)
 {
 	unsigned int tmout;
+	bool lsr_timeout;
 
-	wait_for_lsr(up, bits);
+	lsr_timeout = wait_for_lsr(up, bits);
 
 	/* Wait up to 1s for flow control if necessary */
 	if (uart_console_hwflow_active(&up->port)) {
 		for (tmout = 1000000; tmout; tmout--) {
 			unsigned int msr = serial_in(up, UART_MSR);
 			up->msr_saved_flags |= msr & MSR_SAVE_FLAGS;
-			if (msr & UART_MSR_CTS)
+			if (msr & UART_MSR_CTS) {
+				if (lsr_timeout)
+					wait_for_lsr(up, bits);
 				break;
+			}
 			udelay(1);
 			touch_nmi_watchdog();
 		}

> Also, could this polling loop cause a system stall?
> If the remote peer deasserts CTS (for example, if a terminal is disconnected),
> wait_for_xmitr() will poll for 1,000,000 microseconds. Since this is called
> for every single character during a printk, a standard 50-character printk
> could potentially stall the entire system for 50 seconds while holding the
> console lock.

Yes, this is a problem (for !PREEMPT_RT). But that is how console
hardware flow control is implemented. It is out of scope of my patch to
completely re-implement the CTS polling mechanism. AFAICT the other
serial drivers that already support console hardware flow control have
the same problem. Does this need to be resolved as a pre-requisite to my
patch?

>> @@ -3421,6 +3427,10 @@ int serial8250_console_setup(struct uart_port *port, char *options, bool probe)
>>  	if (ret)
>>  		return ret;
>>  
>> +	/* Allow user-specified hardware flow control. */
>> +	if (flow == 'r')
>> +		port->flags |= UPF_CONS_FLOW;
>> +
>>  	if (port->dev)
>>  		pm_runtime_get_sync(port->dev);
>
> Should this flag be cleared if flow != 'r'? By only setting the flag, it
> appears hardware flow control cannot be dynamically disabled once it has
> been enabled.

The flag comes from a boot argument. Boot arguments never change during
runtime. The hardware flow control can still by dynamically disabled by
disabling CRTSCTS via termios. For example:

# stty -F /dev/ttyS0 -crtscts

>> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
>> index 89cebdd27841..cce1fd728a1e 100644
>> --- a/drivers/tty/serial/serial_core.c
>> +++ b/drivers/tty/serial/serial_core.c
>> @@ -2235,6 +2235,15 @@ uart_set_options(struct uart_port *port, struct console *co,
>>  	port->mctrl |= TIOCM_DTR;
>>  
>>  	port->ops->set_termios(port, &termios, &dummy);
>> +
>> +	/*
>> +	 * If console hardware flow control was specified and is supported,
>> +	 * the related policy UPSTAT_CTS_ENABLE must be set to allow console
>> +	 * drivers to identify if CTS should be used for polling.
>> +	 */
>> +	if (flow == 'r' && (termios.c_cflag & CRTSCTS))
>> +		port->status |= UPSTAT_CTS_ENABLE;
>> +
>
> Similar to the previous question, should UPSTAT_CTS_ENABLE be cleared
> if flow != 'r' to prevent the state from leaking?

This is a valid question. My patch is trying to be maximally
conservative and only make changes to allow CTS polling to become active
when 'r' is specified. For all other cases I do not want behavior
changes. Particularly since this is a function within serial_core.

> Additionally, does port->status need to be protected by the port lock here?
> Since this is a read-modify-write operation, and uart_set_options() can
> be invoked dynamically (like from kgdboc via tty_find_polling_driver()),
> could this race with concurrent modifications to port->status?

Yes. I was only considering the boot case where the tty layer is not yet
active. :-/ It seems some drivers are only taking the port lock for
@status updates.

The comments in serial_core.h say "Must hold termios_rwsem, port mutex
and port lock to change" but AFAICT the main @status modifiers are only
taking the last 2 locks. Still, the port mutex cannot be taken in
uart_set_options().

I would really like to leverage the UPSTAT_CTS_ENABLE policy bit. I will
need to think about this some more...

John Ogness
