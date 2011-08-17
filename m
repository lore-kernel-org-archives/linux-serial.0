From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [UART] Why CAP_SYS_ADMIN can open non-started port?
Date: Wed, 17 Aug 2011 11:13:09 +0100
Message-ID: <20110817111309.6abf1fe6@lxorguk.ukuu.org.uk>
References: <4E4B8907.8030008@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:41247 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752758Ab1HQKJs (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 17 Aug 2011 06:09:48 -0400
In-Reply-To: <4E4B8907.8030008@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Jiri Slaby <jirislaby@gmail.com>
Cc: linux-serial@vger.kernel.org, Greg KH <gregkh@suse.de>, linux@arm.linux.org.uk

On Wed, 17 Aug 2011 11:25:27 +0200
Jiri Slaby <jirislaby@gmail.com> wrote:

> Hi,
> 
> while I was in the process of uart cleanup, I found this:
> static int uart_startup(...) {
>   ...
>   retval = port->ops->startup(port);
>   ...
>   if (retval && capable(CAP_SYS_ADMIN))
>     retval = 0;
> 
>   return retval;
> }
> 
> Why CAP_SYS_ADMIN should not see the failing port startup? Does anybody
> from you remember if it is for some kind of possibility to later
> re-autoconfigure the port or something like that?

In a word - setserial

Alan
