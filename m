From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] tty: Correct tty buffer flushing.
Date: Thu, 29 Nov 2012 13:54:18 +0000
Message-ID: <20121129135418.4237e7f8@pyramind.ukuu.org.uk>
References: <50B55A93.4090900@ilyx.ru>
	<50B6A652.9000107@ilyx.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:45939 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753394Ab2K2Ntv (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 29 Nov 2012 08:49:51 -0500
In-Reply-To: <50B6A652.9000107@ilyx.ru>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Ilya Zykov <ilya@ilyx.ru>
Cc: Xiaobing Tu <xiaobing.tu@intel.com>, Alan Cox <alan@linux.intel.com>, Jiri Slaby <jslaby@suse.cz>, Alek Du <alek.du@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org

> diff --git a/drivers/tty/tty_buffer.c b/drivers/tty/tty_buffer.c
> index 6c9b7cd..4f02f9c 100644
> --- a/drivers/tty/tty_buffer.c
> +++ b/drivers/tty/tty_buffer.c
> @@ -114,11 +114,14 @@ static void __tty_buffer_flush(struct tty_struct *tty)
>  {
>  	struct tty_buffer *thead;
>  
> -	while ((thead = tty->buf.head) != NULL) {
> -		tty->buf.head = thead->next;
> -		tty_buffer_free(tty, thead);
> +	if (tty->buf.head == NULL)
> +		return;
> +	while ((thead = tty->buf.head->next) != NULL) {
> +		tty_buffer_free(tty, tty->buf.head);
> +		tty->buf.head = thead;

This part of the change seems to have no effect at all. There are no
locks held so there is nothing guaranteeing how the other processors
views of the order of operations will be affected.

Alan
