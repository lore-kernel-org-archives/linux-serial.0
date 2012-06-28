From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: artpec.c / serial_core.c hardware flow control problem
Date: Thu, 28 Jun 2012 17:24:21 +0100
Message-ID: <20120628172421.4cb91ada@pyramind.ukuu.org.uk>
References: <4FEC7857.6010006@axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:43099 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754949Ab2F1QU0 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 28 Jun 2012 12:20:26 -0400
In-Reply-To: <4FEC7857.6010006@axis.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Mikael Johansson <mikael.lars.johansson@axis.com>
Cc: linux-serial@vger.kernel.org, Mikael Starvik <starvik@axis.com>, Jesper Nilsson <jespern@axis.com>, Johan Adolfsson <johana@axis.com>

On Thu, 28 Jun 2012 17:29:27 +0200
Mikael Johansson <mikael.lars.johansson@axis.com> wrote:

> Greetings,
> 
> We have a problem with drivers/serial/artpec.c (Not yet in main tree) 
> which uses hardware supported flow control (XON/XOFF). We do cfmakeraw() 
> and tcsetattr() from userspace to set a termios struct where (c_iflag & 
> IXON) is not set. The problem is that the call to tcsetattr() is not 
> propagated down to serial_artpec_set_termios(), the reason being that 
> uart_set_termios() doesn't think that IXON is a RELEVANT_IFLAG and 
> returns prematurely instead of calling uart_change_speed --> 
> ops->set_termios().
> 
> Could this be fixed by making IXON a RELEVANT_IFLAG?:

That's actually insufficient for those cases - you can set the characters
used for things as well plus IXANY and IXOFF.

It's a stupid "optimisation" and the only reason I didn't get rid of it
before was in case it broke something else. Time for it to go.

So yeah - I'd just delete it.

If you are doing hardware XON/XOFF watch c_cc[VSTART] and c_cc[VSTOP].
Those control the symbol used for soft flow control.

Alan


