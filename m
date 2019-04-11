From: Andreas Schwab <schwab@suse.de>
Subject: Re: [PATCH v4 2/2] tty: serial: add driver for the SiFive UART
Date: Thu, 11 Apr 2019 18:16:09 +0200
Message-ID: <mvmtvf4ecvq.fsf@suse.de>
References: <20190411090027.8670-1-paul.walmsley@sifive.com>
        <20190411090027.8670-3-paul.walmsley@sifive.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190411090027.8670-3-paul.walmsley@sifive.com> (Paul Walmsley's
        message of "Thu, 11 Apr 2019 02:00:30 -0700")
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Walmsley <paul.walmsley@sifive.com>
Cc: linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, linux-serial@vger.kernel.org, gregkh@linuxfoundation.org, Paul Walmsley <paul@pwsan.com>, Jiri Slaby <jslaby@suse.com>, Palmer Dabbelt <palmer@sifive.com>, Wesley Terpstra <wesley@sifive.com>, Julia Lawall <julia.lawall@lip6.fr>
List-Id: linux-serial@vger.kernel.org

On Apr 11 2019, Paul Walmsley <paul.walmsley@sifive.com> wrote:

> +static void sifive_serial_set_termios(struct uart_port *port,
> +				      struct ktermios *termios,
> +				      struct ktermios *old)
> +{
> +	struct sifive_serial_port *ssp = port_to_sifive_serial_port(port);
> +	unsigned long flags;
> +	u32 v, old_v;
> +	int rate;
> +	char nstop;
> +
> +	if ((termios->c_cflag & CSIZE) != CS8) {
> +		dev_err(ssp->port.dev, "only 8-bit words supported\n");
> +		return;
> +	}
> +
> +	/* Set number of stop bits */
> +	nstop = (termios->c_cflag & CSTOPB) ? 2 : 1;
> +	__ssp_set_stop_bits(ssp, nstop);
> +
> +	/* Set line rate */
> +	rate = uart_get_baud_rate(port, termios, old, 0, ssp->clkin_rate / 16);
> +	__ssp_update_baud_rate(ssp, rate);
> +
> +	spin_lock_irqsave(&ssp->port.lock, flags);
> +
> +	/*
> +	 * Update the per-port timeout.
> +	 */
> +	uart_update_timeout(port, termios->c_cflag, rate);
> +
> +	ssp->port.read_status_mask = 0;
> +	if (termios->c_iflag & INPCK) {
> +		dev_err(ssp->port.dev, "INPCK flag not supported\n");
> +		goto ssst_out;
> +	}
> +	if (termios->c_iflag & (BRKINT | PARMRK)) {
> +		dev_err(ssp->port.dev, "BRKINT/PARMRK flag not supported\n");
> +		goto ssst_out;
> +	}

I don't think it is a good idea to print something while the port is
locked.

And I think set_termios is supposed to apply all applicable settings,
even if some of them are not supported.

Andreas.

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
