From: "Han, Nandor (GE Healthcare)" <nandor.han@ge.com>
Subject: [PATCH 1/1] tty: serial: imx: disable ageing timer interrupt if dma
 in use
Date: Fri, 13 Oct 2017 14:47:12 +0000
Message-ID: <AM3P101MB01801D525028F3992D8E284AE6480@AM3P101MB0180.NAMP101.PROD.OUTLOOK.COM>
References: <20171007014648.6989-1-troy.kisky@boundarydevices.com>
 <AM3P101MB01800FAA2029393C5A859629E64A0@AM3P101MB0180.NAMP101.PROD.OUTLOOK.COM>
 <7c5a3ef3-6da7-815e-04a3-a1f18344032e@boundarydevices.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <7c5a3ef3-6da7-815e-04a3-a1f18344032e@boundarydevices.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Troy Kisky <troy.kisky@boundarydevices.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Cc: "fabio.estevam@nxp.com" <fabio.estevam@nxp.com>, "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "l.stach@pengutronix.de" <l.stach@pengutronix.de>
List-Id: linux-serial@vger.kernel.org



> -----Original Message-----
> From: Troy Kisky [mailto:troy.kisky@boundarydevices.com]
> Sent: 11 October 2017 19:10
> To: Han, Nandor (GE Healthcare) <nandor.han@ge.com>;
> gregkh@linuxfoundation.org
> Cc: fabio.estevam@nxp.com; l.stach@pengutronix.de; u.kleine-
> koenig@pengutronix.de; linux-serial@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org
> Subject: EXT: Re: [PATCH 1/1] tty: serial: imx: disable ageing timer interrupt if
> dma in use
> 
> On 10/10/2017 11:22 PM, Han, Nandor (GE Healthcare) wrote:

<snip>

> >> -			imx_rxint(irq, dev_id);
> >> +	if (!sport->dma_is_enabled && (sts & (USR1_RRDY |
> >> USR1_AGTIM))) {
> >> +		imx_rxint(irq, dev_id);
> >
> > I don't think we need the check `!sport->dma_is_enabled ` since RRDY and
> AGTIM interrupts should be disable when DMA is enabled.
> 
> If I AND the status with its corresponding interrupt enable. But that is just as
> complicated, and more different from the original.
> 
> 

Yes, I agree, but it would be the right thing to do. :) 

> >
> >>  		ret = IRQ_HANDLED;
> >>  	}
> >>
> >> @@ -1207,10 +1181,6 @@ static void imx_enable_dma(struct imx_port
> >> *sport)
> >>  	temp |= UCR1_RDMAEN | UCR1_TDMAEN | UCR1_ATDMAEN;
> >>  	writel(temp, sport->port.membase + UCR1);
> >>
> >> -	temp = readl(sport->port.membase + UCR2);
> >> -	temp |= UCR2_ATEN;
> >> -	writel(temp, sport->port.membase + UCR2);
> >> -
> >
> > I think this should be moved to imx_startup. At least RRDY is configured
> there.
> >
> 
> 
> Currently, non-dma mode does not use the ageing timer. You get an interrupt
> immediately when
> 1 character is in the fifo. So, enabling the ageing timer and changing fifo level,
> should really be a separate patch. But it would be a nice patch.
> 
> 

Ok but in this case, we are left with aging timer and rrdy check in the interrupt and imx-startup enables only rrdy. (which is not much different than what it was before, since aging timer didn't get a chance to be triggered)
I agree that changing the fifo level to give a chance also to the aging timer will be the right thing to do here.

Overall, I think is ok, my main concern with not enabling the aging timer in startup is that people can be confused about this.

Reviewed-by: Nandor Han <Nandor.han@ge.com>
