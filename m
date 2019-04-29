From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH 1/2] serial: 8250: Allow port registration without
 UPF_BOOT_AUTOCONF
Date: Mon, 29 Apr 2019 16:35:35 +0300
Message-ID: <20190429133535.GG9224@smile.fi.intel.com>
References: <20190426084038.6377-1-esben@geanix.com>
 <20190426084038.6377-2-esben@geanix.com>
 <20190426143946.GX9224@smile.fi.intel.com>
 <871s1og11u.fsf@haabendal.dk>
 <20190426215103.GD9224@smile.fi.intel.com>
 <87tvejakot.fsf@haabendal.dk>
 <CAHp75VfZMuQ3xagGSt6dXv1tZbSfanUdaw0SgjTqq3YET5YBKQ@mail.gmail.com>
 <87y33tz5oz.fsf@haabendal.dk>
 <CAHp75Vc6cLnLztXtvTcWisjAqDUTEWBBgv20CA34ZQmBEAvpbA@mail.gmail.com>
 <87ef5lxiqm.fsf@haabendal.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87ef5lxiqm.fsf@haabendal.dk>
Sender: linux-kernel-owner@vger.kernel.org
To: Esben Haabendal <esben@haabendal.dk>
Cc: "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Darwin Dingel <darwin.dingel@alliedtelesis.co.nz>, He Zhe <zhe.he@windriver.com>, Jisheng Zhang <Jisheng.Zhang@synaptics.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Mon, Apr 29, 2019 at 11:29:05AM +0200, Esben Haabendal wrote:
> Andy Shevchenko <andy.shevchenko@gmail.com> writes:
> > On Mon, Apr 29, 2019 at 9:27 AM Esben Haabendal <esben@haabendal.dk> wrote:
> >> Andy Shevchenko <andy.shevchenko@gmail.com> writes:
> >> > On Sat, Apr 27, 2019 at 12:01 PM Esben Haabendal <esben@haabendal.dk> wrote:
> >> >> Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:
> >> >> > On Fri, Apr 26, 2019 at 06:54:05PM +0200, Esben Haabendal wrote:
> >> >> >> Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:

> So maybe we should go down that direction intead, extending 8250 driver
> to replace mapbase with a resource struct instead?
> 
> > Btw, we have PCI MFD driver which enumerates 8250 (more precisely
> > 8250_dw) w/o any issues.
> 
> I am aware of that (sm501.c).  It avoids the problem by not requesting
> the parent memory region (sm->io_res), and requesting all child memory
> regions directly in root instead of relative to the sm->io_res parent.
> 
> But as resoure management is designed for managing a parent/child
> resource tree, this looks much more like a workaround than the right
> solution.
> 
> >> It would be nice if child drivers requesting memory would pass the
> >> parent memory resource.  Maybe 8250 driver could be changed to accept a
> >> struct resource pointer instead of a simple mapbase value, allowing to
> >> setup the resource with parent pointing to the MFD memory resource.
> >
> > I don't see the problem in certain driver, I guess you are trying to
> > workaround existin Linux device resource model.
> 
> No, I actually try to do the right thing in relation to Linux device
> resource model.  But 8250 is just not behaving very well in that
> respect, not having been made really aware of the resource model.

The point here is that. MFD driver can re-use existing platform drivers which
may be used standalone. They and only they are the right owners of the
requesting *their* resources.

When parent request resources on the behalf of its child it simple will break
this flexibility.

-- 
With Best Regards,
Andy Shevchenko
