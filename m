From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 01/12] f81232: correct stubbed termios handler
Date: Wed, 27 Jun 2012 12:35:32 -0700
Message-ID: <20120627193532.GA5654@kroah.com>
References: <20120627112102.5678.4141.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:42972 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757040Ab2F0Tfe (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 27 Jun 2012 15:35:34 -0400
Content-Disposition: inline
In-Reply-To: <20120627112102.5678.4141.stgit@localhost.localdomain>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-serial@vger.kernel.org

On Wed, Jun 27, 2012 at 12:21:04PM +0100, Alan Cox wrote:
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

This patch still breaks the build, so I'm guessing the others still have
the same issues I reported yesterday?

Care to redo these?

greg k-h
