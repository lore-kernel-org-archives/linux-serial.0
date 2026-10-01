Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313CA3E44E7;
	Thu,  1 Oct 2026 19:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790881891; cv=none; b=X9r2nQx9UwLg/AlmAyIdnRb0P7AiVmOrGRl06+I+IZ12L4kLkrwU8AYNzOOMGBuEnduMpB1F8//qXb80MrwUpxhRevDDkEjZaoVg3ZaU4DrUebunS3FR+YRGfHqb7jzcdNPMpESGbnne5hplAp/1KJTnlD4B5bcoOOiTXu1HK3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790881891; c=relaxed/simple;
	bh=1c+pSTChcD06amwWz2YoAfp8ncaUzfKS1FlNFlPoQ40=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=AqrxQgc3RAoF1/j4b5KE0c1cZKec/MY7NCzEZd2W0t+y1QBpuBPVoWjuw97+P5PNwy2XOJliiDfwjVi9n2pNcQi/UzRHQ18jXtcB1ADkai79UhQJFZEMcUF3Cu6lcG7N8FZHAsrhjqJxHRqKAFIazMqmSnplZ2898YvM6G0wGCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=0EyvBnTn; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="0EyvBnTn"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=default; h=Content-Transfer-Encoding:Mime-Version:Message-Id:Subject:Cc:
	To:From:Date:subject:date:message-id:reply-to;
	bh=1AyaGTZG5xGMgtec96vZUWOGjbrQZ+VQHy3TOYwLXcg=; b=0EyvBnTnvr62jGHlF9GzphthMp
	PFla2b66ta/4kGKptWhxMNjcRfEXdtJn7JF7JOF6336OAMPCFNXJrgr0i70sO9lWJ+CfcFOveUcb9
	8lZD5fm0/bHtpYq6cqULjnscq+PUc47FXObV+svEa3R4iXHD8EgeP9eQABwxSlQfC7oo=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168] helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.98.2)
	(envelope-from <hugo@hugovil.com>)
	id 1xCMBi-000000007G9-1f1A;
	Thu, 01 Oct 2026 15:11:26 -0400
Date: Thu, 1 Oct 2026 15:11:25 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: Tapio Reijonen <tapio.reijonen@vaisala.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
 <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, Hugo Villeneuve <hvilleneuve@dimonoff.com>,
 Tapio Reijonen <tapio.reijonen@kolumbus.fi>
Subject: Re: [PATCH v5 3/8] serial: max310x: convert RS485 delays from
 milliseconds to bit-times
Message-Id: <20261001151125.1cf9daecf48174999aa676f0@hugovil.com>
In-Reply-To: <20260929-max310x-rs485-sw-delay-v5-3-ae46afa583f2@vaisala.com>
References: <20260929-max310x-rs485-sw-delay-v5-0-ae46afa583f2@vaisala.com>
	<20260929-max310x-rs485-sw-delay-v5-3-ae46afa583f2@vaisala.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam_score: -2.0
X-Spam_bar: --

Hi Tapio,

On Tue, 29 Sep 2026 09:37:57 +0000
Tapio Reijonen <tapio.reijonen@vaisala.com> wrote:

> The HDPIXDELAY register counts the RTS setup and hold delays in
> bit-times, four bits per direction, but the driver has been writing the
> struct serial_rs485 delay_rts_before_send/delay_rts_after_send values
> into it unconverted - and the uapi expresses those in milliseconds. A
> requested 9 ms setup delay is programmed as 9 bit-times, which at 9600
> baud is 0.94 ms, roughly a tenth of what userspace asked for; the error
> grows with the baud rate.
> 
> Cache the baud rate in set_termios() and convert the delays to
> bit-times at the current rate, rounding up so the delay on the wire is
> never shorter than requested, and capping at the 15 bit-times the
> 4-bit field can hold. Centralize the HDPIXDELAY and MODE1.TRNSCVCTRL
> programming in max310x_set_rts_ctl_params(), called from set_termios()

Could this centralization be done in a separate patch, without
any functional changes intented, in order to facilitate the
review of this patch?


