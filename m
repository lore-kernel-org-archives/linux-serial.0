Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A763F358379;
	Thu, 16 Apr 2026 10:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776334357; cv=none; b=RUGC6B51Rsz4t11EZb7M5bIonXcGEkK6BBpuu3494FY0DpzJcLHd1CHORzSVy/ZsCNKz/NIbrukxANmuqRHUWcVF8bytHLk36KDWzlhJeE8ZCd3dBjWnmxV+ZKx75gL0ENFJhXyPztRgaHJFzNurR1k15WyFHF/2FD3T6FRug1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776334357; c=relaxed/simple;
	bh=+U4auGjX+lsm5JCp/eN1tLigJw0cw7U4eKX0HAR0Jbs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MkN45QTGOxHXsiQt5AR9EWc/Gjd76pvI+ObwiqgRXWhlazeWAqtS7IyoVvQiVCwgnvyNuS5f9qb3tVVtsfJJSCLn0/I8Z6/9d1TLasxkKllwUm44PmhasxEbJplfIz+Vg4/aNN21e898IImLirnhkL6b7RHtnoh1J9fYG/V99oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bxZmRZXw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=C8NoVq8+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bxZmRZXw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="C8NoVq8+"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1776334353;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kUvkUrykS7RWvnC6zTFybdoDyx5ZgAhw9YAyKmaYRRs=;
	b=bxZmRZXwsrF9JZSmEMUbNlyXSNrB70W8XkVpLColKtcq9hHSr2cpF1VuizBJTrQjOHGTPp
	50h6FF1EXEF+eXjyWgd5Puy1z1zxloaeGYSjVwpWJC1CoDsl/lql4JwU9QHX7USqQTUqaC
	7crSUShmV7+E1JQYTa+zk7yYJOCmiglDJAlD36jXBhd+jQ4JMG8d43l6Lj+A05AX9d5DQM
	4PSK9lCmxrbC2JbKRpPNyoMY7r01WigLXBcEuNqUS6mJvA53Cd6uO2RyqklPXe7AJT836J
	5TTz+tVzAJEts69pT9QVULItBFB/8jQXc1AAsTxWM22NGIbYBpVbbaGA5jRrKw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1776334353;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kUvkUrykS7RWvnC6zTFybdoDyx5ZgAhw9YAyKmaYRRs=;
	b=C8NoVq8+6hw8nf8rX/aBvgyHBwt/fq54PZnke05H+Vj7kJW3U1LwvkSeJSpGP5EMp+VGz2
	qVJerwnI96oReCDw==
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
 <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org, Ilpo =?utf-8?Q?J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>, Ingo Molnar <mingo@kernel.org>, Thomas
 Gleixner <tglx@kernel.org>, Osama Abdelkader <osama.abdelkader@gmail.com>,
 Andy Shevchenko <andy.shevchenko@gmail.com>, Jiayuan Chen
 <jiayuan.chen@shopee.com>, Gerhard Engleder <eg@keba.com>, "Dr. David Alan
 Gilbert" <linux@treblig.org>, Joseph Tilahun <jtilahun@astranis.com>,
 linux-serial@vger.kernel.org
Subject: Re: [PATCH tty v2 2/2] serial: 8250: Add support for console
 hardware flow control
In-Reply-To: <20260410144949.16581-3-john.ogness@linutronix.de>
References: <20260410144949.16581-1-john.ogness@linutronix.de>
 <20260410144949.16581-3-john.ogness@linutronix.de>
Date: Thu, 16 Apr 2026 12:18:32 +0206
Message-ID: <87jyu76wof.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi,

Responding to Sashiko:

https://sashiko.dev/#/patchset/20260410144949.16581-1-john.ogness%40linutronix.de


On 2026-04-10, Sashiko wrote:
>> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
>> index a739350e634f9..6c8830943b0c0 100644
>> --- a/drivers/tty/serial/8250/8250_port.c
>> +++ b/drivers/tty/serial/8250/8250_port.c
>> @@ -3425,6 +3431,10 @@ int serial8250_console_setup(struct uart_port *port, char *options, bool probe)
>>  	if (ret)
>>  		return ret;
>>  
>> +	/* Allow user-specified hardware flow control. */
>> +	if (flow == 'r')
>> +		port->flags |= UPF_CONS_FLOW;
>> +
>
> Could this lead to a data race if port->flags is updated without
> holding the port mutex? include/linux/serial_core.h specifies that
> flags must be updated while holding the port mutex.

Yes. However, taking that lock makes no sense in the general context
(the lock probably does not even exist yet). The problem stems from the
fact that this console-only policy flag is being stored in a variable
used for tty properties. It does not belong there. For v3 I will move
this console-only policy flag into its own boolean.

> Also, if the console is dynamically reconfigured at runtime to disable flow
> control (e.g., flow == 'n'), should this code clear UPF_CONS_FLOW so the
> port does not erroneously retain its previous state?

Ack.

> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> index 89cebdd278410..a9ea10df4fb8b 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -2235,6 +2235,18 @@ uart_set_options(struct uart_port *port, struct console *co,
>  	port->mctrl |= TIOCM_DTR;
>  
>  	port->ops->set_termios(port, &termios, &dummy);
> +
> +	/*
> +	 * If console hardware flow control was specified and is supported,
> +	 * the related policy UPSTAT_CTS_ENABLE must be set to allow console
> +	 * drivers to identify if CTS should be used for polling.
> +	 */
> +	if (flow == 'r' && (termios.c_cflag & CRTSCTS)) {
> +		/* Synchronize @status RMW update against the console. */
> +		guard(uart_port_lock_irq)(port);
> +		port->status |= UPSTAT_CTS_ENABLE;
> +	}
> +

> Will this unconditionally enable interrupts during early boot and
> cause a crash?
>
> uart_set_options() is called by serial8250_console_setup() during
> early boot console registration, which occurs when local interrupts
> are disabled.  When the guard goes out of scope, spin_unlock_irq()
> will unconditionally enable interrupts before the system is fully
> initialized.  Is it possible to use the IRQ-saving variant here, such
> as scoped_guard(uart_port_lock_irqsave, port), to safely restore the
> previous interrupt state?

Ack. v3 will switch to irqsave.

> Additionally, if the console is dynamically reconfigured at runtime to
> disable flow control, should UPSTAT_CTS_ENABLE be cleared in an else
> branch to prevent the console from getting stuck polling CTS?

I do not want to restrict drivers from setting the UPSTAT_CTS_ENABLE
policy bit when console flow control is disabled. For the case that
console flow control is requested, UPSTAT_CTS_ENABLE _must_ be set in
order for the CTS polling to function.

John Ogness
