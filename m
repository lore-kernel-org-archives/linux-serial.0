From: johnlinn@comcast.net
Subject: Re: [PATCH V4] tty/serial: add support for Xilinx PS UART
Date: Fri, 29 Apr 2011 21:35:28 +0000 (UTC)
Message-ID: <915452381.2094179.1304112928503.JavaMail.root@sz0140a.emeryville.ca.mail.comcast.net>
References: <681890114.2094084.1304112868616.JavaMail.root@sz0140a.emeryville.ca.mail.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <681890114.2094084.1304112868616.JavaMail.root@sz0140a.emeryville.ca.mail.comcast.net>
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

Thanks Alan, I'll fix that.  I wanted to make sure I replicated the issue
so I could verify it goes away.
