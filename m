Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAEF2C4338F
	for <linux-serial@archiver.kernel.org>; Sat, 24 Jul 2021 16:33:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 701D360E78
	for <linux-serial@archiver.kernel.org>; Sat, 24 Jul 2021 16:33:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbhGXPxJ (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 24 Jul 2021 11:53:09 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:43918 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229461AbhGXPxI (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Sat, 24 Jul 2021 11:53:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
        Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
        In-Reply-To:References; bh=twJ8xIjqD5TS4LTpX8lw+/A1muRMGOB9w8Tr8EsfDFM=; b=T2
        GfZzF7+1cPrdQw/snjzYv5Lyyz3JLiRE8v41W8Qf0R52hffRWff6c8vj0hyoFKkW7v3LULZjrNe3J
        tA4b80bww3+rQqBPNqxgptjIwSpjQJYzSem49KaAUAJR3tbM7UPgvDKjd2wLtLLsK5GUv7jJb4EBo
        u/Fs9ge70YTxe/M=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1m7Kak-00Edt2-0O; Sat, 24 Jul 2021 18:33:34 +0200
Date:   Sat, 24 Jul 2021 18:33:33 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Vladimir Vid <vladimir.vid@sartura.hr>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-clk@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 2/5] serial: mvebu-uart: implement UART clock driver
 for configuring UART base clock
Message-ID: <YPxA3Zcfw8ZPNYZp@lunn.ch>
References: <20210624224909.6350-1-pali@kernel.org>
 <20210717123829.5201-1-pali@kernel.org>
 <20210717123829.5201-3-pali@kernel.org>
 <YPMS24faTg9tqreR@lunn.ch>
 <20210717180540.ersg5bslik6ivjie@pali>
 <20210724094816.2y3peclaftx26kwj@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210724094816.2y3peclaftx26kwj@pali>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Sat, Jul 24, 2021 at 11:48:16AM +0200, Pali Rohár wrote:
> On Saturday 17 July 2021 20:05:40 Pali Rohár wrote:
> > On Saturday 17 July 2021 19:26:51 Andrew Lunn wrote:
> > > On Sat, Jul 17, 2021 at 02:38:26PM +0200, Pali Rohár wrote:
> > > > @@ -445,6 +472,7 @@ static void mvebu_uart_shutdown(struct uart_port *port)
> > > >  static int mvebu_uart_baud_rate_set(struct uart_port *port, unsigned int baud)
> > > >  {
> > > >  	unsigned int d_divisor, m_divisor;
> > > > +	unsigned long flags;
> > > >  	u32 brdv, osamp;
> > > >  
> > > >  	if (!port->uartclk)
> > > > @@ -463,10 +491,12 @@ static int mvebu_uart_baud_rate_set(struct uart_port *port, unsigned int baud)
> > > >  	m_divisor = OSAMP_DEFAULT_DIVISOR;
> > > >  	d_divisor = DIV_ROUND_CLOSEST(port->uartclk, baud * m_divisor);
> > > >  
> > > > +	spin_lock_irqsave(&mvebu_uart_lock, flags);
> > > 
> > > Hi Pali
> > > 
> > > You only need spin_lock_irqsave() if you plan on taking the spinlock
> > > in an interrupt handler. It seems unlikely the baud rate will be
> > > changed in interrupt context? Please check, and then swap to plain
> > > spin_lock().
> > 
> > Hello! Ok, I will check it.
> 
> Well, driver is already using spin_lock_irqsave() in all other
> functions.

And some of those functions are called from interrupt context i
expect. For each lock you have, you need to decide if interrupt
context is an issue or not. spin_lock_irqsave() is more expansive,
since it has to disable interrupts, etc. It can upset real time
latency etc. So in the hot path, you want to try to avoid it, unless
you actually need it. But changing the baud rate is not the hot path,
it hardly every happens, so we can live with the unneeded overhead.

> And in linux/clk-provider.h is documented that drivers can call
> clk_enable() from an interrupt, so it means that spin_lock_irqsave() is
> really needed for mvebu_uart_lock.

Sure, drivers can. But in this case, does a driver actually do that?
Does it change the baud rate in interrupt context?

> > In other patches is updated function mvebu_uart_set_termios() which
> > verifies that you can set particular baudrate.

Great. It is not clear from the patches or the commit message that
this has been considered. It is something worth mentioning, just to
avoid questions.

> > Also note that all A3720 boards have disabled UART2 in DTS. And I'm not
> > sure if there is somebody who uses UART2 or who uses both UARTs.

That does not really matter. You should not regression a feature
because you think nobody is using it.

	Andrew
