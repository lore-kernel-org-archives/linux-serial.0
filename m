Return-Path: <SRS0=INAG=AM=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89485C433DF
	for <linux-serial@archiver.kernel.org>; Wed,  1 Jul 2020 11:39:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6AE4B206CB
	for <linux-serial@archiver.kernel.org>; Wed,  1 Jul 2020 11:39:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730245AbgGALjT (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 1 Jul 2020 07:39:19 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:48480 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730196AbgGALjT (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 1 Jul 2020 07:39:19 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id A9B848030868;
        Wed,  1 Jul 2020 11:39:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Qs3WUKcY0GC5; Wed,  1 Jul 2020 14:39:08 +0300 (MSK)
Date:   Wed, 1 Jul 2020 14:39:04 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Lukas Wunner <lukas@wunner.de>
CC:     Daniel Winkler <danielwinkler@google.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        <linux-serial@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        chromeos-bluetooth-upstreaming 
        <chromeos-bluetooth-upstreaming@chromium.org>,
        Aaron Sierra <asierra@xes-inc.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Revert "serial: 8250: Fix max baud limit in generic 8250
 port"
Message-ID: <20200701113904.7zh534vmlvjvojia@mobilestation>
References: <20200630164204.1.I2cc415fa5793b3e55acfd521ba8f0a71e79aa5f1@changeid>
 <20200701043001.73qhxyyjx6bayn2m@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200701043001.73qhxyyjx6bayn2m@wunner.de>
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hello Lukas,

On Wed, Jul 01, 2020 at 06:30:01AM +0200, Lukas Wunner wrote:
> On Tue, Jun 30, 2020 at 04:42:11PM -0700, Daniel Winkler wrote:
> > This reverts commit 0eeaf62981ecc79e8395ca8caa1570eaf3a12257.
> 
> That is not an upstream commit.  You probably mean:
> 
>     commit 7b668c064ec33f3d687c3a413d05e355172e6c92
>     Author: Serge Semin <Sergey.Semin@baikalelectronics.ru>
>     Date:   Thu May 7 02:31:32 2020 +0300
> 
>     serial: 8250: Fix max baud limit in generic 8250 port
> 
> And you didn't cc the commit author (hereby fixed).
> 
> Thanks,
> 
> Lukas

Thanks for Cc'ing me.

> 
> > 
> > The change regresses the QCA6174A-3 bluetooth chip, preventing
> > firmware from being properly loaded. We have verified that without
> > this patch, the chip works as intended.

That text doesn't say what is really wrong and why the firmware couldn't be loaded.
The original commit gets back the 8250 port baud rate limitation so if the baud
gets out of the range [uartclk / 16 / UART_DIV_MAX; (port->uartclk + tolerance) /
16], then it will be clamped to be within it. That range is what the standard
8250 port supports. Acceptance of out of that range values will cause a
problem further in calling serial8250_get_divisor() and uart_get_divisor()
methods (see the original patch log message) for standard 8250 ports. Any different
behavior must be taken into account by a custom set_termios() callbacks or at
least must be workarounded so the standard 8250 ports wouldn't be affected. So in
order to investigate the root cause of the problem it would be good to at least
know what your platform was and what UART port has been used in the attempt to
load the QCA6174A-3 chip firmware.

-Sergey

> > 
> > Signed-off-by: Daniel Winkler <danielwinkler@google.com>
> > ---
> > 
> >  drivers/tty/serial/8250/8250_port.c | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> > 
> > diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
> > index 1632f7d25acca..e057c65ac1580 100644
> > --- a/drivers/tty/serial/8250/8250_port.c
> > +++ b/drivers/tty/serial/8250/8250_port.c
> > @@ -2618,8 +2618,6 @@ static unsigned int serial8250_get_baud_rate(struct uart_port *port,
> >  					     struct ktermios *termios,
> >  					     struct ktermios *old)
> >  {
> > -	unsigned int tolerance = port->uartclk / 100;
> > -
> >  	/*
> >  	 * Ask the core to calculate the divisor for us.
> >  	 * Allow 1% tolerance at the upper limit so uart clks marginally
> > @@ -2628,7 +2626,7 @@ static unsigned int serial8250_get_baud_rate(struct uart_port *port,
> >  	 */
> >  	return uart_get_baud_rate(port, termios, old,
> >  				  port->uartclk / 16 / UART_DIV_MAX,
> > -				  (port->uartclk + tolerance) / 16);
> > +				  port->uartclk);
> >  }
> >  
> >  void
> > -- 
> > 2.27.0.212.ge8ba1cc988-goog
