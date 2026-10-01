Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303C94BE438;
	Thu,  1 Oct 2026 08:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790844170; cv=none; b=ALf50GWnbJKlPIesSPHlQ9DZG27JanNV2YF+OA/Q4Y7bOAvx1xLAcmmj0DC1laCOP63lQozBBP3a4v1cuyPADAO3rbwivUQ+UALNlSDGneDufRNQx/C5BO8OcAZJZDLMKSao/jzY7YnqYxdKJyOlOQFrycpe3Z/fZcEypzqA/g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790844170; c=relaxed/simple;
	bh=SNofVKPACh2ylupG0wyHOfbQ7LzJLyBJ87tcTUZoT2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eRPDyezSdKrIzj1r7hCIPx1buJ+Sa6xYzHfscki+rcC82Bx2dt3VPHkcXJ30fRjfgMRqLN60aUpDQl+BLg7VGcYzQ+r8f6DjI+IdFlwcd/bzYn6RUDgyhwTWFSnoWteO39veKCOUCagGrMcF3w6NILoXTWBcXCJgHgN5hslLKms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kP3IdNbQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kP3IdNbQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FD371F0089A;
	Thu,  1 Oct 2026 08:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790844164;
	bh=9hOkpGS5ErwxdHwTx0cN+BXyaNkX9IR+KQs4cH+2KAU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kP3IdNbQJsXfM9PScfd7ItsfkKVyq8TnrevWk2zpdYB7wCai88LVMKjSeH/nMir5h
	 iWl79fgcHR4prmsz5KOCgBYWluFO1vFHU7DpIuxZIcx8/vEg60msmRN+W3C0X9KIgn
	 vCbLOsu7D4fy8185lGwJykbpezvx2JJgDSyGsqqE=
Date: Thu, 1 Oct 2026 10:42:38 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-serial@vger.kernel.org, Vineet Gupta <vgupta@kernel.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	"open list:SYNOPSYS ARC ARCHITECTURE" <linux-snps-arc@lists.infradead.org>,
	"open list:TTY LAYER AND SERIAL DRIVERS" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] serial: arc_uart: Use platform IRQ helper
Message-ID: <2026100129-unrest-cleaver-6528@gregkh>
References: <20260925183050.56839-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260925183050.56839-1-rosenp@gmail.com>

On Fri, Sep 25, 2026 at 11:30:50AM -0700, Rosen Penev wrote:
> Avoid calling irq_dispose_mapping() by letting the platform_device
> machinery handle it. Also enable possibility of handling -EPROBE_DEFER
> and other errors. Handle as early as possible to avoid doing unnecessary
> work.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  drivers/tty/serial/arc_uart.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/arc_uart.c b/drivers/tty/serial/arc_uart.c
> index 3988e5958896..b46b057a181b 100644
> --- a/drivers/tty/serial/arc_uart.c
> +++ b/drivers/tty/serial/arc_uart.c
> @@ -30,7 +30,6 @@
>  #include <linux/tty_flip.h>
>  #include <linux/serial_core.h>
>  #include <linux/io.h>
> -#include <linux/of_irq.h>
>  #include <linux/of_address.h>
>  
>  /*************************************
> @@ -571,12 +570,17 @@ static int arc_serial_probe(struct platform_device *pdev)
>  	struct arc_uart_port *uart;
>  	struct uart_port *port;
>  	int dev_id;
> +	int irq;
>  	u32 val;
>  
>  	/* no device tree device */
>  	if (!np)
>  		return -ENODEV;
>  
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq < 0)
> +		return irq;
> +
>  	dev_id = of_alias_get_id(np, "serial");
>  	if (dev_id < 0)
>  		dev_id = 0;
> @@ -607,7 +611,7 @@ static int arc_serial_probe(struct platform_device *pdev)
>  		return PTR_ERR(port->membase);
>  	}
>  
> -	port->irq = irq_of_parse_and_map(np, 0);
> +	port->irq = irq;
>  
>  	port->dev = &pdev->dev;
>  	port->iotype = UPIO_MEM;
> -- 
> 2.55.0
> 
> 

You forgot an Assisted-by: tag here :(
