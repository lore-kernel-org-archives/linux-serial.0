From: Matthias Fuchs <mfuchs@ma-fu.de>
Subject: Re: [PATCH/RFC] serial: Add ioctl to enable auto rs485 mode with some Exar UARTs
Date: Mon, 22 Dec 2008 19:02:27 +0100
Message-ID: <200812221902.27752.mfuchs@ma-fu.de>
References: <200812190048.35249.mfuchs@ma-fu.de> <1229853004.3216.14.camel@thewinkle.toftronix.com.au> <20081222155956.GA13526@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-in-12.arcor-online.net ([151.189.21.52]:37798 "EHLO
	mail-in-12.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753930AbYLVSCb (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 22 Dec 2008 13:02:31 -0500
In-Reply-To: <20081222155956.GA13526@pengutronix.de>
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: linux-serial@vger.kernel.org

Oops,

I must admit that I was not aware of that thread. Mea culpa!
I will go through those arguments and see if I can take some
effort from that. 

Again, I will not take care of any software RS485 and I will
never use any name that contains RTS. 

I will also keep my ioctl implementation instead of any termios stuff
- when nobody contradicts.

Matthias

> Hello Chris,
>
> On Sun, Dec 21, 2008 at 08:50:04PM +1100, Chris Gibson wrote:
> > Two and a half weeks ago I submitted a patch to implement RS485 auto
> > direction control on either (or both) the RTS and the DTR lines with
> > varying pre and post delay settings that would work for _all_ uarts that
> > support mctrl.
>
> Just observing the case, I assume that this concern about software RS485
> is still valid:
>
> http://article.gmane.org/gmane.linux.serial/2568

