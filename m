Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12AACC636C9
	for <linux-serial@archiver.kernel.org>; Sat, 17 Jul 2021 17:27:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D491D61164
	for <linux-serial@archiver.kernel.org>; Sat, 17 Jul 2021 17:27:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232828AbhGQR37 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 17 Jul 2021 13:29:59 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:59922 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232010AbhGQR36 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Sat, 17 Jul 2021 13:29:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
        Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
        In-Reply-To:References; bh=JHiMbsp05pbGMAUABzAHsB0xUjHxzmh4UHPPdbARD7U=; b=kc
        YCaWUaoFG8tUNAUF++VCslkyByjSaaAWsQzrmC1jXnzwsSL4hA9BkmFgJ5JovrTmWGkmrYhbmXEf7
        nJnhND6SgI1xfIt1pr21UC6jhy4H3ScNJ7eLXsO5fcvyzGzIVdJfOfNwUPHKfL8r7N+UG9P+0c9I1
        lE3zjbDC8Q5t2RQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1m4o5T-00DkJo-MT; Sat, 17 Jul 2021 19:26:51 +0200
Date:   Sat, 17 Jul 2021 19:26:51 +0200
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
Message-ID: <YPMS24faTg9tqreR@lunn.ch>
References: <20210624224909.6350-1-pali@kernel.org>
 <20210717123829.5201-1-pali@kernel.org>
 <20210717123829.5201-3-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210717123829.5201-3-pali@kernel.org>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Sat, Jul 17, 2021 at 02:38:26PM +0200, Pali Rohár wrote:
> @@ -445,6 +472,7 @@ static void mvebu_uart_shutdown(struct uart_port *port)
>  static int mvebu_uart_baud_rate_set(struct uart_port *port, unsigned int baud)
>  {
>  	unsigned int d_divisor, m_divisor;
> +	unsigned long flags;
>  	u32 brdv, osamp;
>  
>  	if (!port->uartclk)
> @@ -463,10 +491,12 @@ static int mvebu_uart_baud_rate_set(struct uart_port *port, unsigned int baud)
>  	m_divisor = OSAMP_DEFAULT_DIVISOR;
>  	d_divisor = DIV_ROUND_CLOSEST(port->uartclk, baud * m_divisor);
>  
> +	spin_lock_irqsave(&mvebu_uart_lock, flags);

Hi Pali

You only need spin_lock_irqsave() if you plan on taking the spinlock
in an interrupt handler. It seems unlikely the baud rate will be
changed in interrupt context? Please check, and then swap to plain
spin_lock().

>  	brdv = readl(port->membase + UART_BRDV);
>  	brdv &= ~BRDV_BAUD_MASK;
>  	brdv |= d_divisor;
>  	writel(brdv, port->membase + UART_BRDV);
> +	spin_unlock_irqrestore(&mvebu_uart_lock, flags);
>  
>  	osamp = readl(port->membase + UART_OSAMP);
>  	osamp &= ~OSAMP_DIVISORS_MASK;

> +	/* Recalculate UART1 divisor so UART1 baudrate does not change */
> +	if (prev_clock_rate) {
> +		divisor = DIV_U64_ROUND_CLOSEST((u64)(val & BRDV_BAUD_MASK) *
> +						parent_clock_rate * prev_d1d2,
> +						prev_clock_rate * d1 * d2);
> +		if (divisor < 1)
> +			divisor = 1;
> +		else if (divisor > BRDV_BAUD_MAX)
> +			divisor = BRDV_BAUD_MAX;
> +		val = (val & ~BRDV_BAUD_MASK) | divisor;
> +	}

I don't see any range checks in the patch which verifies the requested
baud rate is actually possible. With code like this, it seems like the
baud rate change will be successful, but the actual baud rate will not
be what is requested.

> +	/* Recalculate UART2 divisor so UART2 baudrate does not change */
> +	if (prev_clock_rate) {
> +		val = readl(uart_clock_base->reg2);
> +		divisor = DIV_U64_ROUND_CLOSEST((u64)(val & BRDV_BAUD_MASK) *
> +						parent_clock_rate * prev_d1d2,
> +						prev_clock_rate * d1 * d2);
> +		if (divisor < 1)
> +			divisor = 1;
> +		else if (divisor > BRDV_BAUD_MAX)
> +			divisor = BRDV_BAUD_MAX;
> +		val = (val & ~BRDV_BAUD_MASK) | divisor;
> +		writel(val, uart_clock_base->reg2);

Here it looks like UART1 could request a baud rate change, which ends
up setting the clocks so that UART2 is out of range? Could the change
for UART1 be successful, but you end up breaking UART2? I'm thinking
when you are at opposite ends of the scale. UART2 is running at
110baud and UART1 at 230400baud.

	Andrew
