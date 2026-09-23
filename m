Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB41D48381C;
	Wed, 23 Sep 2026 10:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790159966; cv=none; b=AlToUtXBMxSbn/aBm/oCezyKTKThuxamg3XjDThe0rEqjOA0PmhG24GHLMNLgfoUhPhaynVV04k2pvoqKR5OGgTFKjfglxOwBGj0bmDNyZHjBnT6IgbT/0jLN4kJBQPRqepj61+QjGn/SpqvawSH4fpoaRah7OSfydx/0LXXZxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790159966; c=relaxed/simple;
	bh=A/w/e/gznSdHUXYMVfp0VnSeI8Mmpva2w+DcOBLKrOs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TymXZSn+84f3QOgAHVwsnv5BxRkMaq7KoG6TKVU56SMW7w3ONbhlErhlNYrAzrWrQoYdD/ZBhELB0uf/zs8sfPTbdF84ejXZnrOn5Icbe68U1RwK579v7YQuwWd1Z802uO3ykE5vVWWbWIjj/vgBi+9BChOgcAQtaTUyzdLlYFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WPb1Md5e; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WPb1Md5e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D3861F000FF;
	Wed, 23 Sep 2026 10:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790159954;
	bh=/TSAY36zZ7N+PmA3CUunkqcb1zBjSi77Wr7KZvK/Epw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WPb1Md5eJrJbc+DFPxvOwTHz/7H7z6N7zVclXHjfO8UfvFOGlyLIDZNIJiDFWT/Hf
	 d3yoCbKNJvUHYuiCuUR2pX/u0MjWQwqtGkl1SNnp0aP/ByuB1kLB4m5HE7BKixI9Vb
	 nkLKpBZ9R0JBBrBgqytONQBx6QpSVer0hLj+aHas=
Date: Wed, 23 Sep 2026 12:39:10 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Tapio Reijonen <tapio.reijonen@vaisala.com>
Cc: Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Tapio Reijonen <tapio.reijonen@kolumbus.fi>
Subject: Re: [PATCH v4] serial: max310x: drive RTS in software when hardware
 delays are too short
Message-ID: <2026092326-truth-unweave-c773@gregkh>
References: <20260916-max310x-rs485-sw-delay-v4-1-d37a694342cf@vaisala.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260916-max310x-rs485-sw-delay-v4-1-d37a694342cf@vaisala.com>

On Wed, Sep 16, 2026 at 07:10:54AM +0000, Tapio Reijonen wrote:
> max310x_rs485_config() rejected delay_rts_before_send and
> delay_rts_after_send values larger than 0x0f with -ERANGE, which made
> the UART core wipe port->rs485 in uart_rs485_config() and silently
> disable RS485. The HDPIXDELAY register holds the setup and hold
> delays in 4-bit-per-direction bit-times, so even values inside that
> range only encode a fraction of a millisecond at typical baud rates
> and the chip's hardware auto-RTS path cannot cover the millisecond
> range the kernel UART layer expresses.
> 
> Add a software-driven RTS path that takes over whenever the hardware
> cannot represent the requested timing:
> 
>   * Cache the current baud rate and the per-character on-the-wire
>     duration in max310x_set_termios() so the decision below can use
>     them.
>   * max310x_set_rts_ctl_params() picks software or hardware timing:
>       - software if delay_rts_before_send or delay_rts_after_send in
>         milliseconds exceeds what 15 bit-times can encode at the
>         current baud, or if the requested RTS polarity cannot be
>         produced by the chip's auto-RTS engine;
>       - hardware otherwise, converting the millisecond delays to
>         bit-times (rounded up, capped at 15) and programming
>         MODE1.TRNSCVCTRL plus IRDA.RTSINVERT to drive RTS with the
>         requested polarity. RTS is left deasserted at idle; the chip's
>         auto-RTS engine owns the transceiver during transmission.
>   * When software timing is selected the RTS envelope is driven by a
>     single hrtimer, re-used for the before- and after-send phases (the
>     phase is tracked in tx_state), plus a single rts_work that toggles
>     RTS. max310x_start_tx() queues rts_work to assert RTS; rts_work
>     arms the timer for the before-send delay only after the RTS edge is
>     on the wire, so data is never shifted before RTS is asserted. The
>     timer expiry kicks tx_work to fill the chip FIFO; once that FIFO is
>     empty (max310x_handle_tx()) the same timer is re-armed for one
>     character duration plus the after-send delay, after which rts_work
>     releases RTS. The hold is armed only while tx_state is
>     MAX310X_TX_SEND, re-checked under port->lock because
>     max310x_handle_tx() runs from a worker that does not hold it and the
>     port can be shut down in the meantime. Using one timer and one
>     rts_work keeps the before-
>     and after-send phases mutually exclusive and the RTS toggles
>     ordered, which matters for back-to-back writes and on SMP.
>   * The LCR register carries the TX break and RTS bits next to the
>     termios bits, so max310x_set_termios() updates only the bits it owns
>     instead of writing the register absolutely, and
>     max310x_set_rts_ctl_params() settles RTS to the idle level only
>     while tx_state is MAX310X_TX_OFF. Both can run while a software
>     timed envelope is in flight - serial_core calls ->set_termios()
>     without port->lock, and max310x_rs485_config() schedules a
>     reconfigure on every TIOCSRS485 - and would otherwise release the
>     transceiver mid-character.
>   * max310x_shutdown() waits for transmission to finish before powering
>     the port down, so close() cannot truncate the final byte.
>     On the software path it waits out any in-flight RTS envelope
>     (bounded) so the last character and its after-send hold complete.
>     On the hardware path it lets the chip FIFO drain and the last
>     character clock out of the shift register: tx_empty only reports
>     the TX FIFO empty, not the shift register, so without this the
>     port could be powered down mid-character. The delay timer and
>     rts_work are then cancelled unconditionally: the software/hardware
>     decision is recomputed on every reconfigure, so a TIOCSRS485 can
>     clear sw_rts_during_tx while an envelope is still in flight, and
>     neither may outlive the port. That flag is published in a single
>     store for the same reason.
>   * max310x_rs485_config() now clamps the delays to the UART core's
>     RS485_MAX_RTS_DELAY (100 ms) instead of rejecting them, and
>     cancels the pending delay timer when RS485 is disabled.
>   * max310x_break_ctl() drives RTS manually for the break duration. The
>     chip's auto-RTS only asserts the transceiver while FIFO data is
>     shifting out, and a break is not FIFO data, so on the hardware path
>     it also disables auto-RTS for the break and restores it when the
>     break ends. The software path drives the configured RS485 RTS
>     polarity; on the hardware path IRDA.RTSINVERT already inverts the
>     RTS_ output stage, so break_state is driven as it is.


That's a lot to do in one commit.  Why can't this be broken up into "do
only one thing at a time" patch series?

That might make all of this much more sane and managable and reviewable,
as it is, it is none of that.

thanks,

greg k-h
