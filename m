Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796FC468C22;
	Thu, 30 Jul 2026 16:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785428430; cv=none; b=FZIjF/hK/UEBKGqkgwN7qq80yYv1HFwv11vKRBt1sGxfyG4zqkgHG1RdoWiX47zsTUvVU+PeJXLXSiFEcC5nPjKU8iCETHNHIvwWXmVez+76caUwJ0mctqYVMjTf6D6qbwbIkKuzil0Q3+mt5JTAoN7Jk7YEurqQsd5J8lp+s7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785428430; c=relaxed/simple;
	bh=0Rn3n3MOrxEk+T6i/8qjV0qVOYEp9c1fzUI0uJo373g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jw9a/PmB7vo3VI+y6o1V8kRiDj/Qs7Uh1YEkb//JgwWzZfoLU+70BtVh9e3tL83GitqiIZdfFxT9L/rxc7CYS1Ca57hPi5e/hYH08jELFsws7nSR2pEoZ8sD2NTCkj5VtuOh/YxWPhNXSwlJb+R1TOEheTM7SdMdV12cfqkKX6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hTSeAEnW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hTSeAEnW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C1401F000E9;
	Thu, 30 Jul 2026 16:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785428429;
	bh=p0bmAcA4I40cCB3DSMR6QvXxq33KHl++PDGRgVGCdNM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hTSeAEnWbzRpUiY9yg2M8MsXXSw304HtFyc8nzigGmerxSWz+RAf8t+LUMD8ALHfI
	 ISEJYDODXyPiP5n3p/Hjpp3SC84hSGrxq3SqEC6hBvCD78QhtuzFHlJFKZT0wG3c8D
	 z11/YOVulC7+uMH4mOc+xQGQ1MBM2rM5g7CZNt4M=
Date: Thu, 30 Jul 2026 16:53:34 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Eric Curtin <ericcurtin17@gmail.com>
Cc: linux@armlinux.org.uk, jirislaby@kernel.org,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v4] serial: amba-pl011: don't wait for BUSY after every
 earlycon character
Message-ID: <2026073045-drove-underuse-fcde@gregkh>
References: <2026071036-unworn-bunny-fec5@gregkh>
 <20260720122646.16994-1-ericcurtin17@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260720122646.16994-1-ericcurtin17@gmail.com>

On Mon, Jul 20, 2026 at 12:26:46PM +0000, Eric Curtin wrote:
> An AI coding tool (OpenCode CLI, using Claude as the backing model) was
> used in preparing this patch. It was given the observation that
> earlycon output was slower than expected under virtualization and
> asked to locate the cause and propose a fix; it identified the
> per-character BUSY wait in pl011_putc() and, after being pointed at
> pl011_console_write_atomic()/_thread() as the existing precedent for a
> single final drain, produced the code that moves the wait into
> pl011_early_write(). It also helped research the QDF2400 erratum 44
> history cited above and draft this changelog. All of the above was
> reviewed by hand against the driver's other console write paths to
> confirm correctness. The boot-timing measurements and the line-for-line
> console diff were run and captured by hand on the VMM described above;
> they were not produced by the tool.

This means an Assisted-by line should be added.

Also, your changelog should be a lot smaller, LLMs love to talk a lot...


> 
> Signed-off-by: Eric Curtin <ericcurtin17@gmail.com>
> ---
> v4: v3 mistakenly replaced this patch's actual fix (moving the BUSY
>     wait to run once in pl011_early_write(), preserving the "fully
>     drained on return" guarantee) with a plain deletion of the wait,
>     which would have been a functional regression (e.g. for panic
>     output immediately followed by reboot/poweroff). This reverts to
>     the v2 fix, keeps the real, measured boot-timing numbers, and adds
>     the explicit disclosure of AI-tool assistance that was missing from
>     v2, per Documentation/process/generated-content.rst.
> v3: (erroneous, superseded by the above; sent by mistake)
> v2: Rather than simply deleting the wait, move it out of the
>     per-character pl011_putc() and into pl011_early_write(), done once
>     after the whole buffer is written (mirroring the existing pattern in
>     pl011_console_write_atomic()/_thread()), so earlycon keeps its
>     "fully transmitted by the time this call returns" guarantee. Also
>     added the QDF2400 erratum 44 history as context for why the BUSY
>     wait existed, and re-measured with the revised patch (numbers
>     updated accordingly, same conclusion).
> 
>  drivers/tty/serial/amba-pl011.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
> index 8ed91e1da22b..05a783dda4c4 100644
> --- a/drivers/tty/serial/amba-pl011.c
> +++ b/drivers/tty/serial/amba-pl011.c
> @@ -2741,8 +2741,6 @@ static void pl011_putc(struct uart_port *port, unsigned char c)
>  		writel(c, port->membase + UART01x_DR);
>  	else
>  		writeb(c, port->membase + UART01x_DR);
> -	while (readl(port->membase + UART01x_FR) & UART01x_FR_BUSY)
> -		cpu_relax();
>  }
>  
>  static void pl011_early_write(struct console *con, const char *s, unsigned int n)
> @@ -2750,6 +2748,20 @@ static void pl011_early_write(struct console *con, const char *s, unsigned int n
>  	struct earlycon_device *dev = con->data;
>  
>  	uart_console_write(&dev->port, s, n, pl011_putc);
> +
> +	/*
> +	 * Wait for the last character to be fully transmitted before
> +	 * returning, same as pl011_console_write_atomic()/_thread() do for
> +	 * the non-early console. There is no need to do this after every
> +	 * character in pl011_putc(): checking TXFF there already prevents
> +	 * overrunning the FIFO, and waiting for BUSY per character forces
> +	 * the UART to be drained serially instead of letting it buffer
> +	 * queued bytes, which is needlessly slow, especially so under
> +	 * virtualization where each poll of UARTFR/UARTDR is a trapped MMIO
> +	 * access.
> +	 */

And this comment is also really not needed, right?

thanks,

greg k-h
