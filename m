From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 01/10] f81232: correct stubbed termios handler
Date: Thu, 12 Jul 2012 14:36:02 -0700
Message-ID: <20120712213602.GA11567@kroah.com>
References: <20120712115643.1321.63498.stgit@localhost.localdomain>
 <20120712115848.1321.12293.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:37532 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S964803Ab2GLVgE (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 12 Jul 2012 17:36:04 -0400
Content-Disposition: inline
In-Reply-To: <20120712115848.1321.12293.stgit@localhost.localdomain>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-serial@vger.kernel.org

On Thu, Jul 12, 2012 at 12:58:55PM +0100, Alan Cox wrote:
> From: Alan Cox <alan@linux.intel.com>
> 
> Signed-off-by: Alan Cox <alan@linux.intel.com>
> ---
> 
>  drivers/usb/serial/f81232.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/usb/serial/f81232.c b/drivers/usb/serial/f81232.c
> index 499b15f..acd3267 100644
> --- a/drivers/usb/serial/f81232.c
> +++ b/drivers/usb/serial/f81232.c
> @@ -177,6 +177,7 @@ static void f81232_set_termios(struct tty_struct *tty,
>  		return;
>  
>  	/* Do the real work here... */
> +	tty_termios_copy_hw(&tty->termios, old_termios);

Drop the '&' and the code will compile correctly.

Otherwise, it's wrong :(

greg k-h
