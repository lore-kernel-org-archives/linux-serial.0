From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 10/45] drivers: tty: serial: zs: use devm_* functions
Date: Fri, 15 Mar 2019 20:26:30 -0700
Message-ID: <20190316032630.GB2499@kroah.com>
References: <1552602855-26086-1-git-send-email-info@metux.net>
 <1552602855-26086-11-git-send-email-info@metux.net>
 <20190314225204.GB1795@kroah.com>
 <3734d588-6b9c-29e2-45b6-82e778f47602@metux.net>
 <20190315142628.GA30650@kroah.com>
 <d81364fc-c5da-c1b2-f38a-3a23c701c50d@metux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <d81364fc-c5da-c1b2-f38a-3a23c701c50d@metux.net>
Sender: linux-kernel-owner@vger.kernel.org
To: "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Cc: "Enrico Weigelt, metux IT consult" <info@metux.net>, linux-kernel@vger.kernel.org, eric@anholt.net, stefan.wahren@i2se.com, f.fainelli@gmail.com, rjui@broadcom.com, sbranden@broadcom.com, bcm-kernel-feedback-list@broadcom.com, andriy.shevchenko@linux.intel.com, vz@mleia.com, matthias.bgg@gmail.com, yamada.masahiro@socionext.com, tklauser@distanz.ch, richard.genoud@gmail.com, macro@linux-mips.org, u.kleine-koenig@pengutronix.de, kernel@pengutronix.de, slemieux.tyco@gmail.com, andy.gross@linaro.org, david.brown@linaro.org, shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com, baohua@kernel.org, jacmet@sunsite.dk, linux-serial@vger.kernel.org, linux-arm-msm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: linux-serial@vger.kernel.org

On Fri, Mar 15, 2019 at 08:12:47PM +0100, Enrico Weigelt, metux IT consult wrote:
> On 15.03.19 15:26, Greg KH wrote:
> > Yes, there are lots of drivers for devices that are never unloaded or
> > removed from the system.  The fact that no one has reported any problems
> > with them means that they are never used in situations like this.
> 
> So, never touch a running system ?

No, it's just that those systems do not allow those devices to be
removed because they are probably not on a removable bus.

> > No, you need to have a good reason why it needs to be changed, when you
> > can not verify that this actually resolves a problem.  As this patch
> > shows, you just replaced one api call with another, so nothing changed
> > at all, except you actually took up more memory and logic to do the same
> > thing :(
> 
> Okay, I was on a wrong track here - I had the silly idea that it would
> make things easier if we'd do it the same way everywhere.

"Consistent" is good, and valid, but touching old drivers that have few
users is always risky, and you need a solid reason to do so.

> >> IMHO, we should have a closer look at those and check whether that's
> >> really okay (just adding request/release blindly could cause trouble)
> > 
> > I agree, please feel free to audit these to verify they are all correct.
> > But that's not what you did here, so that's not a valid justification
> > for these patches to be accepted.
> 
> Understood. Assuming I've found some of these cases, shall I use devm
> oder just add the missing release ?

If it actually makes the code "simpler" or "more obvious", sure, that's
fine.  But churn for churns sake is not ok.

> >> By the way: do you have some public branch where you're collecting
> >> accepted patches, which I could base mine on ? (tty.git/tty-next ?)
> > 
> > Yes, that is the tree and branch, but remember that none of my trees can
> > open up until after -rc1 is out.
> 
> So, within a merge window, you put everything else on hold ?

I put the review of new patch submissions on hold, yes.  Almost all
maintainers do that as we can not add new patches to our trees at that
point in time.

And I do have other things I do during that period so it's not like I'm
just sitting around doing nothing :)

thanks,

greg k-h
