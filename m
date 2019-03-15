From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: serial driver cleanups v2
Date: Fri, 15 Mar 2019 20:11:18 +0200
Message-ID: <20190315181118.GF9224@smile.fi.intel.com>
References: <1552602855-26086-1-git-send-email-info@metux.net>
 <CAHp75VeH9isvFkp+AECgsN8du__8tBBp_4zZEVXJ083BdFweeg@mail.gmail.com>
 <afc51d27-3312-cdf4-68a5-4486db1d006b@metux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <afc51d27-3312-cdf4-68a5-4486db1d006b@metux.net>
Sender: linux-kernel-owner@vger.kernel.org
To: "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Cc: "Enrico Weigelt, metux IT consult" <info@metux.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Eric Anholt <eric@anholt.net>, Stefan Wahren <stefan.wahren@i2se.com>, Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>, Vladimir Zapolskiy <vz@mleia.com>, Matthias Brugger <matthias.bgg@gmail.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Tobias Klauser <tklauser@distanz.ch>, Richard Genoud <richard.genoud@gmail.com>, macro@linux-mips.org, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, Sascha Hauer <kernel@pengutronix.de>, slemieux.tyco@g
List-Id: linux-serial@vger.kernel.org

On Fri, Mar 15, 2019 at 11:36:04AM +0100, Enrico Weigelt, metux IT consult wrote:
> On 15.03.19 10:12, Andy Shevchenko wrote:
> 
> >> Part II will be about moving the mmio range from mapbase and
> >> mapsize (which are used quite inconsistently) to a struct resource
> >> and using helpers for that. But this one isn't finished yet.
> >> (if somebody likes to have a look at it, I can send it, too)
> > 
> > Let's do that way you are preparing a branch somewhere and anounce
> > here as an RFC, since this was neither tested nor correct.
> 
> Okay, here it is:
> 
> I. https://github.com/metux/linux/tree/submit/serial-clean-v3
>    --> general cleanups, as basis for II
> 
> II. https://github.com/metux/linux/tree/wip/serial-res
>    --> moving towards using struct resource consistently
> 
> III. https://github.com/metux/linux/tree/hack/serial
>     --> the final steps, which are yet completely broken
>     (more a notepad for things still to do :o)
> 
> The actual goal is generalizing the whole iomem handling, so individual
> usually just need to call some helpers that do most of the things.
> Finally, I also wanted to have all io region information consolidated
> in struct resource.

That's should be a selling point, not just conversion per se.

> > And selling point for many of them is not true: it doesn't make any
> > difference in the size in code, but increases a time to run
> > (devm_ioremap_resource() does more than plain devm_iomap() call).
> 
> Okay, just seen it. Does the the runtime overhead cause any problems ?

You have to explain that in each commit message, that the change does bring a
possible new error message printed.

The performance side of the deal, you are lucky here, is not significant
because it's slow path.

-- 
With Best Regards,
Andy Shevchenko
