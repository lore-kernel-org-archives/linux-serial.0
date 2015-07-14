From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2 3/9] arm: twr-k70f120m: clock driver for Kinetis SoC
Date: Tue, 14 Jul 2015 11:03:59 +0200
Message-ID: <CACRpkdasMqFCwy=ZEvMLeG2Z-xV01dbf8cXaPACP1=RSz2gdjw@mail.gmail.com>
References: <1435667250-28299-1-git-send-email-pawelo@king.net.pl>
	<1435667250-28299-4-git-send-email-pawelo@king.net.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1435667250-28299-4-git-send-email-pawelo@king.net.pl>
Sender: linux-gpio-owner@vger.kernel.org
To: Paul Osmialowski <pawelo@king.net.pl>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Jiri Slaby <jslaby@suse.cz>, Kumar Gala <galak@codeaurora.org>, Mark Rutland <mark.rutland@arm.com>, Michael Turquette <mturquette@baylibre.com>, Pawel Moll <pawel.moll@arm.com>, Rob Herring <robh+dt@kernel.org>, Russell King <linux@arm.linux.org.uk>, Stephen Boyd <sboyd@codeaurora.org>, Vinod Koul <vinod.koul@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-clk@vger.kernel.org, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, dmaengine@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Geert Uytterhoeven <geert@linux-m68k.org>, Nicolas
List-Id: linux-serial@vger.kernel.org

On Tue, Jun 30, 2015 at 2:27 PM, Paul Osmialowski <pawelo@king.net.pl> wrote:

> Based on K70P256M150SF3RM.pdf K70 Sub-Family Reference Manual, Rev. 3.
>
> Signed-off-by: Paul Osmialowski <pawelo@king.net.pl>
(...)
> +struct kinetis_sim_regs {
> +       u32 sopt1;      /* System Options Register 1 */
> +       u32 rsv0[1024];
> +       u32 sopt2;      /* System Options Register 2 */
> +       u32 rsv1;
> +       u32 sopt4;      /* System Options Register 4 */
> +       u32 sopt5;      /* System Options Register 5 */
> +       u32 sopt6;      /* System Options Register 6 */
> +       u32 sopt7;      /* System Options Register 7 */
> +       u32 rsv2[2];
> +       u32 sdid;       /* System Device Identification Register */
> +       u32 scgc[KINETIS_SIM_CG_NUMREGS];       /* Clock Gating Regs 1...7 */
> +       u32 clkdiv1;    /* System Clock Divider Register 1 */
> +       u32 clkdiv2;    /* System Clock Divider Register 2 */
> +       u32 fcfg1;      /* Flash Configuration Register 1 */
> +       u32 fcfg2;      /* Flash Configuration Register 2 */
> +       u32 uidh;       /* Unique Identification Register High */
> +       u32 uidmh;      /* Unique Identification Register Mid-High */
> +       u32 uidml;      /* Unique Identification Register Mid Low */
> +       u32 uidl;       /* Unique Identification Register Low */
> +       u32 clkdiv3;    /* System Clock Divider Register 3 */
> +       u32 clkdiv4;    /* System Clock Divider Register 4 */
> +       u32 mcr;        /* Misc Control Register */
> +};

Now there is this design pattern where you copy the datasheet
register map to a struct again.

This is not good if there is a second revision of the hardware and some
registers are shuffled around. IMO it is better to just use #defines
for register
offsets, so you can do exceptions later. Else a new hardware revision
leads to a new struct with new accessor functions etc etc.

Yours,
Linus Walleij
