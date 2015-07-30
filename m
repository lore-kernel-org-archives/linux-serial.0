From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH v1 1/2] dt: atmel-usart: document new I/O data register
 width property
Date: Thu, 30 Jul 2015 16:54:00 +0300
Message-ID: <1438264440.29746.125.camel@linux.intel.com>
References: <1438261591-13130-1-git-send-email-andriy.shevchenko@linux.intel.com>
	 <55BA2849.2050803@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <55BA2849.2050803-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Cyrille Pitchen <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, Hans-Christian Egtvedt <egtvedt-BrfabpQBY5qlHtIdYg32fQ@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

On Thu, 2015-07-30 at 15:36 +0200, Nicolas Ferre wrote:
> Le 30/07/2015 15:06, Andy Shevchenko a =C3=A9crit :
> > This change documents a new property for the Atmel serial device,=20
> > allowing an
> > implementer to specify either four bytes or one byte access to the=20
> > controller
> > data register.
> >=20
> > This supports a change that unbreaks this driver on ATNGW100 board.
> >=20
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> > ---
> >  Documentation/devicetree/bindings/serial/atmel-usart.txt | 2 ++
> >  1 file changed, 2 insertions(+)
> >=20
> > diff --git a/Documentation/devicetree/bindings/serial/atmel
> > -usart.txt b/Documentation/devicetree/bindings/serial/atmel
> > -usart.txt
> > index e6e6142..a8c290a7 100644
> > --- a/Documentation/devicetree/bindings/serial/atmel-usart.txt
> > +++ b/Documentation/devicetree/bindings/serial/atmel-usart.txt
> > @@ -6,6 +6,8 @@ Required properties:
> >    additional mode or an USART new feature.
> >    For the dbgu UART, use "atmel,<chip>-dbgu", "atmel,<chip>-usart"
> >  - reg: Should contain registers location and length
> > +- reg-io-width: The I/O register width (in bytes) implemented by
> > +  this device. Supported values are 1 or 4 (the default).
>=20
> Well, sorry but no.
> The proper way to implement this is to cling to certain compatible
> strings. But I'm pretty sure that this issue shall not be fixed like=20
> this.
>=20
> But I think that Cyrille is about to propose another version. Let's=20
> wait
> for his code...

Good, because I have really no time for this.
As I said earlier I can test whatever you propose. I'm not going to imp
rove my approach. Sorry.

>=20
> Bye,
>=20
>=20
> >  - interrupts: Should contain interrupt
> >  - clock-names: tuple listing input clock names.
> >  	Required elements: "usart"
> >=20
>=20
>=20

--=20
Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Intel Finland Oy
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
