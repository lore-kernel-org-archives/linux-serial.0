From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 06/10] clk: exynos5420: register clocks using common clock framework
Date: Tue, 18 Jun 2013 19:13:45 +0200
Message-ID: <201306181913.45484.arnd@arndb.de>
References: <1371466836-4111-1-git-send-email-chander.kashyap@linaro.org> <201306181601.16795.arnd@arndb.de> <9285029.CIld1HyBWB@amdc1227>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <9285029.CIld1HyBWB@amdc1227>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Tomasz Figa <t.figa@samsung.com>
Cc: Chander Kashyap <chander.kashyap@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Mark Rutland <mark.rutland@arm.com>, "kgene.kim@samsung.com" <kgene.kim@samsung.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Thomas Abraham <thomas.abraham@linaro.org>, "thomas.ab@samsung.com" <thomas.ab@samsung.com>, "s.nawrocki@samsung.com" <s.nawrocki@samsung.com>
List-Id: linux-serial@vger.kernel.org

On Tuesday 18 June 2013, Tomasz Figa wrote:
> This is a binding that has been defined for Samsung Common Clock Framework 
> drivers. Exynos4 and Exynos5250 use the same convention. The numbers are 
> defined in a way that should allow adding further clocks of particular types in 
> future as need for such shows up.

I see, it's probably too late to change that then. Maybe if there is an Exynos6
this should be done differently though.

> Physically there is one clock controller (CMU) which has a lot of dividers, 
> muxes and gates and so it is represented as a single device node.

Some platforms just put device nodes for their clocks under the clock controller
node, which would have helped here. Another option would be to use #clock-cells=<2>
and make the first cell the type of the clock, and the second one the number.

Also, if I understand things correctly, simple fixed rate clocks would normally
not go into the clock driver at all when they are not controller by it.

	Arnd
