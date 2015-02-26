From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: Re: [PATCH 4/8] pwm: atmel-hlcdc: fix struct clk pointer comparing
Date: Thu, 26 Feb 2015 10:31:28 +0100
Message-ID: <20150226103128.0b120742@bbrezillon>
References: <1424876018-17852-1-git-send-email-shawn.guo@linaro.org>
	<1424876018-17852-5-git-send-email-shawn.guo@linaro.org>
	<54EEE5EA.6000902@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pwm-owner@vger.kernel.org>
In-Reply-To: <54EEE5EA.6000902@atmel.com>
Sender: linux-pwm-owner@vger.kernel.org
To: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Shawn Guo <shawn.guo@linaro.org>, Mike Turquette <mturquette@linaro.org>, linux-pwm@vger.kernel.org, alsa-devel@alsa-project.org, Russell King <linux@arm.linux.org.uk>, linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Brown <broonie@kernel.org>, Stephen Boyd <sboyd@codeaurora.org>, dri-devel@lists.freedesktop.org, Thierry Reding <thierry.reding@gmail.com>, kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

Nicolas, Shawn,

On Thu, 26 Feb 2015 10:22:50 +0100
Nicolas Ferre <nicolas.ferre@atmel.com> wrote:

> Le 25/02/2015 15:53, Shawn Guo a =C3=A9crit :
> > Since commit 035a61c314eb ("clk: Make clk API return per-user struc=
t clk
> > instances"), clk API users can no longer check if two struct clk
> > pointers are pointing to the same hardware clock, i.e. struct clk_h=
w, by
> > simply comparing two pointers.  That's because with the per-user cl=
k
> > change, a brand new struct clk is created whenever clients try to l=
ook
> > up the clock by calling clk_get() or sister functions like clk_get_=
sys()
> > and of_clk_get().  This changes the original behavior where the str=
uct
> > clk is only created for once when clock driver registers the clock =
to
> > CCF in the first place.  The net change here is before commit
> > 035a61c314eb the struct clk pointer is unique for given hardware
> > clock, while after the commit the pointers returned by clk lookup c=
alls
> > become different for the same hardware clock.
> >=20
> > That said, the struct clk pointer comparing in the code doesn't wor=
k any
> > more.  Call helper function clk_is_match() instead to fix the probl=
em.
> >=20
> > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
>=20
> I agree with the fix whichever name is chosen for the function in an
> future version of this series. So you can add my:
> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
>=20
> Maybe Boris can double check...

Looks good to me.
Thanks for fixing that.

Acked-by: Boris Brezillon <boris.brezillon@free-electrons.com>

>=20
> > ---
> >  drivers/pwm/pwm-atmel-hlcdc.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/pwm/pwm-atmel-hlcdc.c b/drivers/pwm/pwm-atmel-=
hlcdc.c
> > index 522f7075bb1a..36475949b829 100644
> > --- a/drivers/pwm/pwm-atmel-hlcdc.c
> > +++ b/drivers/pwm/pwm-atmel-hlcdc.c
> > @@ -97,7 +97,7 @@ static int atmel_hlcdc_pwm_config(struct pwm_chip=
 *c,
> > =20
> >  	pwmcfg =3D ATMEL_HLCDC_PWMPS(pres);
> > =20
> > -	if (new_clk !=3D chip->cur_clk) {
> > +	if (!clk_is_match(new_clk, chip->cur_clk)) {
> >  		u32 gencfg =3D 0;
> >  		int ret;
> > =20
> >=20
>=20
>=20



--=20
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
