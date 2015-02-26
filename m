From: Ben Dooks <ben-linux@fluff.org>
Subject: Re: [PATCH 1/8] clk: add helper function clk_is_match()
Date: Thu, 26 Feb 2015 09:02:56 +0000
Message-ID: <20150226090256.GQ30445@trinity.fluff.org>
References: <1424876018-17852-1-git-send-email-shawn.guo@linaro.org>
 <1424876018-17852-2-git-send-email-shawn.guo@linaro.org>
 <20150225172757.421.43718@quantum>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <20150225172757.421.43718@quantum>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mike Turquette <mturquette@linaro.org>
Cc: linux-pwm@vger.kernel.org, alsa-devel@alsa-project.org, Russell King <linux@arm.linux.org.uk>, kernel@pengutronix.de, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Stephen Boyd <sboyd@codeaurora.org>, dri-devel@lists.freedesktop.org, Mark Brown <broonie@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, linux-serial@vger.kernel.org, Shawn Guo <shawn.guo@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On Wed, Feb 25, 2015 at 09:27:57AM -0800, Mike Turquette wrote:
> Quoting Shawn Guo (2015-02-25 06:53:31)
> > Since commit 035a61c314eb ("clk: Make clk API return per-user struct clk
> > instances"), clk API users can no longer check if two struct clk
> > pointers are pointing to the same hardware clock, i.e. struct clk_hw, by
> > simply comparing two pointers.  That's because with the per-user clk
> > change, a brand new struct clk is created whenever clients try to look
> > up the clock by calling clk_get() or sister functions like clk_get_sys()
> > and of_clk_get().  This changes the original behavior where the struct
> > clk is only created for once when clock driver registers the clock to
> > CCF in the first place.  The net change here is before commit
> > 035a61c314eb the struct clk pointer is unique for given hardware
> > clock, while after the commit the pointers returned by clk lookup calls
> > become different for the same hardware clock.
> > 
> > A number of client drivers detecting if two struct clk pointers point to
> > the same one hardware clock by comparing the pointers are broken now.
> > As a stop-gap solution, this patch adds a helper function clk_is_match()
> > to test if two struct clk pointers point to the same hardware clock, so
> > that these client drivers can use to fix the regression.
> > 
> > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> 
> Hi Shawn,
> 
> Thanks for the patch. I wrote a similar one last night but did not
> finish fixing up the drivers (and thus did not post it). I prefer my
> implementation below, and I'm happy to merge your driver fixes with it.
> 
> Regards,
> Mike
> 
> 
> 
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

small observaton, clk_is_same() is linguistically nicer.

-- 
Ben Dooks, ben@fluff.org, http://www.fluff.org/ben/

Large Hadron Colada: A large Pina Colada that makes the universe disappear.
