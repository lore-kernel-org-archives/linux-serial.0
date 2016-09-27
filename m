From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v6] serial: rewrite pxa2xx-uart to use 8250_core
Date: Tue, 27 Sep 2016 18:12:53 +0200
Message-ID: <20160927161253.GA1338@kroah.com>
References: <1450897204-6839-1-git-send-email-ynvich@gmail.com>
 <1450970122-12869-1-git-send-email-ynvich@gmail.com>
 <20160207062206.GB16270@kroah.com>
 <1456106191.2386.13.camel@gmail.com>
 <87si0lw6wi.fsf@belgarion.home>
 <87lgydbaz9.fsf@belgarion.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87lgydbaz9.fsf@belgarion.home>
Sender: linux-kernel-owner@vger.kernel.org
To: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: Sergei Ianovich <ynvich@gmail.com>, linux-kernel@vger.kernel.org, Heikki Krogerus <heikki.krogerus@linux.intel.com>, James Cameron <quozl@laptop.org>, Russell King <linux@arm.linux.org.uk>, Jiri Slaby <jslaby@suse.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>, Joachim Eastwood <manabian@gmail.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Scott Wood <scottwood@freescale.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, Paul Burton <paul.burton@imgtec.com>, Mans Rullgard <mans@mansr.com>, Ralf Baechle <ralf@linux-mips.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, Peter Hurley <peter@hurleysoftware.com>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Tue, Sep 27, 2016 at 05:47:54PM +0200, Robert Jarzmik wrote:
> Robert Jarzmik <robert.jarzmik@free.fr> writes:
> 
> >>> If so, great, get the platform maintainer to sign off on this please and
> >>> then resend it.
> >
> > If you're talking about the PXA maintainer, then :
> > Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>
> >
> > I'm happy with the patch, all pxa board maintainers have been warned, and there
> > exists a fallback solution.
> >
> > So let's go forward, and if people complain, let them complain and forward them
> > to me.
> 
> Hi Greg,
> 
> I rebased and retested the patch (both devicetree and legacy boards, multiple
> pxa variants, early console and standard console), and it does work. The
> fallback on the old driver works as well.
> 
> I also signed it as the pxa maintainer, and I'm pushing it now, in [2].
> 
> If you want context, it's archived in [1].
> 
> If you're overburdened and feel there won't be a merge conflict in your serial
> tree, I can take it through pxa tree provided you ack it, or you can take it,
> just let me know.

I'll be glad to take it, can you send it in a proper format?

thanks,

greg k-h
