From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v6 1/3] tty/serial: Add GPIOLIB helpers for controlling
 modem lines
Date: Wed, 2 Apr 2014 16:13:15 -0700
Message-ID: <20140402231315.GD24324@kroah.com>
References: <1394469951-21192-1-git-send-email-richard.genoud@gmail.com>
 <1394469951-21192-2-git-send-email-richard.genoud@gmail.com>
 <20140317232359.GA8943@kroah.com>
 <533C280F.3060804@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:51111 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161080AbaDBXWZ (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 2 Apr 2014 19:22:25 -0400
Content-Disposition: inline
In-Reply-To: <533C280F.3060804@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Richard Genoud <richard.genoud@gmail.com>
Cc: Richard Genoud <noreply.rgenoud@gmail.com>, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, Nicolas Ferre <nicolas.ferre@atmel.com>, Linus Walleij <linus.walleij@linaro.org>, Alexander Shiyan <shc_work@mail.ru>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Wed, Apr 02, 2014 at 05:09:03PM +0200, Richard Genoud wrote:
> On 18/03/2014 00:23, Greg Kroah-Hartman wrote:
> > On Mon, Mar 10, 2014 at 05:45:49PM +0100, Richard Genoud wrote:
> >> This patch add some helpers to control modem lines (CTS/RTS/DSR...) via
> >> GPIO.
> >> This will be useful for many boards which have a serial controller that
> >> only handle CTS/RTS pins (or even just RX/TX).
> >>
> >> Signed-off-by: Richard Genoud <richard.genoud@gmail.com>
> > 
> > Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > 
> > I can't take this series through my tty tree as the non-tty patches
> > don't apply, so feel free to take them through whatever tree is needed.
> > 
> > greg k-h
> > 
> 
> I guess this series won't make it for 3.15, as it doesn't apply on any tree.
> However, I'd like to know if I did something wrong, or if there's no
> solution when a series depends on several patches that are in different
> trees ?

That's a hard problem, either wait a release cycle for everything to get
merged properly (like should be done in time for 3.15-rc1 now) and then
submit the code, or ask for different maintainers to either allow other
trees to take the patches, put the patches in different trees at the
same time, or have "topic branches" that different maintainers can pull
from.

Care to send me the patches after 3.15-rc1 is out, as there should not
be any dependancy issues then, right?

greg k-h
