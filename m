Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5C563CB;
	Wed, 30 Oct 2024 06:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730270010; cv=none; b=Dg0SzucxGmEID8cP3Ddwk2Jpudn4xix8Ot6f8/0h2lNMDlp+IoEWjHJlsxojPsRF2s5tCAsOCPaXA9UIrscNGSXfHUm0z/KlPGyRVF9yFd8P2TE368Ah+bxhLmyvIGK2h0QRNLfkcTzosCAxVzKUVFgJwl3x1KggP8+SnoQ4U1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730270010; c=relaxed/simple;
	bh=SC0Xu24Wqh43ElDcUACTlpmVLeS1VgEZ9q2pTiK0tTQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lmwy4N3F1RGJc6upUleMq2q93ykz/zDukHrYtDsH+OHnSbTxq8kfsrVvO+MCVZySpIB44fiGHY58owUb3/q9tsrcDkbrTPd/KhOkH4DB7qz80g+QPECbnIxF3sMf60n3N4f6QuSdtveJCpET8r8FyUrdikTqoB42UbL6Wdp9HCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kf3J6PxE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kf3J6PxE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13655C4CEE6;
	Wed, 30 Oct 2024 06:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730270009;
	bh=SC0Xu24Wqh43ElDcUACTlpmVLeS1VgEZ9q2pTiK0tTQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kf3J6PxEKPDD4Fz76JOnhxqOI1OG68PL1+OtmdWR48jgGSd4xHgBHoljIc2JAsvir
	 8ALulSMNeCtgUxLpj3RFMuxF5YjUa4CsJdCCmVsFZt9fgZcbRhs8Ds9j54DvyeP+Jp
	 FtIowtsja5piCmhoXVWCOvFYvTRrksj6Wu9FkdpoXR81Uys+1rrtQYTFhb7VEcZdHL
	 5/8mFOvhAg94PcAOZ3mRzc2CGBm6mrUnhowYJiYSmmMEBDCoIqGA190Ur7tlze0iLA
	 M+PDLRoO/3AumSvVPIr3eypPvsG3ggcpyPHnZINVicOJkee4aV3voJtSPYzhZqnKHD
	 uFO6sA8QE4ycA==
Message-ID: <419edf13-3f5e-4d30-90d8-88118f77f704@kernel.org>
Date: Wed, 30 Oct 2024 07:33:24 +0100
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH tty-next v3 5/6] serial: 8250: Switch to nbcon console
To: John Ogness <john.ogness@linutronix.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Petr Mladek <pmladek@suse.com>,
 Sergey Senozhatsky <senozhatsky@chromium.org>,
 Steven Rostedt <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>,
 Esben Haabendal <esben@geanix.com>, linux-serial@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>, Arnd Bergmann <arnd@arndb.de>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Tony Lindgren <tony@atomide.com>, Rengarajan S <rengarajan.s@microchip.com>,
 Peter Collingbourne <pcc@google.com>, Serge Semin <fancer.lancer@gmail.com>,
 Lino Sanfilippo <l.sanfilippo@kunbus.com>
References: <20241025105728.602310-1-john.ogness@linutronix.de>
 <20241025105728.602310-6-john.ogness@linutronix.de>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <20241025105728.602310-6-john.ogness@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25. 10. 24, 12:57, John Ogness wrote:
