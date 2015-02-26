From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 7/8] ASoC: fsl_spdif: fix struct clk pointer comparing
Date: Thu, 26 Feb 2015 10:20:00 +0800
Message-ID: <20150226021958.GD20028@dragon>
References: <1424876018-17852-1-git-send-email-shawn.guo@linaro.org>
 <1424876018-17852-8-git-send-email-shawn.guo@linaro.org>
 <20150226021250.GA6236@finisterre.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150226021250.GA6236@finisterre.sirena.org.uk>
Sender: linux-pwm-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Mike Turquette <mturquette@linaro.org>, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de, Russell King <linux@arm.linux.org.uk>, Stephen Boyd <sboyd@codeaurora.org>, Thierry Reding <thierry.reding@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pwm@vger.kernel.org, alsa-devel@alsa-project.org, dri-devel@lists.freedesktop.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Thu, Feb 26, 2015 at 11:12:50AM +0900, Mark Brown wrote:
> On Wed, Feb 25, 2015 at 10:53:37PM +0800, Shawn Guo wrote:
> > Since commit 035a61c314eb ("clk: Make clk API return per-user struct clk
> > instances"), clk API users can no longer check if two struct clk
> > pointers are pointing to the same hardware clock, i.e. struct clk_hw, by
> 
> Applied, thanks.

Mark,

Sorry that I did not make it clear in the cover-letter.  But the first
patch introduces a helper function clk_is_match(), on which all the
other patches in the series depend.  That said, the patch series should
probably be handled by Mike as a whole.

Shawn
