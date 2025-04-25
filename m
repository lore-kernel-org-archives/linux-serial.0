Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 831B41B6D11;
	Fri, 25 Apr 2025 08:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745569348; cv=none; b=fSTmmxD1lt8LnfbyKknOkHyBjGF7OwplzFsHjc2BToPVvDRHjXE1eRD5ROcQza+DClGcPXzrEVjxka15oO9Vqp6ndhnwCb6YDt7/A/O/ERp0nMFLf29+ARmOMJswWsBMXZeMdZVhXtOnWCIR9xQai7tsMWS8jMIHWem0Q2nHmAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745569348; c=relaxed/simple;
	bh=A4pLvUmgwj2WzHJ03YdX6y0M7SDSimc7uWYShQFhbs8=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GEIZF0yA0SbqftdW29qHeYcKVKQbRi1ADp45pIcFAvQw5Qt05tn2unasN2d9xE7PzZ0qDnGAu+7xS2fXsKY9Mk+kE0mRemA6rqY+jsJhsIu/KGwXkEQa07BCNPC0pWv3SBTz4qioPlA6AfiBh35henOfDb8u+c7ZBUgo7nrL8VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=P3KGmbEV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0XkvZIKn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="P3KGmbEV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0XkvZIKn"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1745569344;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SVLvtgy3kbHbIlgt4muvQvDSY3VtgJ61rhMKGo3z+bk=;
	b=P3KGmbEVCsMFHByliTYfeF7pZ9UgaFbmvYf1DkdwJ/+BRX2yUgvCbJsXqJb+6UrvyVj9S0
	xYDU+t9oxWCr7y1H1q/tvYUvFB4OB1PxqOW0hO9WeAqV2X6qm3BK9TxSB5RgCiU2solK60
	3HL2ML5vGPDw4c8guPJ/i5lFMlErktEjPajZeHDZy2sibNhopHjXSAiUwhNSzEiVWvmIXm
	XMLnfGHo3U3XdE0u+PkqHoZFqXFlOfUPpeCaz66DchCVfGUXncNW0g65EdVoc8zwb1L2FS
	m6agj/766qVjF5rCJItP8uWKMzfsB04aJiB186j6Lf7CUj6IvQwt71kNJ6BmJQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1745569344;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SVLvtgy3kbHbIlgt4muvQvDSY3VtgJ61rhMKGo3z+bk=;
	b=0XkvZIKnykGZg/U4tmfHmIxeb1CdHUFOJHmU4ew7tb2VGVe+JLfMo4S0LU6BoPbBncuEDK
	jBG1RCN6kisusyAA==
To: Yunhui Cui <cuiyunhui@bytedance.com>, arnd@arndb.de,
 andriy.shevchenko@linux.intel.com, benjamin.larsson@genexis.eu,
 cuiyunhui@bytedance.com, gregkh@linuxfoundation.org,
 heikki.krogerus@linux.intel.com, ilpo.jarvinen@linux.intel.com,
 jirislaby@kernel.org, jkeeping@inmusicbrands.com,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 markus.mayer@linaro.org, matt.porter@linaro.org, namcao@linutronix.de,
 paulmck@kernel.org, pmladek@suse.com, schnelle@linux.ibm.com,
 sunilvl@ventanamicro.com, tim.kryger@linaro.org
Subject: Re: [PATCH v4 2/4] serial: 8250: introduce serial8250_discard_data()
In-Reply-To: <20250425062425.68761-2-cuiyunhui@bytedance.com>
References: <20250425062425.68761-1-cuiyunhui@bytedance.com>
 <20250425062425.68761-2-cuiyunhui@bytedance.com>
Date: Fri, 25 Apr 2025 10:28:23 +0206
Message-ID: <847c38irb4.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2025-04-25, Yunhui Cui <cuiyunhui@bytedance.com> wrote:
> To prevent triggering PSLVERR, it is necessary to check whether the
> UART_LSR_DR bit of UART_LSR is set before reading UART_RX.
> Ensure atomicity of UART_LSR and UART_RX, put serial8250_discard_data()
> under port->lock.
>
> Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> ---
>  drivers/tty/serial/8250/8250.h      | 15 +++++++++++
>  drivers/tty/serial/8250/8250_port.c | 42 ++++++++++++++---------------
>  2 files changed, 36 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
> index a913135d5217..802ac50357c0 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -2137,25 +2136,21 @@ static void wait_for_xmitr(struct uart_8250_port *up, int bits)
>  static int serial8250_get_poll_char(struct uart_port *port)
>  {
>  	struct uart_8250_port *up = up_to_u8250p(port);
> -	int status;
> +	int status = NO_POLL_CHAR;
>  	u16 lsr;
>  
>  	serial8250_rpm_get(up);
>  
> +	uart_port_lock_irqsave(port, &flags);
>  	lsr = serial_port_in(port, UART_LSR);

The ->poll_get_char() callback is used for kdb/kgdb.

Adding a spinlock here could lead to deadlock. However, I see that
serial8250_rpm_get() is already in there, which goes down a rabbit hole
of possible issues. So I guess we really don't care about possible
kdb/kgdb deadlocks for now.

I can look into cleaning this up with my next 8250 nbcon console
series. So for now, I am OK with you adding the spin_lock() in this
callback.

John Ogness
