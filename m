From: Ben Dooks <ben@trinity.fluff.org>
Subject: Re: [alsa-devel] [PATCH 1/8] clk: add helper function
 clk_is_match()
Date: Thu, 26 Feb 2015 11:25:09 +0000
Message-ID: <20150226112509.GR30445@trinity.fluff.org>
References: <1424876018-17852-1-git-send-email-shawn.guo@linaro.org>
 <1424876018-17852-2-git-send-email-shawn.guo@linaro.org>
 <20150225172757.421.43718@quantum>
 <20150226090256.GQ30445@trinity.fluff.org>
 <1424944618.3073.6.camel@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1424944618.3073.6.camel@pengutronix.de>
Sender: linux-pwm-owner@vger.kernel.org
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Ben Dooks <ben-linux@fluff.org>, Mike Turquette <mturquette@linaro.org>, linux-pwm@vger.kernel.org, alsa-devel@alsa-project.org, Russell King <linux@arm.linux.org.uk>, kernel@pengutronix.de, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Stephen Boyd <sboyd@codeaurora.org>, dri-devel@lists.freedesktop.org, Mark Brown <broonie@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, linux-serial@vger.kernel.org, Shawn Guo <shawn.guo@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On Thu, Feb 26, 2015 at 10:56:58AM +0100, Philipp Zabel wrote:
> Am Donnerstag, den 26.02.2015, 09:02 +0000 schrieb Ben Dooks:
> > On Wed, Feb 25, 2015 at 09:27:57AM -0800, Mike Turquette wrote:
> [...]
> > > From: Michael Turquette <mturquette@linaro.org>
> > > Date: Wed, 25 Feb 2015 09:11:01 -0800
> > > Subject: [PATCH] clk: introduce clk_is_match
> > > 
> > > Some drivers compare struct clk pointers as a means of knowing
> > > if the two pointers reference the same clock hardware. This behavior is
> > > dubious (drivers must not dereference struct clk), but did not cause any
> > > regressions until the per-user struct clk patch was merged. Now the test
> > > for matching clk's will always fail with per-user struct clk's.
> > > 
> > > clk_is_match is introduced to fix the regression and prevent drivers
> > > from comparing the pointers manually.
> > 
> > small observaton, clk_is_same() is linguistically nicer.
> 
> How about clk_equal() ?

That's good, the only issue that's not clear in any of these names is
that does this mean "the same clock", a "clock of the same rate" or a
"clock that is equivalent to in the rate and phase but not subject to
the same gate".


-- 
Ben Dooks, ben@fluff.org, http://www.fluff.org/ben/

Large Hadron Colada: A large Pina Colada that makes the universe disappear.

