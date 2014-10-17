From: Richard Weinberger <richard@nod.at>
Subject: Re: [PATCH -next 04/10] uml: Fix unsafe pid reference to foreground
 process group
Date: Fri, 17 Oct 2014 09:57:59 +0200
Message-ID: <5440CC07.3000205@nod.at>
References: <1413485990-16855-1-git-send-email-peter@hurleysoftware.com> <1413485990-16855-5-git-send-email-peter@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from a.ns.miles-group.at ([95.130.255.143]:65275 "EHLO radon.swed.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751037AbaJQH6G (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 17 Oct 2014 03:58:06 -0400
In-Reply-To: <1413485990-16855-5-git-send-email-peter@hurleysoftware.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net

Am 16.10.2014 um 20:59 schrieb Peter Hurley:
> Although the tty core maintains a pid reference for the foreground
> process group, if the foreground process group is changed that
> pid reference is dropped. Thus, the pid reference used for signalling
> could become stale.
> 
> Safely obtain a pid reference to the foreground process group and
> release the reference after signalling is complete.
> 
> cc: Jeff Dike <jdike@addtoit.com>
> cc: Richard Weinberger <richard@nod.at>
> cc: user-mode-linux-devel@lists.sourceforge.net
> Signed-off-by: Peter Hurley <peter@hurleysoftware.com>

Acked-by: Richard Weinberger <richard@nod.at>

> ---
>  arch/um/drivers/line.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/um/drivers/line.c b/arch/um/drivers/line.c
> index 8035145..6208702 100644
> --- a/arch/um/drivers/line.c
> +++ b/arch/um/drivers/line.c
> @@ -632,6 +632,7 @@ static irqreturn_t winch_interrupt(int irq, void *data)
>  	int fd = winch->fd;
>  	int err;
>  	char c;
> +	struct pid *pgrp;
>  
>  	if (fd != -1) {
>  		err = generic_read(fd, &c, NULL);
> @@ -657,7 +658,10 @@ static irqreturn_t winch_interrupt(int irq, void *data)
>  		if (line != NULL) {
>  			chan_window_size(line, &tty->winsize.ws_row,
>  					 &tty->winsize.ws_col);
> -			kill_pgrp(tty->pgrp, SIGWINCH, 1);
> +			pgrp = tty_get_pgrp(tty);
> +			if (pgrp)
> +				kill_pgrp(pgrp, SIGWINCH, 1);
> +			put_pid(pgrp);
>  		}
>  		tty_kref_put(tty);
>  	}
> 
