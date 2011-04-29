From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH V4] tty/serial: add support for Xilinx PS UART
Date: Fri, 29 Apr 2011 22:32:22 +0100
Message-ID: <20110429223222.7d283dde@lxorguk.ukuu.org.uk>
References: <20110429211434.GA1355@kroah.com>
	<1426670407.2093674.1304112562934.JavaMail.root@sz0140a.emeryville.ca.mail.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:46890 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757640Ab1D2VbY (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 29 Apr 2011 17:31:24 -0400
In-Reply-To: <1426670407.2093674.1304112562934.JavaMail.root@sz0140a.emeryville.ca.mail.comcast.net>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: johnlinn@comcast.net
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, michal simek <michal.simek@petalogix.com>, joe@perches.com, grant likely <grant.likely@secretlab.ca>, John Linn <john.linn@xilinx.com>

> Yes I'll have a look at it, sorry for the hassle.  
> 
> I'm assuming I need to try it against linus
> tree as something may have changed. Or some other tree?

Or you are assuimg NO_IRQ is defined everywhere which it isn't. The
kernel mainstream just uses zero as intended not a define for it.

Alan
