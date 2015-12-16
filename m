From: Sergei Ianovich <ynvich-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v5] serial: support for 16550A serial ports on LP-8x4x
Date: Wed, 16 Dec 2015 11:04:57 +0300
Message-ID: <1450253097.21989.78.camel@gmail.com>
References: <1397668667-27328-1-git-send-email-ynvich@gmail.com>
	 <1450213494-21884-1-git-send-email-ynvich@gmail.com>
	 <1970812.j9fZPC5F1b@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1970812.j9fZPC5F1b@wuerfel>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Alan Cox <gnomes-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, Heikki Krogerus <heikki.krogerus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Scott Wood <scottwood-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Masahiro Yamada <yamada.masahiro-uWyLwvC0a2jby3iVrkZq2A@public.gmane.org>, Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Paul Burton <paul.burton-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, Joachim Eastwood <manabian-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mans Rullgard <mans-2StjZFpD7GcAvxtiuMwx3w@public.gmane.org>, Paul Gortmaker <paul.gortmaker-CWA4WttNNZF54TAoqtyWWQ@public.gmane.org>, Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>open list:
List-Id: linux-serial@vger.kernel.org

On Tue, 2015-12-15 at 22:51 +0100, Arnd Bergmann wrote:
> On Wednesday 16 December 2015 00:04:45 Sergei Ianovich wrote:
> > index 0000000..5f9a4c1
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/serial/lp8x4x-serial.txt
> > @@ -0,0 +1,35 @@
> > +UART ports on ICP DAS LP-8x4x
> > +
> > +ICP DAS LP-8x4x contains three additional serial ports interfaced
> > via
> > +Analog Devices ADM213EA chips in addition to 3 serial ports on PXA
> > CPU.
> > +
> > +Required properties:
> > +- compatible : should be "icpdas,uart-lp8x4x"
>=20
> Compatible strings should not include a 'x' wildcard like this, bette=
r
> use
> the specific chip name.
>=20
> Also, it sounds like you named them after the board vendor, which
> sounds
> wrong as the vendor part of the compatible string should be the
> whoever
> made that part (analog?)

The chips themselves are standard, they would work with 8250_core if
properly connected. However, they are not connected normally. Al least
some of their config pins are wired to a different address region. So
the driver is board-specific.

'x' wildcards in the name of the board seem important. There are device=
s
made by the same vendor without 8 or 4 in their name. Those devices
either are not shipped with linux or are base on a x86 platform.

Does this justify the choice of the compatible string?

> > +- reg : should provide 16 byte man IO memory region and 1 byte
> > region for
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0termios
> > +
> > +- interrupts : should provide interrupt
> > +
> > +- interrupt-parent : should provide a link to interrupt controller
> > either
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0explicitly or imp=
licitly from a parent node
>=20
> interrupt-parent should be an optional property, or you can leave it
> out,
> as this is a standard property that can always be there when there is=
=20
> interrupts.

ok

> > +Examples (from pxa27x-lp8x4x.dts):
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0uart@9050 {
>=20
> By convention, the name should be 'serial', not 'uart'.

ok
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
