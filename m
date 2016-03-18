From: "Maarten Brock" <m.brock@vanmierlo.com>
Subject: Re: [PATCH] serial-uartlite: fix build warning
Date: Fri, 18 Mar 2016 18:48:56 +0100
Message-ID: <20160318184856.c289c591@kerio.vanmierlo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: Peter Korsgaard <jacmet@sunsite.dk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

----- Original Message -----
=46rom: Geert Uytterhoeven [mailto:geert@linux-m68k.org]
To: Sudip Mukherjee [mailto:sudipm.mukherjee@gmail.com]
Cc: Peter Korsgaard [mailto:jacmet@sunsite.dk], Greg Kroah-Hartman [mai=
lto:gregkh@linuxfoundation.org], Jiri Slaby [mailto:jslaby@suse.com], l=
inux-kernel@vger.kernel.org [mailto:linux-kernel@vger.kernel.org], linu=
x-serial@vger.kernel.org [mailto:linux-serial@vger.kernel.org]
Sent: Fri, 18 Mar 2016 13:48:06 +0100
Subject: Re: [PATCH] serial-uartlite: fix build warning


> On Thu, Mar 10, 2016 at 2:14 PM, Sudip Mukherjee
> <sudipm.mukherjee@gmail.com> wrote:
> > We were getting build warnings about:
> > drivers/tty/serial/uartlite.c: In function =E2=80=98ulite_request_p=
ort=E2=80=99:
> > drivers/tty/serial/uartlite.c:348:21: warning: assignment discards
> >         'const' qualifier from pointer target type
> > port->private_data =3D &uartlite_be;
> >                      ^
> > drivers/tty/serial/uartlite.c:354:22: warning: assignment discards
> >         'const' qualifier from pointer target type
> > port->private_data =3D &uartlite_le;
> >                       ^
> >
> > Fixes: 2905697a82ea ("serial-uartlite: Constify uartlite_be/uartlit=
e_le")
> > Signed-off-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
>=20
> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
>=20
> Gr{oetje,eeting}s,
>=20
>                         Geert

Reverting is not the same as fixing.

Rant:
It is a stupid warning IMHO, but being a compiler writer myself (SDCC) =
I
understand how it can arise. If you assign some const pointer to a void
pointer without an explicit cast gcc does not complain about the comple=
te
loss of type, but it does warn about losing constness. In general I'd s=
ay:
make up your mind; either warn about both or don't warn about either.

Maarten
