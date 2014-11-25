From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] serial: 8250: Fix a compiler warning
Date: Tue, 25 Nov 2014 12:16:07 -0800
Message-ID: <20141125201607.GA30950@kroah.com>
References: <1415785741-13009-1-git-send-email-Chunhe.Lan@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:49431 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750812AbaKYUQI (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 25 Nov 2014 15:16:08 -0500
Content-Disposition: inline
In-Reply-To: <1415785741-13009-1-git-send-email-Chunhe.Lan@freescale.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Chunhe Lan <Chunhe.Lan@freescale.com>
Cc: linux-serial@vger.kernel.org

On Wed, Nov 12, 2014 at 05:49:01PM +0800, Chunhe Lan wrote:
> Spotted by a compile warning:
> 
> drivers/tty/serial/8250/8250_core.c: In function
>   'serial8250_shutdown':
> drivers/tty/serial/8250/8250_core.c:1747:18: warning:
>   'i' may be used uninitialized in this function [-Wuninitialized]
> drivers/tty/serial/8250/8250_core.c:1725:19: note:
>   'i' was declared here
> 
> Just because it annoys user.
> 
> Signed-off-by: Chunhe Lan <Chunhe.Lan@freescale.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/tty/serial/8250/8250_core.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
> index 312a83f..894a357 100644
> --- a/drivers/tty/serial/8250/8250_core.c
> +++ b/drivers/tty/serial/8250/8250_core.c
> @@ -1722,7 +1722,7 @@ static int serial_link_irq_chain(struct uart_8250_port *up)
>  
>  static void serial_unlink_irq_chain(struct uart_8250_port *up)
>  {
> -	struct irq_info *i;
> +	struct irq_info *i = NULL;

Don't paper over gcc bugs by putting unneeded initializations in the
kernel.  Try upgraging your version of gcc, I don't see this using
4.9.2.

thanks,

greg k-h
