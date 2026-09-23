Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19AE47DF98;
	Wed, 23 Sep 2026 12:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790166017; cv=none; b=WDkq2XobbSVc/rnfZIPqHlauQ7gaygSZb2xSMTb/CotLf/2Swu2Esm+QK6QuiXu0NDSVKT0MH5eQwbn1iJYWYatLT2eL5YXNPREd0GOgzGgup9283FbExEUHMKc4ndYqIewF8lWYH44ztzVUhn1HreYPBpe3vGONB1YCU88UmoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790166017; c=relaxed/simple;
	bh=JrgbL9sPB12kKOj//d/nNNi/uEvNDUfSybDpnPv152w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qs3s8wNdV2KhG3CXMJmWNqGs5B6kZcRyneFOurhEpZfYxSUyAesnlTR5asUfpqxluqsPiYt/IQDlP2qNsgEkDHtxF5+Ch0n0PYrszNAAPiz5A5mBCL08WG3y42MUBou8OYp2u2owZh1hJepcdSBA5H5tJkrpjsU5G9F12hvi1Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jxpIx6Os; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jxpIx6Os"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FC651F000FF;
	Wed, 23 Sep 2026 12:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790166016;
	bh=fxFFIteRJYoJB49ZYsfj141AO5jf1YJl6WJYS+ZfbHo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jxpIx6OszsQhrKHmGLn4cENJTK9UGrlaL0E9j236hy8uGqYKR+Yb7d1xPJVVTt2WG
	 GIpM8rPdgy1HKGx3c1ZyGmIhrhC/6mBa1AFnTwT+fwgzCwFrhdVARHc2EGTglfNih5
	 M13tn1bNYPTLI0EEZW7A6LjX7E82Ybgmsz8BtAfY=
Date: Wed, 23 Sep 2026 14:20:10 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Nicolas Thibert <nithibert@gmail.com>
Cc: jirislaby@kernel.org, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] serial: 8250_of: set UART_CAP_NOTEMT for rts-gpios RS485
 direction
Message-ID: <2026092308-stinger-number-5fe7@gregkh>
References: <20260907173000.1254045-1-nithibert@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260907173000.1254045-1-nithibert@gmail.com>

On Mon, Sep 07, 2026 at 07:30:00PM +0200, Nicolas Thibert wrote:
> __stop_tx() (8250_port.c) only calls the RS485 rs485_stop_tx() hook
> (which de-asserts the direction GPIO/RTS line) once it has observed
> both UART_LSR_THRE and UART_LSR_TEMT for the last byte. If TEMT is
> never seen and the driver hasn't set UART_CAP_NOTEMT, the function
> returns without scheduling any retry -- the direction line is left
> asserted (driver enabled) forever, with nothing to un-stick it short
> of another kernel-visible LSR event.
> 
> of_platform_serial_setup()/of_platform_serial_probe() unconditionally
> wire up the generic em485 GPIO-RTS RS485 support
> (rs485_config/rs485_start_tx/rs485_stop_tx) for every port they
> register, but never set UART_CAP_NOTEMT, so any board using this
> driver whose 16550-compatible core doesn't reliably surface TEMT for
> its shift register hits the stuck-direction-GPIO case above.
> 
> Confirmed live on an ath79 QCA9531 board (SoC-internal ns16550a-
> compatible UART, RS485 transceiver DE/RE tied together on a GPIO via
> rts-gpios, linux,rs485-enabled-at-boot-time): the direction GPIO
> correctly asserts for the duration of a transmit, but never
> de-asserts afterwards -- confirmed by sampling the GPIO's debugfs
> state through and after a multi-hundred-byte write, on both the first
> transmit and repeated back-to-back transmits. Setting
> UART_CAP_NOTEMT, which makes __stop_tx() fall back to a frame-time-
> based timer instead of waiting indefinitely on TEMT, makes the
> direction GPIO reliably return low right after each transmit
> completes.
> 
> Scope the fix to ports that declare a GPIO-controlled direction line
> (rts-gpios), rather than setting it unconditionally for every port
> this driver registers: this is the class of hardware actually
> affected (RTS state has to be explicitly un-stuck by software, unlike
> a UART's native RTS pin), and it avoids adding the extra frame-time
> margin to ports relying on the native RTS pin, which this has not
> been observed to need.
> 
> Set it in of_platform_serial_probe(), after the existing
> "if (port8250.port.fifosize) port8250.capabilities = UART_CAP_FIFO;"
> assignment, rather than in of_platform_serial_setup(): that later
> plain assignment (not "|=") unconditionally overwrites
> port8250.capabilities on any port whose "fifo-size" DT property is
> set, silently discarding a capability bit set earlier in setup(). Not
> observed on the reporter's own board (it has no "fifo-size" property,
> so port.fifosize stays 0 and that assignment is skipped), but a real
> regression waiting to happen on any other of_platform_serial user
> that does set "fifo-size" -- which is a common, documented property
> for this binding.

Please rewrite this to be in english and says things properly.

> 
> Signed-off-by: Nicolas Thibert <nithibert@gmail.com>
> Assisted-by: LLM (Claude Sonnet 5, Anthropic)

signed-off-by goes last.

> ---
>  drivers/tty/serial/8250/8250_of.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> --- a/drivers/tty/serial/8250/8250_of.c
> +++ b/drivers/tty/serial/8250/8250_of.c
> @@ -233,6 +233,24 @@ static int of_platform_serial_probe(struct platform_device *ofdev)
>  			&port8250.overrun_backoff_time_ms) != 0)
>  		port8250.overrun_backoff_time_ms = 0;
> 
> +	/*
> +	 * This generic driver never enables a dedicated line-status
> +	 * interrupt on TEMT, so for ports whose RS485 direction is
> +	 * controlled via a GPIO (rts-gpios) rather than the native RTS
> +	 * pin, __stop_tx() (8250_port.c) can see THRE without TEMT on the
> +	 * last byte and bail out without ever retrying -- leaving the
> +	 * direction GPIO stuck asserted after the last byte sent, on
> +	 * hardware whose shift register doesn't reliably surface TEMT.
> +	 * UART_CAP_NOTEMT makes it fall back to a frame-time-based timer
> +	 * instead of waiting on that interrupt. Scoped to rts-gpios users
> +	 * only, to avoid changing timing for ports relying on the native
> +	 * RTS pin, which this has not been observed to affect. Set here,
> +	 * after the fifosize-based capabilities assignment above, so it
> +	 * isn't clobbered by it.
> +	 */

Is this comment really needed?


> +	if (of_property_present(ofdev->dev.of_node, "rts-gpios"))

What will change from this now on existing systems?

How was this tested?

And why was this sent twice?

thanks,

greg k-h
