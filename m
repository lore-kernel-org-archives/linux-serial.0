Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A6FFC4338F
	for <linux-serial@archiver.kernel.org>; Sun, 25 Jul 2021 12:14:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D51060F36
	for <linux-serial@archiver.kernel.org>; Sun, 25 Jul 2021 12:14:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbhGYLd5 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 25 Jul 2021 07:33:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:48272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229538AbhGYLd4 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Sun, 25 Jul 2021 07:33:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E25B660F13;
        Sun, 25 Jul 2021 12:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627215265;
        bh=kduJYIait4oOIsS6HVhuBc3H0dAcsqPllKnu/62xyhk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aEDCgZvSpJ4h8nPjCc5kbRnzy+3EkYX/BsZhEO4Qpzl3kiWNTSp2pvPxrS+XB4Rjl
         qd5ND6aum7AA2J95mkpTZf8bgjnA962y/N+JSvRy9i2qbS8JjqL/OaU3HAzKyjwSqg
         WV//vN6q7GNCSyvf7lPa+cCe4gq5pPNPZe3j/x262DfG9JoQXpbuBolw8KGXl3ON6j
         Vw8WiV8AQvrX9NN1R7qPB6ONOkP3GRMbvJEaSkbzkKy1vntmFNcZGv/Bk3ay0C/36I
         BwbR6wvakHBCEKOUKu63xLjSeppFKiBJ5dA2IeRntMVnGEMD/tXaAJRzrUTQEBJjkS
         /25rUF9Ss6y/w==
Received: by pali.im (Postfix)
        id 75CBF949; Sun, 25 Jul 2021 14:14:22 +0200 (CEST)
Date:   Sun, 25 Jul 2021 14:14:22 +0200
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
Message-ID: <20210725121422.26agyztfrsrn43xg@pali>
References: <20210624224909.6350-1-pali@kernel.org>
 <20210717123829.5201-1-pali@kernel.org>
 <20210717123829.5201-3-pali@kernel.org>
 <YPMS24faTg9tqreR@lunn.ch>
 <20210717180540.ersg5bslik6ivjie@pali>
 <20210724094816.2y3peclaftx26kwj@pali>
 <YPxA3Zcfw8ZPNYZp@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YPxA3Zcfw8ZPNYZp@lunn.ch>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Saturday 24 July 2021 18:33:33 Andrew Lunn wrote:
> On Sat, Jul 24, 2021 at 11:48:16AM +0200, Pali Rohár wrote:
> > On Saturday 17 July 2021 20:05:40 Pali Rohár wrote:
> > > On Saturday 17 July 2021 19:26:51 Andrew Lunn wrote:
> > > > On Sat, Jul 17, 2021 at 02:38:26PM +0200, Pali Rohár wrote:
> > > > > @@ -445,6 +472,7 @@ static void mvebu_uart_shutdown(struct uart_port *port)
> > > > >  static int mvebu_uart_baud_rate_set(struct uart_port *port, unsigned int baud)
> > > > >  {
> > > > >  	unsigned int d_divisor, m_divisor;
> > > > > +	unsigned long flags;
> > > > >  	u32 brdv, osamp;
> > > > >  
> > > > >  	if (!port->uartclk)
> > > > > @@ -463,10 +491,12 @@ static int mvebu_uart_baud_rate_set(struct uart_port *port, unsigned int baud)
> > > > >  	m_divisor = OSAMP_DEFAULT_DIVISOR;
> > > > >  	d_divisor = DIV_ROUND_CLOSEST(port->uartclk, baud * m_divisor);
> > > > >  
> > > > > +	spin_lock_irqsave(&mvebu_uart_lock, flags);
> > > > 
> > > > Hi Pali
> > > > 
> > > > You only need spin_lock_irqsave() if you plan on taking the spinlock
> > > > in an interrupt handler. It seems unlikely the baud rate will be
> > > > changed in interrupt context? Please check, and then swap to plain
> > > > spin_lock().
> > > 
> > > Hello! Ok, I will check it.
> > 
> > Well, driver is already using spin_lock_irqsave() in all other
> > functions.
> 
> And some of those functions are called from interrupt context i
> expect. For each lock you have, you need to decide if interrupt
> context is an issue or not. spin_lock_irqsave() is more expansive,
> since it has to disable interrupts, etc. It can upset real time
> latency etc. So in the hot path, you want to try to avoid it, unless
> you actually need it. But changing the baud rate is not the hot path,
> it hardly every happens, so we can live with the unneeded overhead.

It happens either one time during "device" probing (e.g. when connected
bluetooth UART device want to use higher baudrate) or when user
explicitly ask to change baudrate (e.g. when want to transfer files over
UART via x/y/z-modem / kermit protocol). Or maybe if somebody wants to
establish and use PPP network over UART. So it should not be a problem.

> > And in linux/clk-provider.h is documented that drivers can call
> > clk_enable() from an interrupt, so it means that spin_lock_irqsave() is
> > really needed for mvebu_uart_lock.
> 
> Sure, drivers can. But in this case, does a driver actually do that?
> Does it change the baud rate in interrupt context?

Looks like that changing baudrate not. But other places where this lock
is used (e.g. in clk callbacks) can be called from interrupt context.

But for baudrate change, I think it is not so common action, so there
should not be issue with slightly higher overhead.

> > > In other patches is updated function mvebu_uart_set_termios() which
> > > verifies that you can set particular baudrate.
> 
> Great. It is not clear from the patches or the commit message that
> this has been considered. It is something worth mentioning, just to
> avoid questions.

This check was there also prior my patches. I only "extended" it to
match what is supported by this patch series.

> > > Also note that all A3720 boards have disabled UART2 in DTS. And I'm not
> > > sure if there is somebody who uses UART2 or who uses both UARTs.
> 
> That does not really matter. You should not regression a feature
> because you think nobody is using it.

I know. That is why I introduced code which recalculates divisors
registers to not change baudrate of UART2 during loading of UART1 and
also introduction of this clk subdriver with locks to prevent any
regressions.
