From: Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH v2 00/19] Dynamically load/remove serdev devices via
 sysfs*
Date: Thu, 14 Jun 2018 16:55:31 +0200
Message-ID: <20180614145531.GE32411@localhost>
References: <20180611115240.32606-1-ricardo.ribalda@gmail.com>
 <20180614104820.GC32411@localhost>
 <CAPybu_0TSdQFOL1ptv67-aKktAftYWPwnSnevmBd_b1T0W7LYg@mail.gmail.com>
 <20180614133341.GD32411@localhost>
 <CAPybu_3=KhPB_ymtRNSZfcyP57LPD2SbLUPoFO0YdjkzAsdaTA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAPybu_3=KhPB_ymtRNSZfcyP57LPD2SbLUPoFO0YdjkzAsdaTA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Cc: Johan Hovold <johan@kernel.org>, LKML <linux-kernel@vger.kernel.org>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, Rob Herring <robh@kernel.org>, Andy Shevchenko <andy.shevchenko@gmail.com>
List-Id: linux-serial@vger.kernel.org

On Thu, Jun 14, 2018 at 04:06:18PM +0200, Ricardo Ribalda Delgado wrote:
> Hi Johan,
> On Thu, Jun 14, 2018 at 3:34 PM Johan Hovold <johan@kernel.org> wrote:

> > And there are more issues with the series which are less apparent than
> > the rx (and partial tx) regression.
> 
> Any hints about this? What else should I change on the series?

There are implementation issues and there's the more fundamental
question about whether your approach to this is the right one.

Like Rob, I'm not sure we want to have the device topology depend on a
kernel config symbol (serdev and your ttydev driver). We may need to
explore Rob's sibling-device idea further.

I also want to make sure that this can be used for discoverable buses
(e.g. the USB CEC device the I've used as an example before).

As for the current implementation there are both larger and smaller
issues, like for example:

 - the fact that your sysfs and lookup interface does not use any
   locking whatsoever and thus is susceptible to races

 - your ttyport driver currently breaks the sysfs interface for all
   serial (core) devices by ignoring the attribute groups

 - the ttyport driver is arguably a hack with layering issues (which
   admittedly may be hard to avoid given the retrofitting of serdev into
   the tty layer)

Again, I suggest you submit a subset of your series (aim at 10 patches
or so) as an RFC which can be used as a basis for further discussion. No
point in discussing every implementation detail if the underlying
approach needs to be revised.

> > It's legacy as in old, and to be used for one-off hacks and such. But
> > sure, that is also what this series aims at even if that doesn't mean
> > you *have to* copy the interface.
> 
> It is not only one-off hack. It is the ONLY way to use i2c devices
> that are not enumerated.
> 
> The same way as today we do not have any way of using serdev on non
> enumerated devices.

You're missing the point: none of that means you have to copy the
interface.

Johan
