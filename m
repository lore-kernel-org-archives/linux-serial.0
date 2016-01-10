From: Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>
Subject: Re: [PATCH V2 0/2] serial: bcm2835: add bcm2835 auxiliar uart
 driver
Date: Sun, 10 Jan 2016 22:17:25 +0100 (CET)
Message-ID: <1993851391.472790.ea76ff5f-f5e1-40e8-bbff-544f1cd5a3c3.open-xchange@email.1und1.de>
References: <1452344854-2576-1-git-send-email-kernel@martin.sperl.org>
 <1057226922.507844.cb24b396-67be-4b7b-9938-7cb30ef4fe05.open-xchange@email.1und1.de>
 <46FD7886-510C-4F0F-A039-500D5438207B@martin.sperl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <46FD7886-510C-4F0F-A039-500D5438207B-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Cc: linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org


> Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org> hat am 10. Januar 2016 um 16:4=
5
> geschrieben:
>
>
>
> > On 10.01.2016, at 16:05, Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org> wro=
te:
> >
> > Hi Martin,
> >
> >> kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org hat am 9. Januar 2016 um 14:07 geschrieben=
:
> >>
> >>
> >> From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
> >>
> >> This patch series adds the bcm2835aux uart driver, which is create=
d
> >> as a wrapper arround the 8250 driver (based on recommendations by
> >> Stephen Warren)
> >>
> >> The device tree patch itself is not included yet because this
> >> patch requires the clk-bcm2835aux driver, which is right now only
> >> in clk-next, but should become available with 4.5.
> >
> > it doesn't make sense without the device tree patch. IMHO it's okay=
 as long
> > as
> > you point out the dependency and set the node status to disable.
>
> I agree in principle, but it is the same as with the spi-bcm2835aux d=
river,
> where I had provided a patch to the dt, that still has not been appli=
ed
> yet, but with the driver itself already in the kernel.

Please provide a new version, because it won't apply anymore. It increa=
se the
chance of more testing.

>
> Also the reorganisation of the dt to support the bcm2836 makes this
> another moving target.
>
> The other concern is that we would need to use defines included
> from "dt-bindings/clock/bcm2835aux.h=E2=80=9D and without those the d=
t will not
> work.

AFAIK there has been a discussion about such a problem.

>
> For the record: this is what would be required:
> uart1: uart@7e215040 {
> compatible =3D "brcm,bcm2835-aux-uart";
> reg =3D <0x7e215040 0x40>;
> interrupts =3D <1 29>;
> clocks =3D <&aux BCM2835_AUX_CLOCK_UART>;
> status =3D "disabled";
> };
>
> I can respin the whole patchset to include this as well if you tell m=
e to.

I think we should wait for a rpi maintainer's response about that. No n=
eed to
hurry.

>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
