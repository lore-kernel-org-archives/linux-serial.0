From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2 5/9] arm: twr-k70f120m: IOMUX driver for Kinetis SoC
Date: Tue, 14 Jul 2015 10:55:39 +0200
Message-ID: <CACRpkdZE9foKeNMkn+O9ZF9xLkkdDnkJXKN8jxY8U5ZU81vbaQ@mail.gmail.com>
References: <1435667250-28299-1-git-send-email-pawelo@king.net.pl>
	<1435667250-28299-6-git-send-email-pawelo@king.net.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1435667250-28299-6-git-send-email-pawelo@king.net.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Osmialowski <pawelo@king.net.pl>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Jiri Slaby <jslaby@suse.cz>, Kumar Gala <galak@codeaurora.org>, Mark Rutland <mark.rutland@arm.com>, Michael Turquette <mturquette@baylibre.com>, Pawel Moll <pawel.moll@arm.com>, Rob Herring <robh+dt@kernel.org>, Russell King <linux@arm.linux.org.uk>, Stephen Boyd <sboyd@codeaurora.org>, Vinod Koul <vinod.koul@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-clk@vger.kernel.org, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, dmaengine@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Geert Uytterhoeven <geert@linux-m68k.org>, Nicolas
List-Id: linux-serial@vger.kernel.org

On Tue, Jun 30, 2015 at 2:27 PM, Paul Osmialowski <pawelo@king.net.pl> wrote:

> This is a very cheap and simple implementation of pinctrl driver
> for Kinetis SoC - its primary role is to provide means for enabling UART
> fuctionality on I/O PORT_E which will be utilized by the commits
> yet to come.
>
> Signed-off-by: Paul Osmialowski <pawelo@king.net.pl>

Same comments as for v1. Sorry for taking time to review,
was in the merge window and some vacation.

Yours,
Linus Walleij
