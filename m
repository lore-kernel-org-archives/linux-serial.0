Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04164D17A2;
	Mon, 19 Oct 2026 13:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792417549; cv=none; b=ZrBji0G/3I3QzvWlIbNI25EEyqqC4KQ0Ei3P70EX8T9xnZuPQbAtBtXNSXQ/XMAjExl9eECSRq+dHHtQR01al56MSf4PiiJRnNSNzisAJHoD1HFONGF5my6rEHoCxFO8rKK7TKQNoX1tJhgY3lIIOZfwwjfXHi1aEZtmqCB0S2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792417549; c=relaxed/simple;
	bh=nGv/eGQjzo9215N9dvvxoEwehFmKMdSVZplyu5qMf6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r2GDZpYy3312nVfqNMGyHb7UA7tRsd/ittvT9gkrrPOvh5/gJxOf5+LsSIHOcIQjtlud5zooyxpXe41wQwy5KshC0xRuf9+S+F88FWpWEbPae5cegPfuTyyzRgaq6QrprdQF49kVefxPoNv3ogpptKyTO9S+cIgwMHbKRVxYddg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FMYnsCmE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FMYnsCmE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFA8F1F000C4;
	Mon, 19 Oct 2026 13:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1792417547;
	bh=nS6GU5tGW1Nodnfb18uSuxnHP5yUMBytwoKlABIhNpI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FMYnsCmEytrzPIrcWuCVvppMKbU2Ka4jahkDvMwMnfV8zq5aLkZJGuIL8p2Jc8vQe
	 jfqO9x/Y/TdzpVdu67NfjJ+n7s1OLwc5CiOomavC2UDdC9HDPTBn6vyXpx+0yi6bLn
	 EH6PD/oVAQVPrs5oMO1PmPuE/vxIDSw+oG+hwO3o=
Date: Mon, 19 Oct 2026 15:45:44 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: LI xiao <lixiao0@hdu.edu.cn>
Cc: jirislaby@kernel.org, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH] tty: timbuart: kill tasklet after freeing IRQ
Message-ID: <2026101926-rants-refinish-22da@gregkh>
References: <AHQArwC2LDgmty1sqnW35KqM.1.1792408152646.Hmail.252270051@hdu.edu.cn>
 <2026101954-snarl-frenzy-da86@gregkh>
 <AMoAIAAtLCMmxKHlfyhDJarK.3.1792416715880.Hmail.252270051@hdu.edu.cn>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AMoAIAAtLCMmxKHlfyhDJarK.3.1792416715880.Hmail.252270051@hdu.edu.cn>

On Mon, Oct 19, 2026 at 09:31:55PM +0800, LI xiao wrote:
> The timbuart driver calls tasklet_kill() before uart_remove_one_port().
> An interrupt can schedule the tasklet again after tasklet_kill()
> returns but before timbuart_shutdown() frees the IRQ. The subsequent
> free_irq() synchronizes the IRQ handler, but does not drain a tasklet
> that the handler has already queued.
> 
> Move tasklet_kill() to timbuart_shutdown(), immediately after
> free_irq(), so that any tasklet queued by the IRQ handler is drained
> before uart_remove_one_port() releases the port resources.
> 
> I tested the intended synchronization ordering with a KASAN-enabled
> kernel in a QEMU guest using a test module. The module queued
> the tasklet, waited for the simulated IRQ handler to exit, called
> tasklet_kill(), and then freed the UART object. The tasklet completed
> without a KASAN report or scheduling warning.
> 
> This was a controlled test of the synchronization ordering. It did
> not exercise timbuart's actual IRQ handler or Timberdale UART hardware,
> which is not modeled by QEMU.

Ah, that might be tricky, I think you need to test this on real hardware
as you are changing the logic here.

> Signed-off-by: LI Xiao <lixiao0@hdu.edu.cn>

No fixes: tag?  Cc: stable?


> 
> ---
>  drivers/tty/serial/timbuart.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/timbuart.c b/drivers/tty/serial/timbuart.c
> index 7a0326e71..c561ca702 100644
> --- a/drivers/tty/serial/timbuart.c
> +++ b/drivers/tty/serial/timbuart.c
> @@ -254,6 +254,7 @@ static void timbuart_shutdown(struct uart_port *port)
>  		container_of(port, struct timbuart_port, port);
>  	dev_dbg(port->dev, "%s\n", __func__);
>  	free_irq(port->irq, uart);
> +	tasklet_kill(&uart->tasklet);
>  	iowrite32(0, port->membase + TIMBUART_IER);
>  
>  	timbuart_flush_buffer(port);

Are you sure you can flush after the tasklet is killed?  Nothing
requires it to still be running at this point in time?

And why not stop it before the irq is freed as that's what it is
handling?  Note, I could be totally wrong, I'm just guessing here...

thanks,

greg k-h
