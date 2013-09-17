From: Tomasz Figa <t.figa@samsung.com>
Subject: Re: [PATCH] serial: samsung: add support for manual RTS setting
Date: Tue, 17 Sep 2013 17:21:46 +0200
Message-ID: <2486439.1yKjlWu5X1@amdc1227>
References: <1378894107-7904-1-git-send-email-jose.goncalves@inov.pt>
 <35383907.gKXZyKLrYq@amdc1227> <52385327.9020706@inov.pt>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <52385327.9020706@inov.pt>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: =?ISO-8859-1?Q?Jos=E9_Miguel_Gon=E7alves?= <jose.goncalves@inov.pt>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>, Sylwester Nawrocki <s.nawrocki@samsung.com>
List-Id: linux-serial@vger.kernel.org

[Ccing Greg and Sylwester]

On Tuesday 17 of September 2013 14:03:35 Jos=E9 Miguel Gon=E7alves wrot=
e:
> Hi Tomasz,
>=20
> On 17-09-2013 11:18, Tomasz Figa wrote:
> > Hi Jos=E9,
> >=20
> > Please see my comments below.
> >=20
> > On Wednesday 11 of September 2013 11:08:27 Jos=E9 Miguel Gon=E7alve=
s wrote:
> >> The Samsung serial driver currently does not support setting the
> >> RTS pin with an ioctl(TIOCMSET) call. This patch adds this support=
=2E
> >>=20
> >> Signed-off-by: Jos=E9 Miguel Gon=E7alves <jose.goncalves@inov.pt>
> >> ---
> >>=20
> >>   drivers/tty/serial/samsung.c |   17 ++++++++++++++---
> >>   1 file changed, 14 insertions(+), 3 deletions(-)
> >>=20
> >> diff --git a/drivers/tty/serial/samsung.c
> >> b/drivers/tty/serial/samsung.c
> >> index f3dfa19..e5dd808 100644
> >> --- a/drivers/tty/serial/samsung.c
> >> +++ b/drivers/tty/serial/samsung.c
> >> @@ -407,7 +407,14 @@ static unsigned int
> >> s3c24xx_serial_get_mctrl(struct
> >> uart_port *port)
> >>=20
> >>   static void s3c24xx_serial_set_mctrl(struct uart_port *port,
> >>   unsigned
> >>=20
> >> int mctrl) {
> >> -	/* todo - possibly remove AFC and do manual CTS */
> >> +	unsigned int umcon =3D rd_regl(port, S3C2410_UMCON);
> >> +
> >> +	if (mctrl & TIOCM_RTS)
> >> +		umcon |=3D S3C2410_UMCOM_RTS_LOW;
> >> +	else
> >> +		umcon &=3D ~S3C2410_UMCOM_RTS_LOW;
> >> +
> >> +	wr_regl(port, S3C2410_UMCON, umcon);
> >=20
> > I wonder if port capability shouldn't be considered here. Depending=
 on
> > SoC, only selected ports provide modem control capability.
> >=20
> > For example on S3C64xx only ports 0 and 1 support modem control, wh=
ile
> > ports 2 and 3 don't.
>=20
> Same for S3C2416. I also wondered that, but while I have information =
for
> all S3C24xx chips and for those a simple test ( port->line < 2) would
> validate this, I don't know about other SoCs this driver supports.
> Bearing this in mind and also that the current implementation of
> s3c24xx_serial_get_mctrl() does not check also for which port it
> applies, I opted for this solution.

See below.

> >>   }
> >>  =20
> >>   static void s3c24xx_serial_break_ctl(struct uart_port *port, int
> >>=20
> >> break_state) @@ -774,8 +781,6 @@ static void
> >> s3c24xx_serial_set_termios(struct uart_port *port, if
> >> (termios->c_cflag
> >> & CSTOPB)
> >>=20
> >>   		ulcon |=3D S3C2410_LCON_STOPB;
> >>=20
> >> -	umcon =3D (termios->c_cflag & CRTSCTS) ? S3C2410_UMCOM_AFC : 0;
> >> -
> >>=20
> >>   	if (termios->c_cflag & PARENB) {
> >>   =09
> >>   		if (termios->c_cflag & PARODD)
> >>   	=09
> >>   			ulcon |=3D S3C2410_LCON_PODD;
> >>=20
> >> @@ -792,6 +797,12 @@ static void s3c24xx_serial_set_termios(struct
> >> uart_port *port,
> >>=20
> >>   	wr_regl(port, S3C2410_ULCON, ulcon);
> >>   	wr_regl(port, S3C2410_UBRDIV, quot);
> >>=20
> >> +
> >> +	if (termios->c_cflag & CRTSCTS)
> >> +		umcon =3D S3C2410_UMCOM_AFC;
> >=20
> > Is it correct to override the last manual RTS value set to this
> > register
> > when activating manual flow control?
> >=20
> > Shouldn't the code be more like the following:
> > 	umcon =3D rd_regb(port, S3C2410_UMCON);
> > 	if (termios->c_cflag & CRTSCTS)
> > =09
> > 		umcon |=3D S3C2410_UMCOM_AFC;
> > =09
> > 	else
> > =09
> > 		umcon &=3D ~S3C2410_UMCOM_AFC;
> > =09
> > 	wr_regl(port, S3C2410_UMCON, umcon);
> >=20
> > Probably port capability should be considered here as well.
>=20
> Looking at the S3C24xx user manuals I've seen that if you set the
> automatic flow control (AFC) with the S3C2410_UMCOM_AFC mask, the UAR=
T
> controller ignores the manual RTS setting value with the
> S3C2410_UMCOM_RTS_LOW bitmask, so it is not necessary to do that. Als=
o,
> the upper bits of UMCON control the FIFO level to trigger the AFC and
> you should initialize these bits when using AFC (I've set these to 0 =
to
> use full FIFO, as it was previously).

I had the following scenario in mind:
1) enable CRTSCTS,
2) set RTS status using the IOCTL,
3) disable CRTSCTS,
4) do something,
5) enable CRTSCTS again.

I would expect that the value set in point 2 would be still valid after=
=20
point 5, while it will be reset.

> Regarding port capability, if it's decided to validate it in
> s3c24xx_serial_get_mctrl() and s3c24xx_serial_set_mctrl() it should a=
lso
> be validated here. The question is how to validate for the full spect=
rum
> of SoCs that this driver supports?

Hmm, since the driver is already broken in this aspect, ignoring this i=
n=20
your patch might be fine for now. A follow up patch fixing this would b=
e=20
welcome, though. However I don't have any good idea how to implement th=
is=20
at the moment.

=46irst thing that comes to my mind is using the variant data structure=
s to=20
store information about per port capability (different port FIFO sizes =
are=20
already handled like this), but this would imply splitting some of the=20
groups, as S5PC100 supports modem control for different subset of ports=
=20
than S3C64xx, while they both use the same variant data.

Using device tree, this could be passed as an extra property, but some =
of=20
the platforms using samsung serial driver can be booted without device=20
tree, so it wouldn't cover all the cases.

Best regards,
Tomasz

P.S. Please remember to add all the relevant people to Cc when sending=20
patches. You can use scripts/get_maintainer.pl to find them.