> (the conversion depends on the baud rate), the rs485-config worker and
> startup(), which each had their own copy.
> 
> The rs485-config worker's break guard moves into the helper with the
> MODE1 write it protects, and break-off now reapplies the current
> configuration through the helper instead of hand-restoring MODE1, so a
> reconfigure that arrived during the break takes effect when the break
> ends instead of being dropped.
> 
> The delays a 4-bit bit-time field can represent still fall well short
> of the milliseconds the uapi can express; requests beyond 15 bit-times
> are capped, and the -ERANGE rejection of values above 15 ms remains in
> place for now.
> 
> Fixes: 55367c620aed ("serial: max310x: Add support for RS-485 mode")
> Signed-off-by: Tapio Reijonen <tapio.reijonen@vaisala.com>
> ---
>  drivers/tty/serial/max310x.c | 120 +++++++++++++++++++++++++++++--------------
>  1 file changed, 82 insertions(+), 38 deletions(-)
> 
> diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
> index 693decd04de104051b07357973364bd587ab3d91..f8dad37d017afe5c0b1d36d6239ba05fc5e7aff0 100644
> --- a/drivers/tty/serial/max310x.c
> +++ b/drivers/tty/serial/max310x.c
> @@ -165,6 +165,10 @@
>  #define MAX310X_IRDA_IRDAEN_BIT		(1 << 0) /* IRDA mode enable */
>  #define MAX310X_IRDA_SIR_BIT		(1 << 1) /* SIR mode enable */
>  
> +/* HDPIXDELAY accessor macros */
> +#define MAX310X_HDPIXDELAY_SETUP(val)	(((val) & 0x0f) << 4)
> +#define MAX310X_HDPIXDELAY_HOLD(val)	((val) & 0x0f)
> +
>  /* Flow control trigger level register masks */
>  #define MAX310X_FLOWLVL_HALT_MASK	GENMASK(3, 0) /* Flow control halt level */
>  #define MAX310X_FLOWLVL_RES_MASK	GENMASK(7, 4) /* Flow control resume level */
> @@ -298,6 +302,7 @@ struct max310x_one {
>  	struct work_struct	md_work;
>  	struct work_struct	rs_work;
>  	struct regmap		*regmap;
> +	unsigned int		baud;
>  	bool			tx_break;	/* break_ctl() owns the transceiver */
>  
>  	u8 rx_buf[MAX310X_FIFO_SIZE];
> @@ -934,6 +939,48 @@ static void max310x_set_mctrl(struct uart_port *port, unsigned int mctrl)
>  	schedule_work(&one->md_work);
>  }
>  
> +/*
> + * Program the chip's RS485 RTS timing. The HDPIXDELAY setup and hold fields
> + * count bit-times, four bits per direction, while the uapi expresses the
> + * delays in milliseconds: convert at the current baud rate, rounding up, and
> + * cap at the field maximum.
> + */
> +static void max310x_set_rts_ctl_params(struct max310x_one *one)
> +{
> +	const unsigned int max_bit_dly = 15;
> +	struct uart_port *port = &one->port;
> +	unsigned int setup = 0, hold = 0;
> +	u8 mode1 = 0;
> +
> +	if (port->rs485.flags & SER_RS485_ENABLED) {
> +		/* Convert milliseconds to bit-times, rounding up. */
> +		setup = DIV_ROUND_UP(one->baud * port->rs485.delay_rts_before_send,
> +				     MSEC_PER_SEC);
> +		hold  = DIV_ROUND_UP(one->baud * port->rs485.delay_rts_after_send,
> +				     MSEC_PER_SEC);
> +		setup = min(setup, max_bit_dly);
> +		hold  = min(hold,  max_bit_dly);
> +
> +		mode1 = MAX310X_MODE1_TRNSCVCTRL_BIT;
> +	}
> +
> +	max310x_port_write(port, MAX310X_HDPIXDELAY_REG,
> +			   MAX310X_HDPIXDELAY_SETUP(setup) |
> +			   MAX310X_HDPIXDELAY_HOLD(hold));
> +
> +	/*
> +	 * A break owns the transceiver: break_ctl() disabled auto-RTS and
> +	 * drives RTS manually, and restores it from the current
> +	 * configuration when the break ends. Touching MODE1 here would
> +	 * release the transceiver mid-break.
> +	 */
> +	if (one->tx_break)
> +		return;
> +
> +	max310x_port_update(port, MAX310X_MODE1_REG,
> +			    MAX310X_MODE1_TRNSCVCTRL_BIT, mode1);
> +}
> +
>  static void max310x_break_ctl(struct uart_port *port, int break_state)
>  {
>  	struct max310x_one *one = to_max310x_port(port);
> @@ -953,10 +1000,20 @@ static void max310x_break_ctl(struct uart_port *port, int break_state)
>  	 * break duration and drive RTS manually so the break reaches the wire;
>  	 * restore auto-RTS when the break ends.
>  	 */
> -	max310x_port_update(port, MAX310X_MODE1_REG,
> -			    MAX310X_MODE1_TRNSCVCTRL_BIT,
> -			    break_state ? 0 : MAX310X_MODE1_TRNSCVCTRL_BIT);
> -	max310x_rts_ctl(port, break_state);
> +	if (break_state) {
> +		max310x_port_update(port, MAX310X_MODE1_REG,
> +				    MAX310X_MODE1_TRNSCVCTRL_BIT, 0);
> +		max310x_rts_ctl(port, 1);
> +	} else {
> +		/*
> +		 * Reapply the current configuration: a reconfigure that
> +		 * arrived during the break was deferred by the tx_break
> +		 * guard. Then release the manual RTS - auto-RTS owns the
> +		 * pin again.
> +		 */
> +		max310x_set_rts_ctl_params(one);
> +		max310x_rts_ctl(port, 0);
> +	}
>  }
>  
>  static void max310x_set_termios(struct uart_port *port,
> @@ -1073,41 +1130,35 @@ static void max310x_set_termios(struct uart_port *port,
>  
>  	/* Update timeout according to new baud rate */
>  	uart_update_timeout(port, termios->c_cflag, baud);
> +
> +	/*
> +	 * Cache the new baud rate and reprogram the RS485 RTS delays, whose
> +	 * millisecond-to-bit-time conversion depends on it.
> +	 */
> +	to_max310x_port(port)->baud = baud;
> +	max310x_set_rts_ctl_params(to_max310x_port(port));
>  }
>  
>  static void max310x_rs_proc(struct work_struct *ws)
>  {
>  	struct max310x_one *one = container_of(ws, struct max310x_one, rs_work);
> -	unsigned int delay, mode1 = 0, mode2 = 0;
> +	unsigned int mode2 = 0;
>  
>  	/*
>  	 * Serialize against break_ctl() and set_termios(), which run under
> -	 * port->mutex: the tx_break test below and the MODE1 write must not
> +	 * port->mutex: the tx_break-guarded register writes must not
>  	 * straddle a break starting or ending.
>  	 */
>  	guard(mutex)(&one->port.state->port.mutex);
>  
> -	delay = (one->port.rs485.delay_rts_before_send << 4) |
> -		one->port.rs485.delay_rts_after_send;
> -	max310x_port_write(&one->port, MAX310X_HDPIXDELAY_REG, delay);
> +	max310x_set_rts_ctl_params(one);
>  
> -	if (one->port.rs485.flags & SER_RS485_ENABLED) {
> -		mode1 = MAX310X_MODE1_TRNSCVCTRL_BIT;
> +	if (one->port.rs485.flags & SER_RS485_ENABLED &&
> +	    !(one->port.rs485.flags & SER_RS485_RX_DURING_TX))
> +		mode2 = MAX310X_MODE2_ECHOSUPR_BIT;
>  
> -		if (!(one->port.rs485.flags & SER_RS485_RX_DURING_TX))
> -			mode2 = MAX310X_MODE2_ECHOSUPR_BIT;
> -	}
> -
> -	/*
> -	 * A break owns the transceiver: break_ctl() disabled auto-RTS and
> -	 * drives RTS manually, and restores it when the break ends. Leave
> -	 * MODE1 alone meanwhile or the break goes undriven mid-way.
> -	 */
> -	if (!one->tx_break)
> -		max310x_port_update(&one->port, MAX310X_MODE1_REG,
> -				    MAX310X_MODE1_TRNSCVCTRL_BIT, mode1);
>  	max310x_port_update(&one->port, MAX310X_MODE2_REG,
> -			MAX310X_MODE2_ECHOSUPR_BIT, mode2);
> +			    MAX310X_MODE2_ECHOSUPR_BIT, mode2);
>  }
>  
>  static int max310x_rs485_config(struct uart_port *port, struct ktermios *termios,
> @@ -1151,21 +1202,14 @@ static int max310x_startup(struct uart_port *port)
>  	max310x_port_update(port, MAX310X_MODE2_REG,
>  			    MAX310X_MODE2_FIFORST_BIT, 0);
>  
> -	/* Configure mode1/mode2 to have rs485/rs232 enabled at startup */
> -	val = (clamp(port->rs485.delay_rts_before_send, 0U, 15U) << 4) |
> -		clamp(port->rs485.delay_rts_after_send, 0U, 15U);
> -	max310x_port_write(port, MAX310X_HDPIXDELAY_REG, val);
> +	/* Configure the RS485 RTS timing and the RS485/RS232 mode bits. */
> +	max310x_set_rts_ctl_params(one);
>  
> -	if (port->rs485.flags & SER_RS485_ENABLED) {
> -		max310x_port_update(port, MAX310X_MODE1_REG,
> -				    MAX310X_MODE1_TRNSCVCTRL_BIT,
> -				    MAX310X_MODE1_TRNSCVCTRL_BIT);
> -
> -		if (!(port->rs485.flags & SER_RS485_RX_DURING_TX))
> -			max310x_port_update(port, MAX310X_MODE2_REG,
> -					    MAX310X_MODE2_ECHOSUPR_BIT,
> -					    MAX310X_MODE2_ECHOSUPR_BIT);
> -	}
> +	if (port->rs485.flags & SER_RS485_ENABLED &&
> +	    !(port->rs485.flags & SER_RS485_RX_DURING_TX))
> +		max310x_port_update(port, MAX310X_MODE2_REG,
> +				    MAX310X_MODE2_ECHOSUPR_BIT,
> +				    MAX310X_MODE2_ECHOSUPR_BIT);
>  
>  	/*
>  	 * Configure flow control levels:
> 
> -- 
> 2.47.3
> 
> 
> 


-- 
Hugo Villeneuve
