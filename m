From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 1/2] tty: serial: remove __init on pl011 console ops
Date: Wed, 13 Feb 2013 22:52:21 +0000
Message-ID: <20130213225221.GE17833@n2100.arm.linux.org.uk>
References: <1360151235-11980-1-git-send-email-haojian.zhuang@linaro.org> <20130206115219.GE17833@n2100.arm.linux.org.uk> <CAD6h2NSpo74UXUgH2OJniW=wzkxGeshta05AGgCpn26SCUSjYg@mail.gmail.com> <CACRpkdZX-YF+jzg453Vmfxo_2LLuASvZyQqLommaM4Xd3LpwfQ@mail.gmail.com> <20130206163811.GI17833@n2100.arm.linux.org.uk> <CAD6h2NS6bJS1KZfZ-3SGy6AR68Vn4fkR=TgwTEu50G_edfCP1w@mail.gmail.com> <CACxGe6t94S=kkfCkasO+ze35M-H06+WCA-J93BZaJfCzhWfoEQ@mail.gmail.com> <20130209224138.GI17833@n2100.arm.linux.org.uk> <20130213210459.D8F693E3557@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:42529 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965005Ab3BMW6X (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 13 Feb 2013 17:58:23 -0500
Content-Disposition: inline
In-Reply-To: <20130213210459.D8F693E3557@localhost>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: Haojian Zhuang <haojian.zhuang@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, jslaby@suse.cz, Anton Vorontsov <anton.vorontsov@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <alan@linux.intel.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Patch Tracking <patches@linaro.org>

On Wed, Feb 13, 2013 at 09:04:59PM +0000, Grant Likely wrote:
> On Sat, 9 Feb 2013 22:41:38 +0000, Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> > On Sat, Feb 09, 2013 at 10:31:05PM +0000, Grant Likely wrote:
> > > If it is a probe function, then yes the __init annotations need to be
> > > removed or the driver needs to use platform_driver_probe(). This has
> > > been the model as long as I can remember. As long as a driver has a
> > > .probe hook, the driver core can call it at any time. Deferred probe
> > > has only exposed the issue.
> > > 
> > > If you want to discard the .probe() hook, then the probe() pointer
> > > needs to be cleared from the driver structure before discarding the
> > > sections. Otherwise the driver core can still call it which is what
> > > happens in deferred probe and can happen if a device gets unbound from
> > > a driver and then re-attached.
> > 
> > You're talking about something completely different on the assumption
> > that what is being talked about is the probe hook.  It isn't.  It's
> > a path for the console initialization which has _always_ been __init
> > marked since the dawn of time, because modules are not supposed to
> > be calling that path.
> 
> Sorry, you're right. Hitting reply too quickly I guess.
> 
> However, the point still stands that anything that can be called from
> a .probe() path cannot be in an __init section with the current driver
> model. A driver can even be unbound from a device and reattached at
> runtime. That would also cause problems.

However, it reveals much bigger problems - that is, if you defer the
probe of the console, what happens when we need to open the console...

Although you can say that, there's _much_ bigger problems here if you
delay console initialization - you'll effectively end up calling init
with no system console in place, which means you'll see no output from
init until the deferred probe sorts itself out.

Yes, it's an unintended side effect of deferred probing, but nevertheless
one which needs to be resolved such that the console _is_ initialized
before it's required, which happens _before_ the init section is
discarded.
