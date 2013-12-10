From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: Re: [PATCH v2] serial: 8250_dw: Improve unwritable LCR workaround
Date: Tue, 10 Dec 2013 09:11:55 -0300
Message-ID: <20131210121154.GA16238@localhost>
References: <1380647888-32473-1-git-send-email-tim.kryger@linaro.org>
 <5548535.pYirbknue4@radagast>
 <CAAYSxhpR664Od7AaWZrX0rE=iDUHo0h+4=uY=gvkFps4Hz4aew@mail.gmail.com>
 <3010367.6CxxZ6Dpea@radagast>
 <CAAYSxhraDF6T9URw0CpEig2VpnuTBNdZYL9uuw6vdPn0=X4zGA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:41464 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750748Ab3LJMLr (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 10 Dec 2013 07:11:47 -0500
Content-Disposition: inline
In-Reply-To: <CAAYSxhraDF6T9URw0CpEig2VpnuTBNdZYL9uuw6vdPn0=X4zGA@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Tim Kryger <tim.kryger@linaro.org>
Cc: James Hogan <james.hogan@imgtec.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, linux-serial@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Patch Tracking <patches@linaro.org>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Gregory Clement <gregory.clement@free-electrons.com>, Lior Amsalem <alior@marvell.com>, Jason Cooper <jason@lakedaemon.net>, ARM Kernel List <linux-arm-kernel@lists.infradead.org>

Hi Tim, James:

On Mon, Dec 09, 2013 at 04:42:23PM -0800, Tim Kryger wrote:
> On Fri, Dec 6, 2013 at 4:59 PM, James Hogan <james.hogan@imgtec.com> =
wrote:
>=20
[..]
> diff --git a/drivers/tty/serial/8250/8250_dw.c
> b/drivers/tty/serial/8250/8250_dw.c
> index 4658e3e..5f096c7 100644
> --- a/drivers/tty/serial/8250/8250_dw.c
> +++ b/drivers/tty/serial/8250/8250_dw.c
> @@ -96,7 +96,8 @@ static void dw8250_serial_out(struct uart_port *p,
> int offset, int value)
>         if (offset =3D=3D UART_LCR) {
>                 int tries =3D 1000;
>                 while (tries--) {
> -                       if (value =3D=3D p->serial_in(p, UART_LCR))
> +                       unsigned int lcr =3D p->serial_in(p, UART_LCR=
);
> +                       if ((value & ~UART_LCR_SPAR) =3D=3D (lcr & ~U=
ART_LCR_SPAR))
>                                 return;
>                         dw8250_force_idle(p);
>                         writeb(value, p->membase + (UART_LCR << p->re=
gshift));
> @@ -132,7 +133,8 @@ static void dw8250_serial_out32(struct uart_port
> *p, int offset, int value)
>         if (offset =3D=3D UART_LCR) {
>                 int tries =3D 1000;
>                 while (tries--) {
> -                       if (value =3D=3D p->serial_in(p, UART_LCR))
> +                       unsigned int lcr =3D p->serial_in(p, UART_LCR=
);
> +                       if ((value & ~UART_LCR_SPAR) =3D=3D (lcr & ~U=
ART_LCR_SPAR))
>                                 return;
>                         dw8250_force_idle(p);
>                         writel(value, p->membase + (UART_LCR << p->re=
gshift));
>=20
>=20
> Would you mind posting this for proper review so we can get the fix i=
n?
>=20

Applying this change fixes all the problems I reported (just did a quic=
k test on
the board I have currently on my desk).

Nice work!
--=20
Ezequiel Garc=C3=ADa, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
