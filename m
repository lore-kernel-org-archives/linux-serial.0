From: Matthias Fuchs <mfuchs@ma-fu.de>
Subject: Re: Enabling auto RS485 half-duplex control
Date: Fri, 19 Dec 2008 00:42:24 +0100
Message-ID: <200812190042.24717.mfuchs@ma-fu.de>
References: <200812172224.13608.mfuchs@ma-fu.de> <20081218093514.GA3400@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-in-16.arcor-online.net ([151.189.21.56]:33863 "EHLO
	mail-in-16.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752115AbYLRXm2 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 18 Dec 2008 18:42:28 -0500
In-Reply-To: <20081218093514.GA3400@pengutronix.de>
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: linux-serial@vger.kernel.org

> Hi Matthias,
>
> > I did not find a way to enable this mode through the
> > standard serial driver. The UART is is detected correctly
> > but there seems to be no way to enable this mode
> > out of the box.
> >
> > So what's the best way to implement this?
> > A new ioctl? Any idea?
>
> See commmit c26c56c0f40e200e61d1390629c806f6adaffbcc. I think any
> solution to activate RS485 should be based on this.

Ok, I picked that up. Please see my patch coming up in a minute.

Matthias

>
> Regards,
>
>    Wolfram
