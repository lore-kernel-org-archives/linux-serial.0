From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Subject: Re: [PATCH v2 00/19] Dynamically load/remove serdev devices via sysfs*
Date: Thu, 14 Jun 2018 16:06:18 +0200
Message-ID: <CAPybu_3=KhPB_ymtRNSZfcyP57LPD2SbLUPoFO0YdjkzAsdaTA@mail.gmail.com>
References: <20180611115240.32606-1-ricardo.ribalda@gmail.com>
 <20180614104820.GC32411@localhost> <CAPybu_0TSdQFOL1ptv67-aKktAftYWPwnSnevmBd_b1T0W7LYg@mail.gmail.com>
 <20180614133341.GD32411@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180614133341.GD32411@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: Johan Hovold <johan@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, Rob Herring <robh@kernel.org>, Andy Shevchenko <andy.shevchenko@gmail.com>
List-Id: linux-serial@vger.kernel.org

Hi Johan,
On Thu, Jun 14, 2018 at 3:34 PM Johan Hovold <johan@kernel.org> wrote:
>
> On Thu, Jun 14, 2018 at 01:06:59PM +0200, Ricardo Ribalda Delgado wrote:
> > Hi Johan
> > On Thu, Jun 14, 2018 at 12:48 PM Johan Hovold <johan@kernel.org> wrote:
> > >
> > > Hi Ricardo,
> > >
> > > On Mon, Jun 11, 2018 at 01:52:16PM +0200, Ricardo Ribalda Delgado wrote:
> > > > There are some situations where it is interesting to load/remove serdev
> > > > devices dynamically, like during board bring-up or when we are
> > > > developing a new driver or for devices that are neither described via
> > > > ACPI or device tree.
> > >
> > > First of all, this would be more appropriately labeled an RFC as this is
> > > far from being in a mergeable state. Besides some implementation issues,
> > > we need to determine if this approach is at all viable.
> >
> > From previous conversations with Greg it seemed that RFC labels was
> > something to avoid, but I do not mind reseding it as RFC on v3.
> >
> > http://lists.kernelnewbies.org/pipermail/kernelnewbies/2018-March/018844.html
>
> Yeah, Greg uses that to triage his insane workload, but RFCs still have
> their use (and are still mentioned in submitting-patches.rst).
>
> > > Second, I wonder how you tested this given that this series breaks RX
> > > (and write-wakeup signalling) for serial ports (patch 19/24)?
> >
> > I have a serdev device (led ctrls) that is dynamically enumerated with
> > something very similar to:
> >
> > https://github.com/ribalda/linux/commit/415bb3f0076c2b846ebe5409589b8e1e3004f55a
> >
> > and then I have a script that does adds and removes. For standard
> > serial port I was not testing the data path, just that the ttyS* was
> > enumerated fine.
>
> Well there's more to serial ports than just enumeration, you typically
> want to send and receive data as well. ;)
>
> > But  yesterday I believe that we found the bug that you mentioned and
> > we have fixed it (check end of mail). I will patch the series and
> > resend after I get more feedback and also implement what Marcel
> > suggested.
> >
> > WIP is at
> > https://github.com/ribalda/linux/tree/serdev3
> >
> > Besides this bug, we have used the new driver for over a week now with
> > no issues.
>
> Hmm... No issues when not testing the main functionality of serial
> ports, you mean?
>
> And there are more issues with the series which are less apparent than
> the rx (and partial tx) regression.

Any hints about this? What else should I change on the series?

>
> > > Third, and as Marcel already suggested, you need to limit your scope
> > > here. Aim at ten patches or so, and use a representative serdev driver
> > > as an example of the kind of driver updates that would be needed. It
> > > also looks like some patches should be squashed (e.g. the ones
> > > introducing new fields and the first one actually using them).
> >
> > >
> > > > This implementation allows the creation of serdev devices via sysfs,
> > > > in a similar way as the i2c bus allows sysfs instantiation [1].
> > >
> > > Note that this is a legacy interface and not necessarily something that
> > > new interfaces should be modelled after.
> >
> > I would not consider it legacy, it is the only way to use an i2c
> > module without writing your own driver and/or modifying ACPI/DT table.
>
> It's legacy as in old, and to be used for one-off hacks and such. But
> sure, that is also what this series aims at even if that doesn't mean
> you *have to* copy the interface.

It is not only one-off hack. It is the ONLY way to use i2c devices
that are not enumerated.

The same way as today we do not have any way of using serdev on non
enumerated devices.

>
> > Author: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
> > Date:   Thu Jun 14 11:30:27 2018 +0200
> >
> >     serdev-ttydev: Restore/change ttyport client ops
>
> Yep, you found the source of the broken serial port rx/tx.
>
> Johan



--
Ricardo Ribalda
