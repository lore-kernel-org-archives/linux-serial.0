From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH v5 7/7] dt-bindings: serial: document rs485 bindings for
 various devices
Date: Wed, 13 Sep 2017 11:54:28 +0200
Message-ID: <20170913095428.xryd526xjyuiecab@pengutronix.de>
References: <20170913081833.2740-1-u.kleine-koenig@pengutronix.de>
 <20170913081833.2740-8-u.kleine-koenig@pengutronix.de>
 <f0f3971d-3166-ee28-7978-a958f7b7835e@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <f0f3971d-3166-ee28-7978-a958f7b7835e-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ian Arkver <ian.arkver.dev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

On Wed, Sep 13, 2017 at 10:52:30AM +0100, Ian Arkver wrote:
> On 13/09/17 09:18, Uwe Kleine-König wrote:
> > Atmel USART, Freescale UARTs and OMAP UART all support the rs485 binding
> > described in rs485.txt, this commit just makes that explicit.
> > 
> > Acked-by: Nicolas Ferre <nicolas.ferre-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
> > Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> > Signed-off-by: Uwe Kleine-König <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> > ---
> >   Documentation/devicetree/bindings/serial/atmel-usart.txt  | 1 +
> >   Documentation/devicetree/bindings/serial/fsl-imx-uart.txt | 1 +
> >   Documentation/devicetree/bindings/serial/fsl-lpuart.txt   | 1 +
> >   Documentation/devicetree/bindings/serial/omap_serial.txt  | 1 +
> >   4 files changed, 4 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/serial/atmel-usart.txt b/Documentation/devicetree/bindings/serial/atmel-usart.txt
> > index e6e6142e33ac..7c0d6b2f53e4 100644
> > --- a/Documentation/devicetree/bindings/serial/atmel-usart.txt
> > +++ b/Documentation/devicetree/bindings/serial/atmel-usart.txt
> > @@ -24,6 +24,7 @@ Optional properties:
> >   	- dma-names: "rx" for RX channel, "tx" for TX channel.
> >   - atmel,fifo-size: maximum number of data the RX and TX FIFOs can store for FIFO
> >     capable USARTs.
> > +- rs485-rts-delay, rs485-rx-during-tx, linux,rs485-enabled-at-boot-time: see rs485.txt
> >   <chip> compatible description:
> >   - at91rm9200:  legacy USART support
> > diff --git a/Documentation/devicetree/bindings/serial/fsl-imx-uart.txt b/Documentation/devicetree/bindings/serial/fsl-imx-uart.txt
> > index 574c3a2c77d5..860a9559839a 100644
> > --- a/Documentation/devicetree/bindings/serial/fsl-imx-uart.txt
> > +++ b/Documentation/devicetree/bindings/serial/fsl-imx-uart.txt
> > @@ -9,6 +9,7 @@ Optional properties:
> >   - fsl,irda-mode : Indicate the uart supports irda mode
> >   - fsl,dte-mode : Indicate the uart works in DTE mode. The uart works
> >                     in DCE mode by default.
> > +- rs485-rts-delay, rs485-rx-during-tx, linux,rs485-enabled-at-boot-time: see rs485.txt
> 
> imx.c ignores the values in delay_rts_before_send and delay_rts_after_send,
> so maybe we shouldn't mention rs485-rts-delay here?

I have a patch here fixing that. Hmm, even without this implemented it
is IMHO fine to document it here.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
