From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] clk: provide clk_is_match() dummy for non-common clk
Date: Wed, 11 Mar 2015 12:29:05 +0000
Message-ID: <20150311122905.GY8656@n2100.arm.linux.org.uk>
References: <1424876018-17852-1-git-send-email-shawn.guo@linaro.org>
 <1424876018-17852-2-git-send-email-shawn.guo@linaro.org>
 <20150225172757.421.43718@quantum>
 <8682755.oK0Ae34OOP@wuerfel>
 <20150311102208.GX8656@n2100.arm.linux.org.uk>
 <20150311111755.GI952@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pwm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150311111755.GI952@pengutronix.de>
Sender: linux-pwm-owner@vger.kernel.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, Mike Turquette <mturquette@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-pwm@vger.kernel.org, alsa-devel@alsa-project.org, kernel@pengutronix.de, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Stephen Boyd <sboyd@codeaurora.org>, dri-devel@lists.freedesktop.org, Mark Brown <broonie@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, linux-serial@vger.kernel.org, Shawn Guo <shawn.guo@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On Wed, Mar 11, 2015 at 12:17:55PM +0100, Uwe Kleine-K=F6nig wrote:
> Hey Russell,
>=20
> On Wed, Mar 11, 2015 at 10:22:09AM +0000, Russell King - ARM Linux wr=
ote:
> > On Sun, Mar 08, 2015 at 10:05:29PM +0100, Arnd Bergmann wrote:
> > > ARM randconfig build tests found a new error for configurations
> > > with COMMON_CLK disabled but HAS_CLK selected by the platform:
> > >=20
> > > ERROR: "clk_is_match" [sound/soc/fsl/snd-soc-fsl-spdif.ko] undefi=
ned!
> > >=20
> > > This moves the declaration around, so this case is covered
> > > by the existing static inline helper function.
> > >=20
> > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > > Fixes: c69e182e51d89 ("clk: introduce clk_is_match")
> > > ----
> > > BTW, we have a preexisting problem in clk_get_parent,
> > > clk_round_rate and clk_set_parent, which I've worked around in
> > > my randconfig builds so far. Should we do that the same way?
> >=20
> > NAK, as Uwe points out, you didn't address my comment.
> You commented on the patch that is c69e182e51d8 ("clk: introduce
> clk_is_match") now in next. Arnd just moved this around.

*Sigh*

Mike - please remove this commit until proper kernel patch process is
honoured.  We'll have some order here, and mutual respect of fellow
kernel developers, rather than people selectively ignoring people.
Yes, I realise that it fixes a bug, but it's utterly disgusting that
comments on a patch are ignored and it's just picked up irrespective
of comments being addressed.

If you don't like that, bloody well do a better job.

--=20
=46TTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps u=
p
according to speedtest.net.
