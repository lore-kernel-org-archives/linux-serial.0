From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 10/45] drivers: tty: serial: zs: use devm_* functions
Date: Fri, 15 Mar 2019 07:26:28 -0700
Message-ID: <20190315142628.GA30650@kroah.com>
References: <1552602855-26086-1-git-send-email-info@metux.net>
 <1552602855-26086-11-git-send-email-info@metux.net>
 <20190314225204.GB1795@kroah.com>
 <3734d588-6b9c-29e2-45b6-82e778f47602@metux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <3734d588-6b9c-29e2-45b6-82e778f47602@metux.net>
Sender: linux-kernel-owner@vger.kernel.org
To: "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Cc: "Enrico Weigelt, metux IT consult" <info@metux.net>, linux-kernel@vger.kernel.org, eric@anholt.net, stefan.wahren@i2se.com, f.fainelli@gmail.com, rjui@broadcom.com, sbranden@broadcom.com, bcm-kernel-feedback-list@broadcom.com, andriy.shevchenko@linux.intel.com, vz@mleia.com, matthias.bgg@gmail.com, yamada.masahiro@socionext.com, tklauser@distanz.ch, richard.genoud@gmail.com, macro@linux-mips.org, u.kleine-koenig@pengutronix.de, kernel@pengutronix.de, slemieux.tyco@gmail.com, andy.gross@linaro.org, david.brown@linaro.org, shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com, baohua@kernel.org, jacmet@sunsite.dk, linux-serial@vger.kernel.org, linux-arm-msm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: linux-serial@vger.kernel.org

On Fri, Mar 15, 2019 at 10:06:16AM +0100, Enrico Weigelt, metux IT consult wrote:
> On 14.03.19 23:52, Greg KH wrote:
> > On Thu, Mar 14, 2019 at 11:33:40PM +0100, Enrico Weigelt, metux IT consult wrote:
> >> Use the safer devm versions of memory mapping functions.
> > 
> > What is "safer" about them?
> 
> Garbage collection :)

At times, but not when you do not use the api correctly :)

> Several drivers didn't seem to clean up properly (maybe these're just
> used compiled-in, so nobody noticed yet).

Yes, there are lots of drivers for devices that are never unloaded or
removed from the system.  The fact that no one has reported any problems
with them means that they are never used in situations like this.

> In general, I think devm_* should be the standard case, unless there's
> a really good reason to do otherwise.

No, you need to have a good reason why it needs to be changed, when you
can not verify that this actually resolves a problem.  As this patch
shows, you just replaced one api call with another, so nothing changed
at all, except you actually took up more memory and logic to do the same
thing :(

> > Isn't the whole goal of the devm* functions such that you are not
> > required to call "release" on them?
> 
> Looks that one slipped through, when I was doing that big bulk change
> in the middle of the night and not enough coffe ;-)
> 
> One problem here is that many drivers do this stuff in request/release
> port, instead of probe/remove. I'm not sure yet, whether we should
> rewrite that. There're also cases which do request/release, but no
> ioremap (doing hardcoded register accesses), others do ioremap w/o
> request/release.
> 
> IMHO, we should have a closer look at those and check whether that's
> really okay (just adding request/release blindly could cause trouble)

I agree, please feel free to audit these to verify they are all correct.
But that's not what you did here, so that's not a valid justification
for these patches to be accepted.

> > And also, why make the change, you aren't changing any functionality for
> > these old drivers at all from what I can tell (for the devm calls).
> > What am I missing here?
> 
> Okay, there's a bigger story behind, you can't know yet. Finally, I'd
> like to move everything to using struct resource and corresponding
> helpers consistently, so most of the drivers would be pretty simple
> at that point. (there're of course special cases, like devices w/
> multiple register spaces, etc)
> 
> Here's my wip branch:
> 
> https://github.com/metux/linux/commits/wip/serial-res
> 
> In this consolidation process, I'm trying to move everything to
> devm_*, to have it more generic (for now, I still need two versions
> of the request/release/ioremap/iounmap helpers - one w/ and one
> w/o devm).

Move everything in what part of the kernel?  The whole kernel or just
one subsystem?

> My idea was moving to devm first, so it can be reviewed/tested
> independently, before moving forward. Smaller, easily digestable
> pieces should minimize the risk of breaking anything. But if you
> prefer having this things squashed together, just let me know.

Small pieces are required, that's fine, but those pieces need to have a
justification for why they should be accepted at all points along the
way.

> In the queue are also other minor cleanups like using dev_err()
> instead of printk(), etc. Should I send these separately ?

Of course.

> By the way: do you have some public branch where you're collecting
> accepted patches, which I could base mine on ? (tty.git/tty-next ?)

Yes, that is the tree and branch, but remember that none of my trees can
open up until after -rc1 is out.

thanks,

greg k-h
