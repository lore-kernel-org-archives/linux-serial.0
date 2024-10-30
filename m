Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2053398E;
	Wed, 30 Oct 2024 06:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730268363; cv=none; b=RdlobnJ6seCUUPMEsQVQ5D4cCrJFRK5tecHXY1km8c+qQbrWPJZd1/TLyC7Lj+obHSCkjoyipZFMgSU249uuhT6CL0DShPhQVCDHi/C0bBKt12JqzRf0oZamJ2Ox6zppvIHpDl8VCE6wJYuBEA8CYfNC6Gf4ANjuSTtrd6ECykY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730268363; c=relaxed/simple;
	bh=0rd+rGQmI4YEvdffyJPpjxLIs/ZAPUeX/9lNkFELPPM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZRODSJjeY6k0iAYt41df0MJR3GwtEv8y1QZwjwb9OmSrML1u8pTujWiw+A/Vn94Mk+L76dh/k9MtJzHWvzapKKv3vSS7i/2Je63kinR6dmN35xup8P0YDuzT7mI/n7prWtrGBhVSvT1TjWldVnY1D33zScmSSO3vM67X2URWGY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bO9/H4td; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bO9/H4td"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7535AC4CEE4;
	Wed, 30 Oct 2024 06:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730268363;
	bh=0rd+rGQmI4YEvdffyJPpjxLIs/ZAPUeX/9lNkFELPPM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=bO9/H4tdpBg8nxHwsrHKPQS3Y+khT2DDEZ3GvkZy0+VvRQ+XBqDrwO27YaM+eXCWz
	 DBhD7cQdN2upZ2fwbVY6N//mLJaBnmIQE7cuDayhU+ipoU0CaSkQp1nNanZ9v6ce6o
	 0leqYP0v06lNySGkGcI4kDQOIaiRXAw1DR6O1Q5+s3gXX5HFd0PbvGqopnsirBsst4
	 Jpis2QTianN/WJ5gR3VN5h+c8Pf3akOxRXMpn55fmv74x+6DQjhtMBsQfjiFxSzGrh
	 wIYBvLm6BQr4oIPtz5O6sIFaG+dgV0xk1qaeZ9MbxLL6Ye85FH8RB1TnxWrya/lGl8
	 IgArXtwDP+pYQ==
Message-ID: <837a7ecd-be29-4865-9543-cb6f7e7e46e7@kernel.org>
Date: Wed, 30 Oct 2024 07:05:58 +0100
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH tty-next v3 1/6] serial: 8250: Adjust the timeout for FIFO
 mode
To: John Ogness <john.ogness@linutronix.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Petr Mladek <pmladek@suse.com>,
 Sergey Senozhatsky <senozhatsky@chromium.org>,
 Steven Rostedt <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>,
 Esben Haabendal <esben@geanix.com>, linux-serial@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Rengarajan S <rengarajan.s@microchip.com>,
 Jeff Johnson <quic_jjohnson@quicinc.com>,
 Serge Semin <fancer.lancer@gmail.com>,
 Lino Sanfilippo <l.sanfilippo@kunbus.com>,
 Wander Lairson Costa <wander@redhat.com>
References: <20241025105728.602310-1-john.ogness@linutronix.de>
 <20241025105728.602310-2-john.ogness@linutronix.de>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <20241025105728.602310-2-john.ogness@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25. 10. 24, 12:57, John Ogness wrote:
> After a console has fed a line into TX, it uses wait_for_xmitr()
> to wait until the data has been sent out before returning to the
> printk code. However, wait_for_xmitr() will timeout after 10ms,
> regardless if the data has been transmitted or not.
> 
> For single bytes, this timeout is sufficient even at very slow
> baud rates, such as 1200bps. However, when FIFO mode is used,
> there may be 64 bytes pushed into the FIFO at once. At a baud
> rate of 115200bps, the 10ms timeout is still sufficient.
> However, when using lower baud rates (such as 57600bps), the
> timeout is _not_ sufficient. This causes longer lines to be cut
> off, resulting in lost and horribly misformatted output on the
> console.
> 
> When using FIFO mode, take the number of bytes into account to
> determine an appropriate max timeout. Increasing the timeout
> does not affect performance since ideally the timeout never
> occurs.
> 
> Fixes: 8f3631f0f6eb ("serial/8250: Use fifo in 8250 console driver")
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> ---
>   drivers/tty/serial/8250/8250_port.c | 24 ++++++++++++++++++++----
>   1 file changed, 20 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
> index 3509af7dc52b..adc48eeeac2b 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -2059,11 +2059,12 @@ static void serial8250_break_ctl(struct uart_port *port, int break_state)
>   	serial8250_rpm_put(up);
>   }
>   
> -static void wait_for_lsr(struct uart_8250_port *up, int bits)
> +/* Returns true if @bits were set, false on timeout. */
> +static bool wait_for_lsr(struct uart_8250_port *up, int bits)
>   {
>   	unsigned int status, tmout = 10000;
>   
> -	/* Wait up to 10ms for the character(s) to be sent. */
> +	/* Wait up to 10ms for the character to be sent. */
>   	for (;;) {
>   		status = serial_lsr_in(up);
>   
> @@ -2074,10 +2075,13 @@ static void wait_for_lsr(struct uart_8250_port *up, int bits)
>   		udelay(1);
>   		touch_nmi_watchdog();
>   	}
> +
> +	return (tmout != 0);
>   }
>   
>   /*
>    *	Wait for transmitter & holding register to empty
> + *	with timeout
>    */
>   static void wait_for_xmitr(struct uart_8250_port *up, int bits)
>   {
> @@ -3306,13 +3310,18 @@ static void serial8250_console_restore(struct uart_8250_port *up)
>   static void serial8250_console_fifo_write(struct uart_8250_port *up,
>   					  const char *s, unsigned int count)
>   {
> -	int i;
>   	const char *end = s + count;
>   	unsigned int fifosize = up->tx_loadsz;
> +	unsigned int tx_count = 0;
>   	bool cr_sent = false;
> +	unsigned int i;
>   
>   	while (s != end) {
> -		wait_for_lsr(up, UART_LSR_THRE);
> +		/* Allow timeout for each byte of a possibly full FIFO. */
> +		for (i = 0; i < fifosize; i++) {
> +			if (wait_for_lsr(up, UART_LSR_THRE))
> +				break;
> +		}

THRE only signals there is a space for one character. Multiplying it 
with fifosize does not make much sense to me. You perhaps want only to 
increase the timeout. Or somehow incorporate port->frame_time into the 
accounting (I am not sure it is available at this point already).

>   		for (i = 0; i < fifosize && s != end; ++i) {
>   			if (*s == '\n' && !cr_sent) {
> @@ -3323,6 +3332,13 @@ static void serial8250_console_fifo_write(struct uart_8250_port *up,
>   				cr_sent = false;
>   			}
>   		}
> +		tx_count = i;
> +	}
> +
> +	/* Allow timeout for each byte written. */
> +	for (i = 0; i < tx_count; i++) {
> +		if (wait_for_lsr(up, UART_LSR_THRE))

This ensures you sent one character from the FIFO. The FIFO still can 
contain plenty of them. Did you want UART_LSR_TEMT?

But what's the purpose of spinning _here_? The kernel can run and FIFO 
too. Without the kernel waiting for the FIFO.

thanks,
-- 
js
suse labs
