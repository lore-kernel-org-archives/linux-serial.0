From: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Subject: Re: [PATCH] tty/serial: digicolor: Fix bad usage of IS_ERR_VALUE
Date: Thu, 11 Feb 2016 07:32:43 -0800
Message-ID: <20160211153243.GA3076@roeck-us.net>
References: <1455030539-10798-1-git-send-email-linux@roeck-us.net>
 <4571887.rTPndCnv20@wuerfel>
 <56BAA27A.9050605@roeck-us.net>
 <2606061.l722KO95iI@wuerfel>
 <56BC022B.7030004@roeck-us.net>
 <56BC2DF7.20803@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <kernel-testers-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <56BC2DF7.20803-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: kernel-testers-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andrzej Hajda <a.hajda-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, kernel-testers-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

On Thu, Feb 11, 2016 at 07:45:11AM +0100, Andrzej Hajda wrote:
> On 02/11/2016 04:38 AM, Guenter Roeck wrote:
> > On 02/10/2016 07:21 AM, Arnd Bergmann wrote:
> >> On Tuesday 09 February 2016 18:37:46 Guenter Roeck wrote:
> >>> On 02/09/2016 07:26 AM, Arnd Bergmann wrote:
> >>>> On Tuesday 09 February 2016 07:08:59 Guenter Roeck wrote:
> >>>>> IS_ERR_VALUE() assumes that its parameter is an unsigned long.
> >>>>> It can not be used to check if an unsigned int reflects an erro=
r.
> >>>>> Doing so can result in the following build warning.
> >>>>>
> >>>>> drivers/tty/serial/digicolor-usart.c: In function =E2=80=98digi=
color_uart_probe=E2=80=99:
> >>>>> include/linux/err.h:21:38: warning:
> >>>>>           comparison is always false due to limited range of da=
ta type
> >>>>> drivers/tty/serial/digicolor-usart.c:485:6: note:
> >>>>>           in expansion of macro =E2=80=98IS_ERR_VALUE=E2=80=99
> >>>>>
> >>>>> If that warning is seen, an error return from platform_get_irq(=
) is missed.
> >>>>>
> >>>>>
> >>>> The patch looks correct to me, but what compiler version and whi=
ch kernel
> >>>> tree is it that triggered the warning?
> >>>>
> >>>> Andrzej Hajda just modified the definition of IS_ERR_VALUE(), an=
d the
> >>>> changes are still under discussion, but I don't see that warning=
 with
> >>>> any of the versions.
> >>>>
> >>> I see it with gcc 5.1 and 5.2 (and W=3D1). I did not see / notice=
 Andrzej's patch.
> >>>
> >>> I agree that fixing the problem in IS_ERR_VALUE() is preferrable.
> >>>
> >>>
> >> Ah, W=3D1 explains it. We are still debating about the proper solu=
tion. Al Viro
> >> pointed out that most users of IS_ERR_VALUE() shouldn't be using i=
t at all,
> >> so your patch is probably best here after all.
> >>
> > Yes, after looking into it some more I agree. Coccinelle should be =
able to handle
> > most of the conversions automatically. I actually tried to write a =
script, just
> > for the fun of it, but it misses some of the problem cases in patch=
 mode.
> > Maybe I get it working tonight.
> >
> > Guenter
> >
>=20
> Maybe it can be helpful. The script which classifies all IS_ERR_VALUE
> usages as
> correct, signed, incorrect and unknown (cocci was not able to detect =
type).
> Adding patch mode should be quite simple.
>=20
> // Options: --all-includes --include
> include/uapi/linux/netfilter_ipv6/ip6_tables.h --include
> include/uapi/linux/netfilter_ipv4/ip_tables.h --include
> include/uapi/linux/netfilter_arp/arp_tables.h --include
> include/uapi/linux/netfilter/x_tables.h --include include/linux/mm_ty=
pes.h
>=20
> virtual context
> virtual report
>=20
> @r@
> typedef bool, u8, u16, u32, u64, s8, s16, s32, s64, __u64, dma_addr_t=
,
> Elf32_Addr, Elf64_Addr;
> {unsigned long, size_t} ev;
> {short, int, long, s16, s32, ssize_t} ew;
> {char, unsigned char, unsigned short, unsigned int, long long, unsign=
ed
> long long, bool, u8, u16, u32, u64, s64, __u64, dma_addr_t, Elf32_Add=
r,
> Elf64_Addr} ei;
> expression eu;
> position p;
> @@
>=20
> IS_ERR_VALUE(\(ev \| ew \| ei \| eu \))@p
>=20
> @script:python depends on report@
> p << r.p =3D [];
> ev << r.ev =3D "";
> ew << r.ew =3D "";
> ei << r.ei =3D "";
> eu << r.eu =3D "";

This doesn't work for me; it bails out at the assignments. If I remove
the assignments, it does not report anything.

Any idea what might be wrong ?

Thanks,
Guenter

> @@
>=20
> t =3D ""
> if ev: t =3D "correct"
> if ew: t =3D "signed"
> if ei: t =3D "incorrect"
> if eu: t =3D "unknown"
>=20
>=20
> e =3D ev + ew + ei + eu;
> if t:
>     msg =3D "WARNING: %s argument type in IS_ERR_VALUE(%s)" % (t, e)
>     coccilib.report.print_report(p[0], msg)
>=20
>=20
