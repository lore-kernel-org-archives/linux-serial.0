From: Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH v2 00/19] Dynamically load/remove serdev devices via
 sysfs*
Date: Thu, 14 Jun 2018 17:47:25 +0200
Message-ID: <20180614154725.GF32411@localhost>
References: <20180611115240.32606-1-ricardo.ribalda@gmail.com>
 <20180614104820.GC32411@localhost>
 <CAPybu_0TSdQFOL1ptv67-aKktAftYWPwnSnevmBd_b1T0W7LYg@mail.gmail.com>
 <20180614133341.GD32411@localhost>
 <CAPybu_3=KhPB_ymtRNSZfcyP57LPD2SbLUPoFO0YdjkzAsdaTA@mail.gmail.com>
 <20180614145531.GE32411@localhost>
 <CAPybu_1ps+tEr5W_uvMSeH4_gwbjgKHnz0MoSEJO=Ut0a4sx6Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAPybu_1ps+tEr5W_uvMSeH4_gwbjgKHnz0MoSEJO=Ut0a4sx6Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Cc: Johan Hovold <johan@kernel.org>, LKML <linux-kernel@vger.kernel.org>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, Rob Herring <robh@kernel.org>, Andy Shevchenko <andy.shevchenko@gmail.com>
List-Id: linux-serial@vger.kernel.org

On Thu, Jun 14, 2018 at 05:20:40PM +0200, Ricardo Ribalda Delgado wrote:
> Hi Johan,
> On Thu, Jun 14, 2018 at 4:55 PM Johan Hovold <johan@kernel.org> wrote:
> >
> > On Thu, Jun 14, 2018 at 04:06:18PM +0200, Ricardo Ribalda Delgado wrote:
> > > Hi Johan,
> > > On Thu, Jun 14, 2018 at 3:34 PM Johan Hovold <johan@kernel.org> wrote:
> >
> > > > And there are more issues with the series which are less apparent than
> > > > the rx (and partial tx) regression.
> > >
> > > Any hints about this? What else should I change on the series?
> >
> > There are implementation issues and there's the more fundamental
> > question about whether your approach to this is the right one.
> >
> > Like Rob, I'm not sure we want to have the device topology depend on a
> > kernel config symbol (serdev and your ttydev driver). We may need to
> > explore Rob's sibling-device idea further.
> 
> From my point of view, if the user enables serdev, then everything has
> to be a serdev, because serdev does not provide the same functionality
> as a core tty device I had to implement, serdev-ttydev.c. Which is
> nothing more than a wrapper.
> 
> It is very hacky, but allows replacing the core tty device with
> another serdev.

Yes, and I'm a bit surprised (and impressed) that you got it to work
(mostly) so easily.

My point was that we probably don't want the tty devices to move around
in the device hierarchy depending on if serdev (and your ttydev driver)
is enabled or not.

> > I also want to make sure that this can be used for discoverable buses
> > (e.g. the USB CEC device the I've used as an example before).
> >
> 
> I have tried your patch:
> 
> https://github.com/ribalda/linux/commit/5cb30b4ce6477132a23492c674d8b3dc81ecff86
> 
> the only issue is that the serdev device sometimes explotes (OOPS)
> when the usb is unplugged :S.
> 
> And that might be quite tricy to solve

Yes, we all know serdev doesn't support hotplug, that's why it's not
enabled for usbserial.

But when/if we get that sorted, we may want to be able to reuse some of
the matching infrastructure that a sysfs interface would use also for
discoverable buses (e.g. passing a compatible string to serdev core).

Also note that the interface you're proposing suffers from similar
problems as hotplug in that serdev drivers must be prepared to handle
devices going away at anytime; be it through your delete_device
interface or from a sysfs driver unbind (i.e. already an issue today!).

This would be were the oops comes from.

> > As for the current implementation there are both larger and smaller
> > issues, like for example:
> >
> >  - the fact that your sysfs and lookup interface does not use any
> >    locking whatsoever and thus is susceptible to races
> 
> I thought that sysfs access where serialised. If that is not the case
> yes, we need a lock.

It's only serialised per attribute.

> >  - your ttyport driver currently breaks the sysfs interface for all
> >    serial (core) devices by ignoring the attribute groups
> 
> Yep, you are right, I screwed up that one :).

Easy to miss.

> >  - the ttyport driver is arguably a hack with layering issues (which
> >    admittedly may be hard to avoid given the retrofitting of serdev into
> >    the tty layer)
> >
> > Again, I suggest you submit a subset of your series (aim at 10 patches
> > or so) as an RFC which can be used as a basis for further discussion. No
> > point in discussing every implementation detail if the underlying
> > approach needs to be revised.
> 
> Will do. Give me some time to give it a hand of paint.
> 
> Thanks for time reviewing my little moster

You're welcome.

Johan
