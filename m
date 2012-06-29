From: Johan Adolfsson <johan.adolfsson@axis.com>
Subject: RE: artpec.c / serial_core.c hardware flow control problem
Date: Fri, 29 Jun 2012 17:16:40 +0200
Message-ID: <4BEA3FF3CAA35E408EA55C7BE2E61D055C79D9B622@xmail3.se.axis.com>
References: <4FEC7857.6010006@axis.com>
 <20120628172421.4cb91ada@pyramind.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from anubis.se.axis.com ([195.60.68.12]:54389 "EHLO
	anubis.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756018Ab2F2PXl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 29 Jun 2012 11:23:41 -0400
In-Reply-To: <20120628172421.4cb91ada@pyramind.ukuu.org.uk>
Content-Language: en-US
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, Mikael Lars Johansson <mikaeljo@axis.com>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Mikael Starvik <starvik@axis.com>, Jesper Nilsson <jespern@axis.com>, Johan Adolfsson <johana@axis.com>



> -----Original Message-----
> From: linux-serial-owner@vger.kernel.org [mailto:linux-serial-
> owner@vger.kernel.org] On Behalf Of Alan Cox
> Sent: den 28 juni 2012 18:24
> 
> On Thu, 28 Jun 2012 17:29:27 +0200
> Mikael Johansson <mikael.lars.johansson@axis.com> wrote:
> 
> > Greetings,
> >
> > We have a problem with drivers/serial/artpec.c (Not yet in main tree)
> > which uses hardware supported flow control (XON/XOFF). We do
> cfmakeraw()
> > and tcsetattr() from userspace to set a termios struct where (c_iflag
> &
> > IXON) is not set. The problem is that the call to tcsetattr() is not
> > propagated down to serial_artpec_set_termios(), the reason being that
> > uart_set_termios() doesn't think that IXON is a RELEVANT_IFLAG and
> > returns prematurely instead of calling uart_change_speed -->
> > ops->set_termios().
> >
> > Could this be fixed by making IXON a RELEVANT_IFLAG?:
> 
> That's actually insufficient for those cases - you can set the
> characters
> used for things as well plus IXANY and IXOFF.
> 
> It's a stupid "optimisation" and the only reason I didn't get rid of it
> before was in case it broke something else. Time for it to go.
> 
> So yeah - I'd just delete it.

Do you mean the entire if () { return; } statement or just the RELEVANT_IFLAG part?

> If you are doing hardware XON/XOFF watch c_cc[VSTART] and c_cc[VSTOP].
> Those control the symbol used for soft flow control.

We use STOP_CHAR(tty), we only have hardware support for stopping transfer,
the tty layer kicks in and enables it again.

> Alan

/Johan

