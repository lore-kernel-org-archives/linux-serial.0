From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 1/8] clk: add helper function clk_is_match()
Date: Wed, 4 Mar 2015 09:51:55 +0000
Message-ID: <20150304095155.GB8656@n2100.arm.linux.org.uk>
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
Cc: Shawn Guo <shawn.guo@linaro.org>, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de, Stephen Boyd <sboyd@codeaurora.org>, Thierry Reding <thierry.reding@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Brown <broonie@kernel.org>, linux-pwm@vger.kernel.org, alsa-devel@alsa-project.org, dri-devel@lists.freedesktop.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Wed, Feb 25, 2015 at 09:27:57AM -0800, Mike Turquette wrote:
> +static inline bool clk_is_match(struct clk *p, struct clk *q)
> +{
> +	return p == q ? true : false;

When they created the C standard, they already taught the compiler that
p == q returns a true / false boolean value; there's no need for ?: here.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
