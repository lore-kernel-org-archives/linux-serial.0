From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 3/9] arm: twr-k70f120m: clock driver for Kinetis SoC
Date: Thu, 02 Jul 2015 14:40:23 +0200
Message-ID: <1861313.aMcV1xHCIq@wuerfel>
References: <1435667250-28299-1-git-send-email-pawelo@king.net.pl> <alpine.LNX.2.00.1507011756140.14440@localhost.localdomain> <alpine.LNX.2.00.1507021206410.13210@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <alpine.LNX.2.00.1507021206410.13210@localhost.localdomain>
Sender: linux-gpio-owner@vger.kernel.org
To: Paul Osmialowski <pawelo@king.net.pl>
Cc: linux-arm-kernel@lists.infradead.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Jiri Slaby <jslaby@suse.cz>, Kumar Gala <galak@codeaurora.org>, Linus Walleij <linus.walleij@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Michael Turquette <mturquette@baylibre.com>, Pawel Moll <pawel.moll@arm.com>, Rob Herring <robh+dt@kernel.org>, Russell King <linux@arm.linux.org.uk>, Stephen Boyd <sboyd@codeaurora.org>, Vinod Koul <vinod.koul@intel.com>, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org, devicetree@vger.kernel.org, dmaengine@vger.kernel.org, Nicolas Pitre <nicolas.pitre@linaro.org>, Sergei Poselenov <sposelenov@emcraft.com>, Paul Bolle <pebolle@tiscali.nl>, Jingchang Lu <jingchang.lu@freescale.com>, Yuri Tikhonov <yur@emcraft.com>
List-Id: linux-serial@vger.kernel.org

On Thursday 02 July 2015 12:08:39 Paul Osmialowski wrote:
> Nah, I've found this code hard to maintain. I'm attaching simplified 
> version.
> 

Looks better to me, but of course needs full review from the clock
maintainers.

I wonder if you could move out the fixed rate clocks into their own
nodes. Are they actually controlled by the same block? If they are
just fixed, you can use the normal binding for fixed rate clocks
and only describe the clocks that are related to the driver.

	Arnd