> Implement the necessary callbacks to switch the 8250 console driver
> to perform as an nbcon console.
> 
> Add implementations for the nbcon console callbacks (write_atomic,
> write_thread, device_lock, device_unlock) and add CON_NBCON to the
> initial flags.
> 
> All register access in the callbacks are within unsafe sections.
> The write callbacks allow safe handover/takeover per byte and add
> a preceding newline if they take over mid-line.
> 
> For the write_atomic() case, a new irq_work is used to defer modem
> control since it may be a context that does not allow waking up
> tasks.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> ---
>   drivers/tty/serial/8250/8250_core.c |  35 +++++-
>   drivers/tty/serial/8250/8250_port.c | 159 ++++++++++++++++++++++------
>   include/linux/serial_8250.h         |   7 +-
>   3 files changed, 164 insertions(+), 37 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
> index 5f9f06911795..7184100129bd 100644
> --- a/drivers/tty/serial/8250/8250_core.c
> +++ b/drivers/tty/serial/8250/8250_core.c
> @@ -388,12 +388,34 @@ void __init serial8250_register_ports(struct uart_driver *drv, struct device *de
>   
>   #ifdef CONFIG_SERIAL_8250_CONSOLE
>   
> -static void univ8250_console_write(struct console *co, const char *s,
> -				   unsigned int count)
> +static void univ8250_console_write_atomic(struct console *co,

Once 'co'.

> +					  struct nbcon_write_context *wctxt)
>   {
>   	struct uart_8250_port *up = &serial8250_ports[co->index];
>   
> -	serial8250_console_write(up, s, count);
> +	serial8250_console_write(up, wctxt, true);
> +}
> +
> +static void univ8250_console_write_thread(struct console *co,

Second time co.

> +					  struct nbcon_write_context *wctxt)
> +{
> +	struct uart_8250_port *up = &serial8250_ports[co->index];
> +
> +	serial8250_console_write(up, wctxt, false);
> +}
> +
> +static void univ8250_console_device_lock(struct console *con, unsigned long *flags)

And suddenly, it is 'con'.

> +{
> +	struct uart_port *up = &serial8250_ports[con->index].port;
> +
> +	__uart_port_lock_irqsave(up, flags);
> +}
> +
> +static void univ8250_console_device_unlock(struct console *con, unsigned long flags)
> +{
> +	struct uart_port *up = &serial8250_ports[con->index].port;
> +
> +	__uart_port_unlock_irqrestore(up, flags);
>   }
>   

...
>   static void serial8250_console_putchar(struct uart_port *port, unsigned char ch)
>   {
> +	struct uart_8250_port *up = up_to_u8250p(port);
> +
>   	serial_port_out(port, UART_TX, ch);
> +
> +	if (ch == '\n')
> +		up->console_line_ended = true;
> +	else
> +		up->console_line_ended = false;

So simply:
    up->console_line_ended = ch == '\n';
?

...
> -void serial8250_console_write(struct uart_8250_port *up, const char *s,
> -			      unsigned int count)
> +void serial8250_console_write(struct uart_8250_port *up,
> +			      struct nbcon_write_context *wctxt,
> +			      bool is_atomic)
>   {
>   	struct uart_8250_em485 *em485 = up->em485;
>   	struct uart_port *port = &up->port;
> -	unsigned long flags;
> -	unsigned int ier, use_fifo;
> -	int locked = 1;
> -
> -	touch_nmi_watchdog();
> +	unsigned int ier;
> +	bool use_fifo;
>   
> -	if (oops_in_progress)
> -		locked = uart_port_trylock_irqsave(port, &flags);
> -	else
> -		uart_port_lock_irqsave(port, &flags);
> +	if (!nbcon_enter_unsafe(wctxt))
> +		return;
>   
>   	/*
> -	 *	First save the IER then disable the interrupts
> +	 * First save IER then disable the interrupts. The special variant

When you are at it:
"First, save the IER, then"

(BTW why did you remove the "the"?)

> +	 * to clear IER is used because console printing may occur without
> +	 * holding the port lock.
>   	 */
>   	ier = serial_port_in(port, UART_IER);
> -	serial8250_clear_IER(up);
> +	__serial8250_clear_IER(up);
>   
>   	/* check scratch reg to see if port powered off during system sleep */
>   	if (up->canary && (up->canary != serial_port_in(port, UART_SCR))) {

> @@ -3497,6 +3593,9 @@ int serial8250_console_setup(struct uart_port *port, char *options, bool probe)
>   	if (!port->iobase && !port->membase)
>   		return -ENODEV;
>   
> +	up->console_line_ended = true;
> +	up->modem_status_work = IRQ_WORK_INIT(modem_status_handler);

Looks weird ^^^.

Do:
   init_irq_work(&up->modem_status_work, modem_status_handler)

thanks,
-- 
js
suse labs
