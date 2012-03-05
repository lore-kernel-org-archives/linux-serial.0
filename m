From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 4/9] tty : kill receive_room usage in vt
Date: Mon, 5 Mar 2012 10:29:52 +0000
Message-ID: <20120305102952.779a33e6@pyramind.ukuu.org.uk>
References: <1330883960-8563-1-git-send-email-castet.matthieu@free.fr>
	<1330883960-8563-5-git-send-email-castet.matthieu@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:38036 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756418Ab2CEK2A (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 5 Mar 2012 05:28:00 -0500
In-Reply-To: <1330883960-8563-5-git-send-email-castet.matthieu@free.fr>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Matthieu CASTET <castet.matthieu@free.fr>
Cc: linux-serial@vger.kernel.org, Felipe Balbi <balbi@ti.com>, Toby Gray <toby.gray@realvnc.com>, Stefan Bigler <stefan.bigler@keymile.com>

On Sun,  4 Mar 2012 18:59:15 +0100
Matthieu CASTET <castet.matthieu@free.fr> wrote:

> Signed-off-by: Matthieu CASTET <castet.matthieu@free.fr>
> ---
>  drivers/tty/vt/selection.c |    3 +--
>  1 files changed, 1 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/vt/selection.c b/drivers/tty/vt/selection.c
> index 7a0a12a..3e9a914 100644
> --- a/drivers/tty/vt/selection.c
> +++ b/drivers/tty/vt/selection.c
> @@ -332,8 +332,7 @@ int paste_selection(struct tty_struct *tty)
>  			continue;
>  		}
>  		count = sel_buffer_lth - pasted;
> -		count = min(count, tty->receive_room);
> -		tty->ldisc->ops->receive_buf(tty, sel_buffer + pasted,
> +		count = tty->ldisc->ops->receive_buf(tty, sel_buffer + pasted,
>  								NULL, count);

This is unsafe in your model - it's not valid to call it as selection
does in the first place. You have two parallel consumers here so any
result is nonsense (and it'll make messes elsewhere)

It's unsafe in the existing model too, but the existing one will recover
whereas once you switch behaviour the new one won't.

