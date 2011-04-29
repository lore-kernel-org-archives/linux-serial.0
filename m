From: johnlinn@comcast.net
Subject: Re: [PATCH V4] tty/serial: add support for Xilinx PS UART
Date: Fri, 29 Apr 2011 21:41:08 +0000 (UTC)
Message-ID: <1013673718.2094564.1304113268455.JavaMail.root@sz0140a.emeryville.ca.mail.comcast.net>
References: <20110429223222.7d283dde@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110429223222.7d283dde@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, michal simek <michal.simek@petalogix.com>, joe@perches.com, grant likely <grant.likely@secretlab.ca>, John Linn <john.linn@xilinx.com>
List-Id: linux-serial@vger.kernel.org


> > Yes I'll have a look at it, sorry for the hassle.  
> > 
> > I'm assuming I need to try it against linus
> > tree as something may have changed. Or some other tree?
> 
> Or you are assuimg NO_IRQ is defined everywhere which it isn't. The
> kernel mainstream just uses zero as intended not a define for it.
> 
> Alan

Ahh... maybe I see, it's only defined in ARM and that's what I was building
for.  I'm a little slow sometimes, but I'll get there.

Gotcha, replace with 0. Thanks.
