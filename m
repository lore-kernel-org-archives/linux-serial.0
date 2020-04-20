Return-Path: <SRS0=2nXW=6E=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D947EC3815B
	for <linux-serial@archiver.kernel.org>; Mon, 20 Apr 2020 17:51:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B227420CC7
	for <linux-serial@archiver.kernel.org>; Mon, 20 Apr 2020 17:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587405106;
	bh=7gOwHMf33I6TNw+S4FLqcaoxWx3bzdvNBzFd0fQUG90=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=hV3qZrbtAnwAiwrvxt/5+cht9VX7R1qZWBL+LG41tqd6+TJ4ZuDfoR7JMVNCIO/tN
	 VVj2nvfzOaTDVUDFW3YCqgO6zi+qxJCfW/8XdZUz9R4SEwuJLeNsToV5jpEZqYhJDj
	 8Ud+sn9Dj4hqUAURZuOwJNeMFZcCxOeVVk6Erz5w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726457AbgDTRvq (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 20 Apr 2020 13:51:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:60650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725784AbgDTRvq (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 20 Apr 2020 13:51:46 -0400
Received: from Mani-XPS-13-9360 (unknown [157.46.94.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2F78220B1F;
        Mon, 20 Apr 2020 17:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587405105;
        bh=7gOwHMf33I6TNw+S4FLqcaoxWx3bzdvNBzFd0fQUG90=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Fj5fEoiYs58Pu1MBZ8wiyZQCnjuuwVb01vstg2M9wgJV+RCKvH5UDUuNFi5tMnk3D
         KxxH0CFMd1RH6BOWG5wn+zkBcqrnkDGSN4lvDhuNqwIR2vXtWklzj/PToefHP2IrJo
         zytu2wFg1Rlgnc6dxTBpguf/6b8vaoPAzf7pnWyo=
Date:   Mon, 20 Apr 2020 23:21:32 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Fabrice Gasnier <fabrice.gasnier@st.com>
Cc:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        andy.shevchenko@gmail.com, Erwan LE RAY <erwan.leray@st.com>
Subject: Re: [PATCH v2 1/2] tty: serial: Add modem control gpio support for
 STM32 UART
Message-ID: <20200420175132.GA22068@Mani-XPS-13-9360>
References: <20200416175729.5550-1-mani@kernel.org>
 <20200416175729.5550-2-mani@kernel.org>
 <4d6d6568-aee0-be02-df88-14f4e364b598@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d6d6568-aee0-be02-df88-14f4e364b598@st.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi,

On Fri, Apr 17, 2020 at 03:15:07PM +0200, Fabrice Gasnier wrote:
> On 4/16/20 7:57 PM, mani@kernel.org wrote:
> > From: Manivannan Sadhasivam <mani@kernel.org>
> > 
> > STM32 UART controllers have the built in modem control support using
> > dedicated gpios which can be enabled using 'st,hw-flow-ctrl' flag in DT.
> > But there might be cases where the board design need to use different
> > gpios for modem control.
> > 
> > For supporting such cases, this commit adds modem control gpio support
> > to STM32 UART controller using mctrl_gpio driver.
> > 
> > Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
> > ---
> >  drivers/tty/serial/Kconfig       |  1 +
> >  drivers/tty/serial/stm32-usart.c | 43 +++++++++++++++++++++++++++++++-
> >  drivers/tty/serial/stm32-usart.h |  1 +
> >  3 files changed, 44 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> > index 0aea76cd67ff..e7a6f2130684 100644
> > --- a/drivers/tty/serial/Kconfig
> > +++ b/drivers/tty/serial/Kconfig
> > @@ -1462,6 +1462,7 @@ config SERIAL_STM32
> >  	tristate "STMicroelectronics STM32 serial port support"
> >  	select SERIAL_CORE
> >  	depends on ARCH_STM32 || COMPILE_TEST
> > +	select SERIAL_MCTRL_GPIO if GPIOLIB
> >  	help
> >  	  This driver is for the on-chip Serial Controller on
> >  	  STMicroelectronics STM32 MCUs.
> > diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
> > index 5e93e8d40f59..026982259714 100644
> > --- a/drivers/tty/serial/stm32-usart.c
> > +++ b/drivers/tty/serial/stm32-usart.c
> > @@ -31,6 +31,7 @@
> >  #include <linux/tty_flip.h>
> >  #include <linux/tty.h>
> >  
> > +#include "serial_mctrl_gpio.h"
> >  #include "stm32-usart.h"
> >  
> >  static void stm32_stop_tx(struct uart_port *port);
> > @@ -510,12 +511,29 @@ static void stm32_set_mctrl(struct uart_port *port, unsigned int mctrl)
> >  		stm32_set_bits(port, ofs->cr3, USART_CR3_RTSE);
> >  	else
> >  		stm32_clr_bits(port, ofs->cr3, USART_CR3_RTSE);
> > +
> > +	mctrl_gpio_set(stm32_port->gpios, mctrl);
> >  }
> >  
> >  static unsigned int stm32_get_mctrl(struct uart_port *port)
> >  {
> > +	struct stm32_port *stm32_port = to_stm32_port(port);
> > +	int ret;
> 
> Hi Mani,
> 
> Please find few minor remarks and a question from my side.
> 
> 'ret' could be an unsigned int
>

Ok
 
> > +
> >  	/* This routine is used to get signals of: DCD, DSR, RI, and CTS */
> > -	return TIOCM_CAR | TIOCM_DSR | TIOCM_CTS;
> > +	ret = TIOCM_CAR | TIOCM_DSR | TIOCM_CTS;
> > +
> > +	return mctrl_gpio_get(stm32_port->gpios, &ret);
> > +}
> > +
> > +static void stm32_enable_ms(struct uart_port *port)
> > +{
> 
> Just a question here: purpose of your patch is to handle the gpio case.
> So you may get modem control interrupts from gpios with this patch.
> 

We will only get CTS gpio interrupt which will get handled by mctrl_gpio driver.

> In other drivers, I can see the implementation checks gpio usage (like
> in atmel_serial). When there's no gpio, the corresponding interrupt at
> the serial controller level is enabled, e.g. :
> 
> 	if (!mctrl_gpio_to_gpiod(atmel_port->gpios, UART_GPIO_CTS))
> 		ier |= ...
> 

Those drivers support both gpio and hardware modem control interrupts, so
they are checking to make sure either one of them is enabled at a time. But
on STM32 UART, modem interrupts are not enabled (USART_CR3_CTSIE etc...)

> Do you need modem control interrupts in your case ?
> 

Nope. Since modem control interrupts in UART block are not enabled currently,
I don't bother about it.

> In case the Stinger96 board signals gets fixed in a future revision,
> would it be needed to enable modem control interrupts in the USART
> controller ?
> 

I don't think so. The current driver supports hardware flow control without
using interrupts, so we are fine.

> > +	mctrl_gpio_enable_ms(to_stm32_port(port)->gpios);
> > +}
> > +
> > +static void stm32_disable_ms(struct uart_port *port)
> > +{
> > +	mctrl_gpio_disable_ms(to_stm32_port(port)->gpios);
> >  }
> >  
> >  /* Transmit stop */
> > @@ -626,6 +644,9 @@ static void stm32_shutdown(struct uart_port *port)
> >  	u32 val, isr;
> >  	int ret;
> >  
> > +	/* Disable modem control interrupts */
> > +	stm32_disable_ms(port);
> > +
> >  	val = USART_CR1_TXEIE | USART_CR1_TE;
> >  	val |= stm32_port->cr1_irq | USART_CR1_RE;
> >  	val |= BIT(cfg->uart_enable_bit);
> > @@ -764,6 +785,12 @@ static void stm32_set_termios(struct uart_port *port, struct ktermios *termios,
> >  		cr3 |= USART_CR3_CTSE | USART_CR3_RTSE;
> >  	}
> >  
> > +	/* Handle modem control interrupts */
> > +	if (UART_ENABLE_MS(port, termios->c_cflag))
> > +		stm32_enable_ms(port);
> > +	else
> > +		stm32_disable_ms(port);
> > +
> >  	usartdiv = DIV_ROUND_CLOSEST(port->uartclk, baud);
> >  
> >  	/*
> > @@ -898,6 +925,7 @@ static const struct uart_ops stm32_uart_ops = {
> >  	.throttle	= stm32_throttle,
> >  	.unthrottle	= stm32_unthrottle,
> >  	.stop_rx	= stm32_stop_rx,
> > +	.enable_ms	= stm32_enable_ms,
> >  	.break_ctl	= stm32_break_ctl,
> >  	.startup	= stm32_startup,
> >  	.shutdown	= stm32_shutdown,
> > @@ -964,6 +992,19 @@ static int stm32_init_port(struct stm32_port *stm32port,
> >  		ret = -EINVAL;
> 
> return -EINVAL;
> 
> >  	}
> >  
> > +	stm32port->gpios = mctrl_gpio_init(&stm32port->port, 0);
> > +	if (IS_ERR(stm32port->gpios))
> 
> Please add error path: add a clk_disable_unprepare() here, before the
> return.
> 

Ok.

Thanks,
Mani

> > +		return PTR_ERR(stm32port->gpios);
> > +
> > +	/* Both CTS/RTS gpios and "st,hw-flow-ctrl" should not be specified */
> > +	if (stm32port->hw_flow_control) {
> > +		if (mctrl_gpio_to_gpiod(stm32port->gpios, UART_GPIO_CTS) ||
> > +		    mctrl_gpio_to_gpiod(stm32port->gpios, UART_GPIO_RTS)) {
> > +			dev_err(&pdev->dev, "Conflicting RTS/CTS config\n");
> 
> same here
> 
> Best Regards,
> Thanks,
> Fabrice
> 
> > +			return -EINVAL;
> > +		}
> > +	}
> > +
> >  	return ret;
> >  }
> >  
> > diff --git a/drivers/tty/serial/stm32-usart.h b/drivers/tty/serial/stm32-usart.h
> > index db8bf0d4982d..d4c916e78d40 100644
> > --- a/drivers/tty/serial/stm32-usart.h
> > +++ b/drivers/tty/serial/stm32-usart.h
> > @@ -274,6 +274,7 @@ struct stm32_port {
> >  	bool fifoen;
> >  	int wakeirq;
> >  	int rdr_mask;		/* receive data register mask */
> > +	struct mctrl_gpios *gpios; /* modem control gpios */
> >  };
> >  
> >  static struct stm32_port stm32_ports[STM32_MAX_PORTS];
> > 
