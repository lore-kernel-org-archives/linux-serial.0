From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 1/8] clk: add helper function clk_is_match()
Date: Thu, 26 Feb 2015 08:37:58 +0800
Message-ID: <20150226003756.GA20028@dragon>
References: <1424876018-17852-1-git-send-email-shawn.guo@linaro.org>
 <1424876018-17852-2-git-send-email-shawn.guo@linaro.org>
 <20150225172757.421.43718@quantum>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150225172757.421.43718@quantum>
Sender: linux-pwm-owner@vger.kernel.org
To: Mike Turquette <mturquette@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de, Russell King <linux@arm.linux.org.uk>, Stephen Boyd <sboyd@codeaurora.org>, Thierry Reding <thierry.reding@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Brown <broonie@kernel.org>, linux-pwm@vger.kernel.org, alsa-devel@alsa-project.org, dri-devel@lists.freedesktop.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Wed, Feb 25, 2015 at 09:27:57AM -0800, Mike Turquette wrote:
> Hi Shawn,
> 
> Thanks for the patch. I wrote a similar one last night but did not
> finish fixing up the drivers (and thus did not post it). I prefer my
> implementation below, and I'm happy to merge your driver fixes with it.

Sure, no problem.  My intention was to get rmk's HummingBoard back to
work ASAP :)

> From: Michael Turquette <mturquette@linaro.org>
> Date: Wed, 25 Feb 2015 09:11:01 -0800
> Subject: [PATCH] clk: introduce clk_is_match
> 
> Some drivers compare struct clk pointers as a means of knowing
> if the two pointers reference the same clock hardware. This behavior is
> dubious (drivers must not dereference struct clk), but did not cause any
> regressions until the per-user struct clk patch was merged. Now the test
> for matching clk's will always fail with per-user struct clk's.
> 
> clk_is_match is introduced to fix the regression and prevent drivers
> from comparing the pointers manually.
> 
> Fixes: 035a61c314eb ("clk: Make clk API return per-user struct clk instances")
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Stephen Boyd <sboyd@codeaurora.org>
> Cc: Shawn Guo <shawn.guo@linaro.org>

Tested-by: Shawn Guo <shawn.guo@linaro.org>

> Cc: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> Signed-off-by: Michael Turquette <mturquette@linaro.org>
