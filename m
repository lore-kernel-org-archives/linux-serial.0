From: johnlinn@comcast.net
Subject: Re: kernel lockup due to bad baud rate data
Date: Thu, 16 Jun 2011 13:31:37 +0000 (UTC)
Message-ID: <113808021.1641051.1308231097763.JavaMail.root@sz0140a.emeryville.ca.mail.comcast.net>
References: <20110616091928.1aa28c86@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from qmta07.emeryville.ca.mail.comcast.net ([76.96.30.64]:53022 "EHLO
	qmta07.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753152Ab1FPNbk (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 16 Jun 2011 09:31:40 -0400
In-Reply-To: <20110616091928.1aa28c86@lxorguk.ukuu.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-serial@vger.kernel.org, Greg KH <greg@kroah.com>

> On Wed, 15 Jun 2011 17:21:30 -0700
> Greg KH <greg@kroah.com> wrote:
> 
> > On Thu, Jun 16, 2011 at 12:09:12AM +0000, johnlinn@comcast.net wrote:
> > > I'm testing with 2.6.39 and our serial driver that's unique to our ARM
> > > platform.  I suspect we have a problem with our serial driver but
> > > wanted to see if anyone has seen any similar behavior.
> > > 
> > > When running with 2 serial ports, any input from a serial terminal
> > > running at the wrong baud rate (9600 instead of 115.2K) on a 2nd shell
> > > (not the console shell) causes the kernel to lock up. It doesn't
> > > crash, I'm still trying to understand what it's doing.  I can no
> > > longer ping the board as the network was working prior.
> > > 
> > > I just wanted to make sure there's not any known tty issues related to
> > > this.
> > 
> > There are some odd issues with stuff in this area, care to try 3.0-rc3
> > and see if the problem is there as well or not?

I'll give it a try if I can get some time today. Thanks for input Greg.

> 
> If its driver specific as this seems I'd take a guess on the driver
> for the hardware not properly handling framing errors or break so you get
> an irq storm or some other failure from the framing error.

I was thinking in the same direction as Alan also.  Appreciate the input.

-- John
