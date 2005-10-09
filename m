From: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [patch 3/4] new serial flow control
Date: Sun, 9 Oct 2005 01:01:53 +0100
Message-ID: <20051009000153.GA23083__189.038800499652$1128817347$gmane$org@flint.arm.linux.org.uk>
References: <200501052341.j05Nfod27823@mail.osdl.org> <20050105235301.B26633@flint.arm.linux.org.uk> <20051008222711.GA5150@bouh.residence.ens-lyon.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailfe13.tele2.fr ([212.247.155.140]:58109 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S932194AbVJIAVs (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 8 Oct 2005 20:21:48 -0400
Received: from [80.170.13.95] (HELO bouh.famille.thibault.fr)
  by mailfe13.swip.net (CommuniGate Pro SMTP 4.3.4)
  with ESMTPS id 32597579 for linux-serial@vger.kernel.org; Sun, 09 Oct 2005 02:21:43 +0200
Received: from samy by bouh.famille.thibault.fr with local (Exim 4.54)
	id 1EOOwf-0005NO-9a
	for linux-serial@vger.kernel.org; Sun, 09 Oct 2005 02:21:41 +0200
Content-Disposition: inline
In-Reply-To: <20051008222711.GA5150@bouh.residence.ens-lyon.fr>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Samuel Thibault <samuel.thibault@ens-lyon.org>, akpm@osdl.org, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org

On Sun, Oct 09, 2005 at 12:27:11AM +0200, Samuel Thibault wrote:
> Hi,
> 
> I'm re-opening a somewhat old thread about serial flow control methods:
> 
> Russell King, le Wed 05 Jan 2005 23:53:01 +0000, a ?crit :
> > we have other people
> > who want to use their on-board hardware RS485 flow control options on
> > UARTs for their application, which means we need an RS485 flow control
> > method.  (They can't select it without accessing the hardware directly.)
> > 
> > So, we now seem to have:
> > 
> > 	Standard flow control
> > 	CTVB flow control
> > 	RS485 RTS flow control
> 
> Let's add a new one: Inka braille devices, which uses RTS/CTS as
> acknowledge strobes for each character.
> 
> > I still believe that flow control should be enabled by CRTSCTS, but
> > the flow control personality set by other means.
> > 
> > Therefore, I think this requires further discussion, especially with
> > Alan (who seems to be the tty layer god now) to work out some sort of
> > reasonable interface.
> 
> How could this look like in userspace? Something like
> 
> #define CRTSCTS_RS232 0
> #define CRTSCTS_RS485 1
> #define CRTSCTS_TVB 2
> #define CRTSCTS_INKA 3
> 	int method = CRTSCTS_RS485;
> 	ioctl(fd,TIOCMSFLOWCTRL,&method);
> 
> (and the converse TIOCMGFLOWCTRL)?

I think they should be termios settings - existing programs know how
to handle termios to get what they want.  Why make the situation more
complex for them?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
