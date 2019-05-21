From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH resend] serial: 8250: Add support for using
 platform_device resources
Date: Tue, 21 May 2019 16:53:33 +0200
Message-ID: <20190521145333.GA3491@kroah.com>
References: <20190430140416.4707-1-esben@geanix.com>
 <20190521113426.16790-1-esben@geanix.com>
 <20190521131131.GA19685@kroah.com>
 <878suzn9wx.fsf@haabendal.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <878suzn9wx.fsf@haabendal.dk>
Sender: linux-kernel-owner@vger.kernel.org
To: Esben Haabendal <esben@haabendal.dk>
Cc: linux-serial@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, Enrico Weigelt <lkml@metux.net>, Jiri Slaby <jslaby@suse.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Darwin Dingel <darwin.dingel@alliedtelesis.co.nz>, Jisheng Zhang <Jisheng.Zhang@synaptics.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, He Zhe <zhe.he@windriver.com>, Marek Vasut <marex@denx.de>, Douglas Anderson <dianders@chromium.org>, Paul Burton <paul.burton@mips.com>, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Tue, May 21, 2019 at 04:45:34PM +0200, Esben Haabendal wrote:
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:
> 
> > On Tue, May 21, 2019 at 01:34:26PM +0200, Esben Haabendal wrote:
> >> Allow getting memory resource (mapbase or iobase) as well as irq from
> >> platform_device resources.
> >> 
> >> The UPF_DEV_RESOURCES flag must be set for devices where platform_device
> >> resources are to be used.  When not set, driver behaves as before.
> >
> > Nothing actually sets this flag in this patch, so I can't take this as
> > you are adding new features that no one uses :(
> >
> > Where is the driver that sets this?
> 
> It sits here.

Where is "here"?

> It is a rather big and clunky mfd driver, not ready for
> upstreaming in its current form.  I hope to get around to clean it up.
> But it is for a very specific hardware that is really available or
> usable for anybody else.  Does it make sense to spend effort on
> submitting such a driver?

I can not take kernel apis/features being added for no in-kernel user,
that's just how Linux kernel development works.  I'll be glad to review
this if we have an actual user for this code, but it also needs to be
submitted at the same time.

That's how we have always worked, nothing new here :)

thanks,

greg k-h
