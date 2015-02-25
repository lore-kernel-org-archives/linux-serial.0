From: Mike Turquette <mturquette@linaro.org>
Subject: Re: [PATCH 0/8] Fix struct clk pointer comparing
Date: Wed, 25 Feb 2015 09:55:33 -0800
Message-ID: <20150225175533.421.41831@quantum>
References: <1424876018-17852-1-git-send-email-shawn.guo@linaro.org>
 <20150225150349.GB8656@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pwm-owner@vger.kernel.org>
In-Reply-To: <20150225150349.GB8656@n2100.arm.linux.org.uk>
Sender: linux-pwm-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>, Shawn Guo <shawn.guo@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de, Stephen Boyd <sboyd@codeaurora.org>, Thierry Reding <thierry.reding@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Brown <broonie@kernel.org>, linux-pwm@vger.kernel.org, alsa-devel@alsa-project.org, dri-devel@lists.freedesktop.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Quoting Russell King - ARM Linux (2015-02-25 07:03:49)
> On Wed, Feb 25, 2015 at 10:53:30PM +0800, Shawn Guo wrote:
> > On the first day back from Chinese new year holiday, I got a regression
> > report from rmk, saying Ethernet stops working on HimmingBoard with
> > v4.0-rc1.
> > 
> > I read through the thread [1] and found a couple of i.MX audio drivers
> > are also affected per Stephen's Coccinelle report.  That's why I came up
> > with this series based on Quentin's structclk.cocci, Stephen's result
> > and Mike's input (thanks all).
> 
> Not all places need to be fixed in this way.
> 
> There are two broad cases:
> 
> 1. Where we are trying to determine if two clocks obtained from clk_get()
>    are the same clock.  IOW:
> 
>         probe()
>         {
>                 clk1 = clk_get(dev, ...);
>                 clk2 = clk_get(dev, ...);
> 
>                 if (clk1 == clk2)
>                         do_something();
>         }
> 
> 2. Where we are trying to determine if a clock selected from a set of
>    previously obtained clk_get()'d clocks is the same as a one of those
>    clocks.  IOW:
> 
>         probe()
>         {
>                 clk1 = clk_get(dev, ...);
>                 clk2 = clk_get(dev, ...);
>         }
> ...
>         some_fn()
>         {
>                 clk = select_best_clock(clk1, clk2);
>                 if (clk == previously_selected_clk) {
>                         previously_selected_clk = clk;
>                         do_something();
>                 }
>         }
> 
> Case 1 applies in places like the Kirkwood I2S driver, and the iMX6
> ethernet code, and it's these cases which need to be fixed.
> 
> Case 2 applies in the Armada DRM driver, and these cases need not be
> "fixed".
> 
> To put it a different way: case 1 is when you're testing to see whether
> two clocks refer to the same clock.  case 2 is when you're testing
> whether the cached clk cookie is the same.

It looks like patches 2, 7 and 8 are correct in this series. I'll apply
them towards -rc2 if nobody objects.

Regards,
Mike

> 
> -- 
> FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
> according to speedtest.net.
