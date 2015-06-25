From: Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: Re: [PATCH 3/9] arm: add call to CPU idle quirks handler
Date: Thu, 25 Jun 2015 12:42:56 -0400 (EDT)
Message-ID: <alpine.LFD.2.11.1506251237000.2617@knanqh.ubzr>
References: <1435094387-20146-1-git-send-email-pawelo@king.net.pl> <1435094387-20146-4-git-send-email-pawelo@king.net.pl> <2235698.8UjxLOMCMb@wuerfel>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2235698.8UjxLOMCMb@wuerfel>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Paul Osmialowski <pawelo@king.net.pl>, Andrew Morton <akpm@linux-foundation.org>, Anson Huang <b20788@freescale.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Bhupesh Sharma <bhupesh.sharma@freescale.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Frank Li <Frank.Li@freescale.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Guenter Roeck <linux@roeck-us.net>, Haojian Zhuang <haojian.zhuang@gmail.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Jingchang Lu <jingchang.lu@freescale.com>, Jiri Slaby <jslaby@suse.cz>, Kees Cook <keescook@chromium.org>, Kumar Gala <galak@codeaurora.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Linus Walleij <linus.walleij@linaro.org>, Magnus Damm <damm+renesas@opensource.se>, Michael Turquette <mturquette@baylibre.com>, Nathan Lynch <nathan_lynch@mentor.com>, Max
List-Id: linux-serial@vger.kernel.org

On Tue, 23 Jun 2015, Arnd Bergmann wrote:

> On Tuesday 23 June 2015 23:19:41 Paul Osmialowski wrote:
> > Some SoCs need additional actions to be performed after arch idle,
> > e.g. Kinetis requires invalidation of the I/D bus cache.
> > 
> > Such handler could be held in provided <mach/idle.h> header file.
> > 
> > Signed-off-by: Paul Osmialowski <pawelo@king.net.pl>
> > ---
> >  arch/arm/Kconfig          | 7 +++++++
> >  arch/arm/kernel/process.c | 7 +++++++
> >  2 files changed, 14 insertions(+)
> > 
> > diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> > index 8e3a833..8ef8f8f 100644
> > --- a/arch/arm/Kconfig
> > +++ b/arch/arm/Kconfig
> > @@ -98,6 +98,13 @@ config ARM_HAS_SG_CHAIN
> >  config NEED_SG_DMA_LENGTH
> >  	bool
> >  
> > +config NEED_MACH_IDLE_H
> > +	bool
> > +
> > +config ARM_CPU_IDLE_QUIRKS
> > +	bool
> > +	select NEED_MACH_IDLE_H
> > +
> 
> We're not adding header files like this, please come up
> with another solution. How about a cpuidle driver, or
> possibly just overriding arm_pm_idle()?

If the WFI instruction always requires I and D flushing, then it might 
be a better idea to provide a replacement for the corresponding 
cpu_*_do_idle function.  Plenty of examples exist for other cpu_* 
functions.


Nicolas
