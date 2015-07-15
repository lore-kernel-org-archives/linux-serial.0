From: Paul Osmialowski <pawelo@king.net.pl>
Subject: Re: [PATCH v2 3/9] arm: twr-k70f120m: clock driver for Kinetis SoC
Date: Wed, 15 Jul 2015 09:31:17 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1507150917470.32721@localhost.localdomain>
References: <1435667250-28299-1-git-send-email-pawelo@king.net.pl> <1435667250-28299-4-git-send-email-pawelo@king.net.pl> <CACRpkdasMqFCwy=ZEvMLeG2Z-xV01dbf8cXaPACP1=RSz2gdjw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <CACRpkdasMqFCwy=ZEvMLeG2Z-xV01dbf8cXaPACP1=RSz2gdjw@mail.gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Paul Osmialowski <pawelo@king.net.pl>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Jiri Slaby <jslaby@suse.cz>, Kumar Gala <galak@codeaurora.org>, Mark Rutland <mark.rutland@arm.com>, Michael Turquette <mturquette@baylibre.com>, Pawel Moll <pawel.moll@arm.com>, Rob Herring <robh+dt@kernel.org>, Russell King <linux@arm.linux.org.uk>, Stephen Boyd <sboyd@codeaurora.org>, Vinod Koul <vinod.koul@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-clk@vger.kernel.org, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, dmaengine@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Geert
List-Id: linux-serial@vger.kernel.org

Hi Linus,

Thanks for all of your comments, I'll consider them during my works on the 
next iteration. However, I have doubts about this one:

On Tue, 14 Jul 2015, Linus Walleij wrote:

> On Tue, Jun 30, 2015 at 2:27 PM, Paul Osmialowski <pawelo@king.net.pl> wrote:
> 
> > Based on K70P256M150SF3RM.pdf K70 Sub-Family Reference Manual, Rev. 3.
> >
> > Signed-off-by: Paul Osmialowski <pawelo@king.net.pl>
> (...)
> > +struct kinetis_sim_regs {
> > +       u32 sopt1;      /* System Options Register 1 */
> > +       u32 rsv0[1024];
> > +       u32 sopt2;      /* System Options Register 2 */
> > +       u32 rsv1;
> > +       u32 sopt4;      /* System Options Register 4 */
> > +       u32 sopt5;      /* System Options Register 5 */
> > +       u32 sopt6;      /* System Options Register 6 */
> > +       u32 sopt7;      /* System Options Register 7 */
> > +       u32 rsv2[2];
> > +       u32 sdid;       /* System Device Identification Register */
> > +       u32 scgc[KINETIS_SIM_CG_NUMREGS];       /* Clock Gating Regs 1...7 */
> > +       u32 clkdiv1;    /* System Clock Divider Register 1 */
> > +       u32 clkdiv2;    /* System Clock Divider Register 2 */
> > +       u32 fcfg1;      /* Flash Configuration Register 1 */
> > +       u32 fcfg2;      /* Flash Configuration Register 2 */
> > +       u32 uidh;       /* Unique Identification Register High */
> > +       u32 uidmh;      /* Unique Identification Register Mid-High */
> > +       u32 uidml;      /* Unique Identification Register Mid Low */
> > +       u32 uidl;       /* Unique Identification Register Low */
> > +       u32 clkdiv3;    /* System Clock Divider Register 3 */
> > +       u32 clkdiv4;    /* System Clock Divider Register 4 */
> > +       u32 mcr;        /* Misc Control Register */
> > +};
> 
> Now there is this design pattern where you copy the datasheet
> register map to a struct again.
> 
> This is not good if there is a second revision of the hardware and some
> registers are shuffled around. IMO it is better to just use #defines
> for register
> offsets, so you can do exceptions later. Else a new hardware revision
> leads to a new struct with new accessor functions etc etc.
> 

I don't see how replacing this structure with bunch of defines could make 
anyones life easier. As registers are shuffled around due to updated 
hardware revision they could be shuffled in this structure too. Doing 
this with buch of defines would require eager and careful adaptation of 
all the defines. I don't see how this could be easier.

Note that I'm not making any instances of the structure (it is used only 
for casting), so shuffling its fields around should not affect the code 
that follows.

After recent purge it is only used within this macro:

#define KINETIS_SIM_PTR(base, reg) \
        (&(((struct kinetis_sim_regs *)(base))->reg))

...and used like this:

        ioread32(KINETIS_SIM_PTR(sim, clkdiv1));

IMHO changing the struct internals does not require subsequent changes in 
any of those.

Thanks,
Paul
