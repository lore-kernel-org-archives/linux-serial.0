From: Ricard Wanderlof <ricard.wanderlof@axis.com>
Subject: Re: [alsa-devel] [PATCH 1/8] clk: add helper function
 clk_is_match()
Date: Thu, 26 Feb 2015 12:59:31 +0100
Message-ID: <alpine.DEB.2.02.1502261259060.17631@lnxricardw1.se.axis.com>
References: <1424876018-17852-1-git-send-email-shawn.guo@linaro.org> <1424876018-17852-2-git-send-email-shawn.guo@linaro.org> <20150225172757.421.43718@quantum> <20150226090256.GQ30445@trinity.fluff.org> <1424944618.3073.6.camel@pengutronix.de>
 <20150226112509.GR30445@trinity.fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pwm-owner@vger.kernel.org>
In-Reply-To: <20150226112509.GR30445@trinity.fluff.org>
Sender: linux-pwm-owner@vger.kernel.org
To: Ben Dooks <ben@trinity.fluff.org>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mike Turquette <mturquette@linaro.org>, Ben Dooks <ben-linux@fluff.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Stephen Boyd <sboyd@codeaurora.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, Mark Brown <broonie@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Russell King <linux@arm.linux.org.uk>, Shawn Guo <shawn.guo@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org


On Thu, 26 Feb 2015, Ben Dooks wrote:

> > > small observaton, clk_is_same() is linguistically nicer.
> >=20
> > How about clk_equal() ?
>=20
> That's good, the only issue that's not clear in any of these names is
> that does this mean "the same clock", a "clock of the same rate" or a
> "clock that is equivalent to in the rate and phase but not subject to
> the same gate".

clk_identical() ?

/Ricard
--=20
Ricard Wolf Wanderl=F6f                           ricardw(at)axis.com
Axis Communications AB, Lund, Sweden            www.axis.com
Phone +46 46 272 2016                           Fax +46 46 13 61 30
