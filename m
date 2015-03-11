From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] clk: provide clk_is_match() dummy for
	non-common clk
Date: Wed, 11 Mar 2015 10:22:09 +0000
Message-ID: <20150311102208.GX8656@n2100.arm.linux.org.uk>
References: <1424876018-17852-1-git-send-email-shawn.guo@linaro.org>
 <1424876018-17852-2-git-send-email-shawn.guo@linaro.org>
 <20150225172757.421.43718@quantum> <8682755.oK0Ae34OOP@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <8682755.oK0Ae34OOP@wuerfel>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-pwm@vger.kernel.org, alsa-devel@alsa-project.org, Mike Turquette <mturquette@linaro.org>, kernel@pengutronix.de, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Stephen Boyd <sboyd@codeaurora.org>, dri-devel@lists.freedesktop.org, Mark Brown <broonie@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, linux-serial@vger.kernel.org, Shawn Guo <shawn.guo@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On Sun, Mar 08, 2015 at 10:05:29PM +0100, Arnd Bergmann wrote:
> ARM randconfig build tests found a new error for configurations
> with COMMON_CLK disabled but HAS_CLK selected by the platform:
> 
> ERROR: "clk_is_match" [sound/soc/fsl/snd-soc-fsl-spdif.ko] undefined!
> 
> This moves the declaration around, so this case is covered
> by the existing static inline helper function.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: c69e182e51d89 ("clk: introduce clk_is_match")
> ----
> BTW, we have a preexisting problem in clk_get_parent,
> clk_round_rate and clk_set_parent, which I've worked around in
> my randconfig builds so far. Should we do that the same way?

NAK, as Uwe points out, you didn't address my comment.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
