From: Huang Shijie <b32955@freescale.com>
Subject: Re: [PATCH 2/5] serial: imx: add DMA support for imx6
Date: Wed, 3 Jul 2013 13:20:20 +0800
Message-ID: <51D3B494.3090700@freescale.com>
References: <1372746628-20092-1-git-send-email-b32955@freescale.com> <1372746628-20092-3-git-send-email-b32955@freescale.com> <20130703033837.GE9145@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from co9ehsobe001.messaging.microsoft.com ([207.46.163.24]:37709
	"EHLO co9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751193Ab3GCFQi convert rfc822-to-8bit
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 3 Jul 2013 01:16:38 -0400
In-Reply-To: <20130703033837.GE9145@S2101-09.ap.freescale.net>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: gregkh@linuxfoundation.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, s.hauer@pengutronix.de

=E4=BA=8E 2013=E5=B9=B407=E6=9C=8803=E6=97=A5 11:38, Shawn Guo =E5=86=99=
=E9=81=93:
>> static void imx_enable_dma(struct imx_port *sport)
>> >  +{
>> >  +	unsigned long temp;
>> >  +	struct tty_port *port =3D&sport->port.state->port;
>> >  +
>> >  +	port->low_latency =3D 1;
>> >  +	INIT_WORK(&sport->tsk_dma_tx, dma_tx_work);
>> >  +	INIT_WORK(&sport->tsk_dma_rx, dma_rx_work);
>> >  +	init_waitqueue_head(&sport->dma_wait);
> I had a hard time to understand why these work and wait queue are
> necessarily needed here.
Blame it on the sdma driver.

=46or example, we receive some data in the RXFIFO, normally , the=20
interrupt handler will
arise a DMA to fetch the data. We will call the=20
dmaengine_prep_slave_sg() to prepare for the DMA,
but sdma will call:
->sdma_prep_slave_sg() -->sdma_load_context() --> sdma_run_channel0()

the sdma_run_channel0() will poll for 500us(we have found the 500us is=20
not long enough in some case),
that's why i use the work queue:
We should not delay such long in interrupt context.

The same reason for TX.
> I haven't totally understand it.  But it looks like to me that the
> implementation might be complexer than it needs to be.  Can you pleas=
e
> take a look at serial-tegra.c to see how the DMA is supported there?
serial-tegra.c arises the dma in the interrupt context. maybe its=20
dmaengine is better then the imx-sdma.
> It looks much neater than the changes we have here.
>
>> >  +
>> >  +	/* set UCR1 */
>> >  +	temp =3D readl(sport->port.membase + UCR1);
>> >  +	temp |=3D UCR1_RDMAEN | UCR1_TDMAEN | UCR1_ATDMAEN |
>> >  +		/* wait for 4 idle frames and enable AGING Timer */
>> >  +		UCR1_ICD_REG(0);
>> >  +	writel(temp, sport->port.membase + UCR1);
>> >  +
>> >  +	/* set UCR4 */
>> >  +	temp =3D readl(sport->port.membase + UCR4);
>> >  +	temp |=3D UCR4_IDDMAEN;
>> >  +	writel(temp, sport->port.membase + UCR4);
>> >  +}
>> >  +
>> >  +static void imx_disable_dma(struct imx_port *sport)
>> >  +{
>> >  +	unsigned long temp;
>> >  +	struct tty_port *port =3D&sport->port.state->port;
>> >  +
>> >  +	/* clear UCR1 */
>> >  +	temp =3D readl(sport->port.membase + UCR1);
>> >  +	temp&=3D ~(UCR1_RDMAEN | UCR1_TDMAEN | UCR1_ATDMAEN);
>> >  +	writel(temp, sport->port.membase + UCR1);
>> >  +
>> >  +	/* clear UCR2 */
>> >  +	temp =3D readl(sport->port.membase + UCR2);
>> >  +	temp&=3D ~(UCR2_CTSC | UCR2_CTS);
>> >  +	writel(temp, sport->port.membase + UCR2);
>> >  +
>> >  +	/* clear UCR4 */
>> >  +	temp =3D readl(sport->port.membase + UCR4);
>> >  +	temp&=3D ~UCR4_IDDMAEN;
>> >  +	writel(temp, sport->port.membase + UCR4);
>> >  +
>> >  +	sport->dma_is_enabled =3D 0;
>> >  +	sport->dma_is_inited =3D 0;
> Shouldn't dma_is_inited be reset in imx_uart_dma_exit() for better?
yes. it's ok to set there.
> (I haven't looked at the necessity of these flags.  But please save
> the use of them if we can.)
>
>> >  +
>> >  +	port->low_latency =3D 0;
>> >  +}
>> >  +
>> >    /* half the RX buffer size */
>> >    #define CTSTL 16
>> > =20
>> >  @@ -870,6 +1250,14 @@ static void imx_shutdown(struct uart_port *=
port)
>> >    	unsigned long temp;
>> >    	unsigned long flags;
>> > =20
>> >  +	if (sport->dma_is_enabled) {
>> >  +		/* We have to wait for the DMA to finish. */
>> >  +		wait_event(sport->dma_wait,
>> >  +			!sport->dma_is_rxing&&  !sport->dma_is_txing);
>> >  +		imx_stop_rx(port);
>> >  +		imx_uart_dma_exit(sport);
>> >  +	}
>> >  +
>> >    	spin_lock_irqsave(&sport->port.lock, flags);
>> >    	temp =3D readl(sport->port.membase + UCR2);
>> >    	temp&=3D ~(UCR2_TXEN);
>> >  @@ -910,6 +1298,10 @@ static void imx_shutdown(struct uart_port *=
port)
>> >    		temp&=3D ~(UCR1_IREN);
>> > =20
>> >    	writel(temp, sport->port.membase + UCR1);
>> >  +
>> >  +	if (sport->dma_is_enabled)
>> >  +		imx_disable_dma(sport);
>> >  +
> Shouldn't imx_disable_dma() be called before imx_uart_dma_exit()
> logically?
>
i think it's ok.
I have forgotten why i puted it there. The dma support patch is kept in=
=20
my hand for a long time....

I will try to put the imx_disable_dma() in the imx_uart_dma_exit().
>> >    	spin_unlock_irqrestore(&sport->port.lock, flags);
>> > =20
>> >    	clk_disable_unprepare(sport->clk_per);
>> >  @@ -956,6 +1348,13 @@ imx_set_termios(struct uart_port *port, str=
uct ktermios *termios,
>> >    		if (sport->have_rtscts) {
>> >    			ucr2&=3D ~UCR2_IRTS;
>> >    			ucr2 |=3D UCR2_CTSC;
>> >  +
>> >  +			/* Can we enable the DMA support? */
>> >  +			if (is_imx6_uart(sport)&&  !uart_console(port)
>> >  +				&&  !sport->dma_is_inited) {
>> >  +				if (!imx_uart_dma_init(sport))
>> >  +					sport->dma_is_inited =3D 1;
> I think the setting of the flag can just be handled inside
> imx_uart_dma_init().
>
ok.
>> >  +			}
>> >    		} else {
>> >    			termios->c_cflag&=3D ~CRTSCTS;
>> >    		}
>> >  @@ -1069,6 +1468,10 @@ imx_set_termios(struct uart_port *port, st=
ruct ktermios *termios,
>> >    	if (UART_ENABLE_MS(&sport->port, termios->c_cflag))
>> >    		imx_enable_ms(&sport->port);
>> > =20
>> >  +	if (sport->dma_is_inited&&  !sport->dma_is_enabled) {
>> >  +		imx_enable_dma(sport);
>> >  +		sport->dma_is_enabled =3D 1;
> Ditto
>
>> >  +	}
> I see imx_disable_dma() and imx_uart_dma_exit() are called in
> imx_shutdown().  Why can not imx_uart_dma_init() and imx_enable_dma()
> be called in imx_startup()?
i intend to binding the DMA with the RTS/CTS together.

The setting of rts/cts is not in imx_startup(), but in the=20
imx_set_termios().




thanks
Huang Shijie



--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
