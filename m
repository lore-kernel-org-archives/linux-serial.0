From: Greg KH <greg@kroah.com>
Subject: Re: [patch 3/3] drivers/serial/serial_core.c: prevent reading
 uninitialized stack memory
Date: Wed, 6 Oct 2010 13:20:34 -0700
Message-ID: <20101006202034.GD26397@kroah.com>
References: <201010012118.o91LI4lh021287@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:46413 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755931Ab0JFUrr (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 6 Oct 2010 16:47:47 -0400
Content-Disposition: inline
In-Reply-To: <201010012118.o91LI4lh021287@imap1.linux-foundation.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: akpm@linux-foundation.org
Cc: linux-serial@vger.kernel.org, drosenberg@vsecurity.com, alan@lxorguk.ukuu.org.uk, dan.j.rosenberg@gmail.com

On Fri, Oct 01, 2010 at 02:18:04PM -0700, akpm@linux-foundation.org wrote:
> From: Dan Rosenberg <drosenberg@vsecurity.com>
> 
> The TIOCGICOUNT device ioctl allows unprivileged users to read
> uninitialized stack memory, because the "reserved" member of the
> serial_icounter_struct struct declared on the stack is not altered or
> zeroed before being copied back to the user.  This patch takes care of it.
> 
> Signed-off-by: Dan Rosenberg <dan.j.rosenberg@gmail.com>
> Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
> Cc: Greg KH <greg@kroah.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  drivers/serial/serial_core.c |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff -puN drivers/serial/serial_core.c~drivers-serial-serial_corec-prevent-reading-uninitialized-stack-memory drivers/serial/serial_core.c
> --- a/drivers/serial/serial_core.c~drivers-serial-serial_corec-prevent-reading-uninitialized-stack-memory
> +++ a/drivers/serial/serial_core.c
> @@ -1081,6 +1081,8 @@ static int uart_get_icount(struct tty_st
>  	struct uart_icount cnow;
>  	struct uart_port *uport = state->uart_port;
>  
> +	memset(&icount, 0, sizeof(struct serial_icounter_struct));

This patch is no longer needed as Alan fixed it in the tty core.

thanks,

greg k-h
