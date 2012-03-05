From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 7/9] tty : kill receive_room usage in tty_buffer
Date: Mon, 5 Mar 2012 10:31:59 +0000
Message-ID: <20120305103159.3db2b777@pyramind.ukuu.org.uk>
References: <1330883960-8563-1-git-send-email-castet.matthieu@free.fr>
	<1330883960-8563-8-git-send-email-castet.matthieu@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:36730 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756473Ab2CEKaN (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 5 Mar 2012 05:30:13 -0500
In-Reply-To: <1330883960-8563-8-git-send-email-castet.matthieu@free.fr>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Matthieu CASTET <castet.matthieu@free.fr>
Cc: linux-serial@vger.kernel.org, Felipe Balbi <balbi@ti.com>, Toby Gray <toby.gray@realvnc.com>, Stefan Bigler <stefan.bigler@keymile.com>

On Sun,  4 Mar 2012 18:59:18 +0100
Matthieu CASTET <castet.matthieu@free.fr> wrote:

> Signed-off-by: Matthieu CASTET <castet.matthieu@free.fr>
> ---
>  drivers/tty/tty_buffer.c |   10 ++++------
>  1 files changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/tty/tty_buffer.c b/drivers/tty/tty_buffer.c
> index 0e0f0fa..8cc7ceb 100644
> --- a/drivers/tty/tty_buffer.c
> +++ b/drivers/tty/tty_buffer.c
> @@ -437,17 +437,15 @@ static void flush_to_ldisc(struct work_struct *work)
>  			 */
>  			if (test_bit(TTY_LDISC_CHANGING, &tty->flags))
>  				break;
> -			if (!tty->receive_room)
> -				break;
> -			if (count > tty->receive_room)
> -				count = tty->receive_room;
>  			char_buf = head->char_buf_ptr + head->read;
>  			flag_buf = head->flag_buf_ptr + head->read;
> -			head->read += count;
>  			spin_unlock_irqrestore(&tty->buf.lock, flags);
> -			disc->ops->receive_buf(tty, char_buf,
> +			count = disc->ops->receive_buf(tty, char_buf,
>  							flag_buf, count);
>  			spin_lock_irqsave(&tty->buf.lock, flags);
> +			if (count == 0)
> +				break;
> +			head->read += count;

If you've not fixed the parallel calls bugs head->read can now be
invalid. Previously it was at least vaguely self consistent because the
lock was held for the entire calculation and head->read set up before the
buffer want to the ldisc, now its updated some arbitary time in the
future by which point one of the buggy parallel callers may have messed
it up.
