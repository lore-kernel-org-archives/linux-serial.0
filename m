From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] serial-uartlite: fix build warning
Date: Fri, 18 Mar 2016 13:32:35 -0700
Message-ID: <20160318203235.GA3560@kroah.com>
References: <20160318184856.c289c591@kerio.vanmierlo.com>
 <56EC54CC.90101@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <56EC54CC.90101@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Maarten Brock <m.brock@vanmierlo.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Peter Korsgaard <jacmet@sunsite.dk>, Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Fri, Mar 18, 2016 at 12:19:40PM -0700, Peter Hurley wrote:
> On 03/18/2016 10:48 AM, Maarten Brock wrote:
> > ----- Original Message -----
> > From: Geert Uytterhoeven [mailto:geert@linux-m68k.org]
> > To: Sudip Mukherjee [mailto:sudipm.mukherjee@gmail.com]
> > Cc: Peter Korsgaard [mailto:jacmet@sunsite.dk], Greg Kroah-Hartman =
[mailto:gregkh@linuxfoundation.org], Jiri Slaby [mailto:jslaby@suse.com=
], linux-kernel@vger.kernel.org [mailto:linux-kernel@vger.kernel.org], =
linux-serial@vger.kernel.org [mailto:linux-serial@vger.kernel.org]
> > Sent: Fri, 18 Mar 2016 13:48:06 +0100
> > Subject: Re: [PATCH] serial-uartlite: fix build warning
> >=20
> >=20
> >> On Thu, Mar 10, 2016 at 2:14 PM, Sudip Mukherjee
> >> <sudipm.mukherjee@gmail.com> wrote:
> >>> We were getting build warnings about:
> >>> drivers/tty/serial/uartlite.c: In function =E2=80=98ulite_request=
_port=E2=80=99:
> >>> drivers/tty/serial/uartlite.c:348:21: warning: assignment discard=
s
> >>>         'const' qualifier from pointer target type
> >>> port->private_data =3D &uartlite_be;
> >>>                      ^
> >>> drivers/tty/serial/uartlite.c:354:22: warning: assignment discard=
s
> >>>         'const' qualifier from pointer target type
> >>> port->private_data =3D &uartlite_le;
> >>>                       ^
> >>>
> >>> Fixes: 2905697a82ea ("serial-uartlite: Constify uartlite_be/uartl=
ite_le")
> >>> Signed-off-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
> >>
> >> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
> >>
> >> Gr{oetje,eeting}s,
> >>
> >>                         Geert
> >=20
> > Reverting is not the same as fixing.
>=20
> I agree; better to revert commit 2905697a82ea and let Maarten re-subm=
it
> a patch that doesn't generate build warnings.

I'll fix this up after 4.6-rc1 is out, thanks.

greg k-h
