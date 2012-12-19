From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] tty: Fix unreasonable write toward closed pty.
Date: Wed, 19 Dec 2012 19:10:30 +0000
Message-ID: <20121219191030.4ee20a1c@pyramind.ukuu.org.uk>
References: <50D20E87.9060403@ilyx.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:42789 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751184Ab2LSTGF (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 19 Dec 2012 14:06:05 -0500
In-Reply-To: <50D20E87.9060403@ilyx.ru>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Ilya Zykov <ilya@ilyx.ru>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <alan@linux.intel.com>, Jiri Slaby <jslaby@suse.cz>, Peter Hurley <peter@hurleysoftware.com>, Sasha Levin <levinsasha928@gmail.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org

> diff --git a/drivers/tty/pty.c b/drivers/tty/pty.c
> index a82b399..1ce1362 100644
> --- a/drivers/tty/pty.c
> +++ b/drivers/tty/pty.c
> @@ -116,6 +116,8 @@ static int pty_space(struct tty_struct *to)
>  
>  static int pty_write(struct tty_struct *tty, const unsigned char *buf, int c)
>  {
> +	if (test_bit(TTY_OTHER_CLOSED, &tty->flags))
> +		return -EIO;

The flag can change between the test and ny further code being executed ?

Alan
