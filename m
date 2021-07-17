Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44618C636CA
	for <linux-serial@archiver.kernel.org>; Sat, 17 Jul 2021 18:05:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29D4E6109E
	for <linux-serial@archiver.kernel.org>; Sat, 17 Jul 2021 18:05:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234965AbhGQSIk (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 17 Jul 2021 14:08:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:54016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234042AbhGQSIk (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Sat, 17 Jul 2021 14:08:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EEEBD6113D;
        Sat, 17 Jul 2021 18:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626545143;
        bh=Wx3d2rSoMyanRvaHxjT04gccedJKeDVcgb0/ewtg9ps=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G+2x81erW2Me0TroIJjdu4bGmJwjzRUF8EI0zPxfJyBnxjVXL3yuUDdKrDOsOEEVy
         +TBEo80fBAzRCWJsHPapigJZWF3oME8o1b572ECemTy6Hs06mTj5TBPmLgqjeS6yjN
         fskcafEx4gFrOLra7/xq4lHSTxRFQDgfcdz/hURclsoSw4MjD5OM7V8IXUUgsBhWFu
         0tTWcxpFyeMjc7zMDzG/+oXqc1aYIf82CpeqHLVs5lXrLxyoX3SfCMLW3lRvqo0w+I
         C2bMBihXvpu1sv0xsaZT55UED101nV9ZSt+/7q2Of/Ma4wooOSVIxGZ2pW2Kknc0MS
         eq5BxR7IGS2Wg==
Received: by pali.im (Postfix)
        id 504DA95D; Sat, 17 Jul 2021 20:05:40 +0200 (CEST)
Date:   Sat, 17 Jul 2021 20:05:40 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Vladimir Vid <vladimir.vid@sartura.hr>,
        Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-clk@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 2/5] serial: mvebu-uart: implement UART clock driver
 for configuring UART base clock
Message-ID: <20210717180540.ersg5bslik6ivjie@pali>
References: <20210624224909.6350-1-pali@kernel.org>
 <20210717123829.5201-1-pali@kernel.org>
 <20210717123829.5201-3-pali@kernel.org>
 <YPMS24faTg9tqreR@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YPMS24faTg9tqreR@lunn.ch>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Saturday 17 July 2021 19:26:51 Andrew Lunn wrote:
> On Sat, Jul 17, 2021 at 02:38:26PM +0200, Pali Rohár wrote:
> > @@ -445,6 +472,7 @@ static void mvebu_uart_shutdown(struct uart_port *port)
> >  static int mvebu_uart_baud_rate_set(struct uart_port *port, unsigned int baud)
> >  {
> >  	unsigned int d_divisor, m_divisor;
> > +	unsigned long flags;
> >  	u32 brdv, osamp;
> >  
> >  	if (!port->uartclk)
> > @@ -463,10 +491,12 @@ static int mvebu_uart_baud_rate_set(struct uart_port *port, unsigned int baud)
> >  	m_divisor = OSAMP_DEFAULT_DIVISOR;
> >  	d_divisor = DIV_ROUND_CLOSEST(port->uartclk, baud * m_divisor);
> >  
> > +	spin_lock_irqsave(&mvebu_uart_lock, flags);
> 
> Hi Pali
> 
> You only need spin_lock_irqsave() if you plan on taking the spinlock
> in an interrupt handler. It seems unlikely the baud rate will be
> changed in interrupt context? Please check, and then swap to plain
> spin_lock().

Hello! Ok, I will check it.

> >  	brdv = readl(port->membase + UART_BRDV);
> >  	brdv &= ~BRDV_BAUD_MASK;
> >  	brdv |= d_divisor;
> >  	writel(brdv, port->membase + UART_BRDV);
> > +	spin_unlock_irqrestore(&mvebu_uart_lock, flags);
> >  
> >  	osamp = readl(port->membase + UART_OSAMP);
> >  	osamp &= ~OSAMP_DIVISORS_MASK;
> 
> > +	/* Recalculate UART1 divisor so UART1 baudrate does not change */
> > +	if (prev_clock_rate) {
> > +		divisor = DIV_U64_ROUND_CLOSEST((u64)(val & BRDV_BAUD_MASK) *
> > +						parent_clock_rate * prev_d1d2,
> > +						prev_clock_rate * d1 * d2);
> > +		if (divisor < 1)
> > +			divisor = 1;
> > +		else if (divisor > BRDV_BAUD_MAX)
> > +			divisor = BRDV_BAUD_MAX;
> > +		val = (val & ~BRDV_BAUD_MASK) | divisor;
> > +	}
> 
> I don't see any range checks in the patch which verifies the requested
> baud rate is actually possible. With code like this, it seems like the
> baud rate change will be successful, but the actual baud rate will not
> be what is requested.

This code is in function which changes parent UART clock from one used
by bootloader to clock which will be used by kernel UART driver.

Yes, it is possible if you configure something unusual in bootloader
that that this code breaks it. But I think there is not so much what we
can done here.

In other patches is updated function mvebu_uart_set_termios() which
verifies that you can set particular baudrate.

> > +	/* Recalculate UART2 divisor so UART2 baudrate does not change */
> > +	if (prev_clock_rate) {
> > +		val = readl(uart_clock_base->reg2);
> > +		divisor = DIV_U64_ROUND_CLOSEST((u64)(val & BRDV_BAUD_MASK) *
> > +						parent_clock_rate * prev_d1d2,
> > +						prev_clock_rate * d1 * d2);
> > +		if (divisor < 1)
> > +			divisor = 1;
> > +		else if (divisor > BRDV_BAUD_MAX)
> > +			divisor = BRDV_BAUD_MAX;
> > +		val = (val & ~BRDV_BAUD_MASK) | divisor;
> > +		writel(val, uart_clock_base->reg2);
> 
> Here it looks like UART1 could request a baud rate change, which ends
> up setting the clocks so that UART2 is out of range? Could the change
> for UART1 be successful, but you end up breaking UART2? I'm thinking
> when you are at opposite ends of the scale. UART2 is running at
> 110baud and UART1 at 230400baud.

This code is also in function which just do one time change of UART
parent clock. Once clk driver is probed this parent clock (and its d1
and d2 divisors) are not changed anymore. Parent clock and divisors are
chosen in way that kernel can always configure minimal baudrate 9600 on
both UARTs.

You are right that some combinations are not possible. But with these
patches it is fixed what is supported at clk driver probe time.

In v3 patch 5/5 is described how to calculate final baudrate from parent
clock and divisors d1, d2, d, m1, m2, m3, m4. Note that parent clock and
divisors d1 and d2 are shared for both UARTs. Other parameters (d, m1,
m2, m3, m4) can be set differently both UART1 and UART2. Changing shared
values is not possible during usage of UART.

If you have any idea how to improve current implementation, please let
me know.

Also note that all A3720 boards have disabled UART2 in DTS. And I'm not
sure if there is somebody who uses UART2 or who uses both UARTs.
