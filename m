Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2093149502A;
	Thu,  1 Oct 2026 20:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790884831; cv=none; b=ucfCkWr+nWoB7Nbsj5rfoZq00c2Otja5MVw2cqpCtFauf76ceAYcf083r1mw9hF65gMpxerF0dZSQN49d1PGzX9Se6UVqFVZttHpUa5pnK6JkvZVqVeuohfhj+Z5T3ffGRILXDRaNvJaI6GZ3RAR4KUZvAYkz68WdKApI+LkLQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790884831; c=relaxed/simple;
	bh=lwkq99MWT5s48kWH9YMiB+4nleL/rEG/UUV3yABKlZM=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=CeApc7wbtSyoYuXTtRp2F5FauOxOt5oPt+z6U7zOv4CRxX9m/0/Po+HG5S6PpIXi+wf6+dloTdw1CCm2HHO/jCa7sd4PU1kDnlF/uF4FfEA/TD2y6dkIwb3EV3Z27awmxHN+m613ElznspZz/M809DTWiVxDYUYTfB/gJ89Jd10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=mxapvqNe; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="mxapvqNe"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=default; h=Content-Transfer-Encoding:Mime-Version:Message-Id:Subject:Cc:
	To:From:Date:subject:date:message-id:reply-to;
	bh=s+MgTE3OXBsTBgCf7SNKHJD9CWPoxhvXy8xPXrCZJbY=; b=mxapvqNeWcuukz7fIn0FX2TDlj
	TNSH8gt791Ypxz+8WwcdUx4PHMKuD83qGzClQUK2rDxy1PZbTCD007lrgnGLvCy3bS/hShDf78yiF
	tNBATzGzbGtUPgNLOrfxNlso+yeY2nyGdDnztFs7nH9JkPRTk57uzYgx5qG2pTJ/7go8=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168] helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.98.2)
	(envelope-from <hugo@hugovil.com>)
	id 1xCMx2-000000007Zf-1pO5;
	Thu, 01 Oct 2026 16:00:20 -0400
Date: Thu, 1 Oct 2026 16:00:20 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: Tapio Reijonen <tapio.reijonen@vaisala.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
 <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, Hugo Villeneuve <hvilleneuve@dimonoff.com>,
 Tapio Reijonen <tapio.reijonen@kolumbus.fi>
Subject: Re: [PATCH v5 4/8] serial: max310x: wait for TX to drain before
 powering down in shutdown
Message-Id: <20261001160020.5ba190a2b747f0c66f8b30d7@hugovil.com>
In-Reply-To: <20260929-max310x-rs485-sw-delay-v5-4-ae46afa583f2@vaisala.com>
References: <20260929-max310x-rs485-sw-delay-v5-0-ae46afa583f2@vaisala.com>
	<20260929-max310x-rs485-sw-delay-v5-4-ae46afa583f2@vaisala.com>
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

On Tue, 29 Sep 2026 09:37:58 +0000
Tapio Reijonen <tapio.reijonen@vaisala.com> wrote:

> max310x_tx_empty() reports the chip TX FIFO level and nothing else, so
> both tcdrain() and the tty layer's wait-until-sent on close() return
> while the final character is still clocking out of the transmit shift
> register. max310x_shutdown() then powers the port down mid-character
> and the last byte is truncated on the wire. At 9600 baud the ~1 ms
> window is easy to miss; at 1200 baud a write()-then-close() reliably
> corrupts the final byte (observed on the wire: 0x24 transmitted as a
> 0x04 frame with a framing error).
> 
> Wait in shutdown() for the FIFO to drain, bounded by one character
> duration per FIFO word, plus one more character for the byte in the
> shift register, before powering the port down. The per-character
> duration is computed in set_termios() from the frame size and baud
> rate.
> 
> Fixes: f65444187a66 ("serial: New serial driver MAX310X")
> Signed-off-by: Tapio Reijonen <tapio.reijonen@vaisala.com>
> ---
>  drivers/tty/serial/max310x.c | 23 +++++++++++++++++++++--
>  1 file changed, 21 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
> index f8dad37d017afe5c0b1d36d6239ba05fc5e7aff0..cd3b1913aaadba94805f4728b5eba18e970e34c8 100644
> --- a/drivers/tty/serial/max310x.c
> +++ b/drivers/tty/serial/max310x.c
> @@ -302,6 +302,7 @@ struct max310x_one {
>  	struct work_struct	md_work;
>  	struct work_struct	rs_work;
>  	struct regmap		*regmap;
> +	unsigned int		one_char_duration_us;

char_time_us?


>  	unsigned int		baud;
>  	bool			tx_break;	/* break_ctl() owns the transceiver */
>  
> @@ -1020,6 +1021,7 @@ static void max310x_set_termios(struct uart_port *port,
>  				struct ktermios *termios,
>  				const struct ktermios *old)
>  {
> +	unsigned int frame_bits = tty_get_frame_size(termios->c_cflag);
>  	unsigned int lcr = 0, flow = 0;
>  	int baud;
>  
> @@ -1132,10 +1134,13 @@ static void max310x_set_termios(struct uart_port *port,
>  	uart_update_timeout(port, termios->c_cflag, baud);
>  
>  	/*
> -	 * Cache the new baud rate and reprogram the RS485 RTS delays, whose
> -	 * millisecond-to-bit-time conversion depends on it.
> +	 * Cache the new baud rate and the time it takes to clock out one
> +	 * character, then reprogram the RS485 RTS delays, whose
> +	 * millisecond-to-bit-time conversion depends on the baud rate.
>  	 */
>  	to_max310x_port(port)->baud = baud;
> +	to_max310x_port(port)->one_char_duration_us =
> +		DIV_ROUND_UP(USEC_PER_SEC * frame_bits, baud);

Would it be a good idea to if you moved these two lines after
max310x_set_rts_ctl_params(), then you could probably leave the
original comments and simply add a new comment to indicate "Compute
time it takes to clock out one character", simplifying the diff
(review) and readability?

>  	max310x_set_rts_ctl_params(to_max310x_port(port));
>  }
>  
> @@ -1231,6 +1236,20 @@ static int max310x_startup(struct uart_port *port)
>  
>  static void max310x_shutdown(struct uart_port *port)
>  {
> +	struct max310x_one *one = to_max310x_port(port);
> +	unsigned int loops = port->fifosize + 1;

tries?

> +
> +	/*
> +	 * The tty layer waits for tx_empty() before close(), but tx_empty()
> +	 * only reflects the chip TX FIFO - the last character may still be in
> +	 * the transmit shift register. Let the FIFO drain and the final
> +	 * character clock out before the port is powered down, otherwise
> +	 * close() truncates the last byte on the wire.
> +	 */

Based on these comments, does it mean that the FIFO has already been
validated empty at this point by the tty layer, so you don't need the
loop at all, just the unconditional last fsleep()?

> +	while (!max310x_tx_empty(port) && loops-- > 0)
> +		fsleep(one->one_char_duration_us);

For certain combinations of large fifo_sizes and high-baud rates, that
could mean a lot of I2C/SPI transactions?


> +	fsleep(one->one_char_duration_us);
> +
>  	/* Disable all interrupts */
>  	max310x_port_write(port, MAX310X_IRQEN_REG, 0);
>  
> 
> -- 
> 2.47.3
> 
> 
> 


-- 
Hugo Villeneuve
