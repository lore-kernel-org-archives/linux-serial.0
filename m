From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH 3/3] serial: 8250: Add a wakeup_capable module param
Date: Wed, 18 Jan 2012 14:43:04 -0800
Message-ID: <20120118224304.GJ2431@linux.vnet.ibm.com>
References: <1326826563-32215-1-git-send-email-sjg@chromium.org>
 <1326826563-32215-3-git-send-email-sjg@chromium.org>
 <20120117201036.6d99f98f@pyramind.ukuu.org.uk>
 <20120118041720.GA2431@linux.vnet.ibm.com>
 <CAPnjgZ1GJatR15dVsq-+hAWhD7eaLhtN737QvBaor_=0+K+6wA@mail.gmail.com>
 <20120118214215.GH2431@linux.vnet.ibm.com>
 <CAPnjgZ1g0Gf8ZCavAbmxjJXxxk9duf1ybbEUNo9L-DHBxyXx-g@mail.gmail.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from e32.co.us.ibm.com ([32.97.110.150]:39475 "EHLO
	e32.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754635Ab2ARWoN (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 18 Jan 2012 17:44:13 -0500
Received: from /spool/local
	by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-serial@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
	Wed, 18 Jan 2012 15:44:12 -0700
Content-Disposition: inline
In-Reply-To: <CAPnjgZ1g0Gf8ZCavAbmxjJXxxk9duf1ybbEUNo9L-DHBxyXx-g@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Simon Glass <sjg@chromium.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, LKML <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@suse.de>, linux-serial@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>

On Wed, Jan 18, 2012 at 02:15:59PM -0800, Simon Glass wrote:
> Hi Paul,
>=20
> On Wed, Jan 18, 2012 at 1:42 PM, Paul E. McKenney
> <paulmck@linux.vnet.ibm.com> wrote:
> > On Wed, Jan 18, 2012 at 01:08:13PM -0800, Simon Glass wrote:
> >> [+cc Rafael J. Wysocki <rjw@sisk.pl> who I think wrote the wakeup.=
c code]
> >>
> >> Hi Alan, Paul,
> >>
> >> On Tue, Jan 17, 2012 at 8:17 PM, Paul E. McKenney
> >> <paulmck@linux.vnet.ibm.com> wrote:
> >> > On Tue, Jan 17, 2012 at 08:10:36PM +0000, Alan Cox wrote:
> >> >> On Tue, 17 Jan 2012 10:56:03 -0800
> >> >> Simon Glass <sjg@chromium.org> wrote:
> >> >>
> >> >> > Since serial_core now does not make serial ports wake-up capa=
ble by
> >> >> > default, add a parameter to support this feature in the 8250 =
UART.
> >> >> > This is the only UART where I think this feature is useful.
> >> >>
> >> >> NAK
> >> >>
> >> >> Things should just work for users. Magic parameters is not an
> >> >> improvement. If its a performance problem someone needs to fix =
the rcu
> >> >> sync overhead or stop using rcu on that path.
> >>
> >> OK fair enough, I agree. Every level I move down the source tree
> >> affects more people though.
> >>
> >> >
> >> > I must say that I lack context here, even after looking at the p=
atch,
> >> > but the synchronize_rcu_expedited() primitives can be used if th=
e latency
> >> > of synchronize_rcu() is too large.
> >> >
> >>
> >> Let me provide a bit of context. The serial_core code seems to be =
the
> >> only place in the kernel that does this:
> >>
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 device_init_wakeup(tty_dev, 1);
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 device_set_wakeup_enable(tty_dev, 0);
> >>
> >> The first call makes the device wakeup capable and enables wakeup,=
 The
> >> second call disabled wakeup.
> >>
> >> The code that removes the wakeup source looks like this:
> >>
> >> void wakeup_source_remove(struct wakeup_source *ws)
> >> {
> >> =A0 =A0 =A0 if (WARN_ON(!ws))
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> >>
> >> =A0 =A0 =A0 spin_lock_irq(&events_lock);
> >> =A0 =A0 =A0 list_del_rcu(&ws->entry);
> >> =A0 =A0 =A0 spin_unlock_irq(&events_lock);
> >> =A0 =A0 =A0 synchronize_rcu();
> >> }
> >>
> >> The sync is there because we are about to destroy the actual ws
> >> structure (in wakeup_source_destroy()). I wonder if it should be i=
n
> >> wakeup_source_destroy() but that wouldn't help me anyway.
> >>
> >> synchronize_rcu_expedited() is a bit faster but not really fast
> >> enough. Anyway surely people will complain if I put this in the wa=
keup
> >> code - it will affect all wakeup users. It seems to me that the ri=
ght
> >> solution is to avoid enabling and then immediately disabling wakeu=
p.
> >
> > Hmmm... =A0What hardware are you running this one? =A0Normally,
> > synchronize_rcu_expedited() will be a couple of orders of magnitude
> > faster than synchronize_rcu().
> >
> >> I assume we can't and shouldn't change device_init_wakeup() . We c=
ould
> >> add a call like device_init_wakeup_disabled() which makes the devi=
ce
> >> wakeup capable but does not actually enable it. Does that work?
> >
> > If the only reason for the synchronize_rcu() is to defer the pair o=
f
> > kfree()s in wakeup_source_destroy(), then another possible approach
> > would be to remove the synchronize_rcu() from wakeup_source_remove(=
)
> > and then use call_rcu() to defer the two kfree()s.
> >
> > If this is a reasonable change to make, the approach is as follows:
> >
> > 1. =A0 =A0 =A0Add a struct rcu_head to wakeup_source, call it "rcu"=
=2E
> > =A0 =A0 =A0 =A0Or adjust the following to suit your choice of name.
> >
> > 2. =A0 =A0 =A0Replace the pair of kfree()s with:
> >
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0call_rcu(&ws->rcu, wakeup_source_des=
troy_rcu);
> >
> > 3. =A0 =A0 =A0Create the wakeup_source_destroy_rcu() as follows:
> >
> > =A0 =A0 =A0 =A0static void wakeup_source_destroy_rcu(struct rcu_hea=
d *head)
> > =A0 =A0 =A0 =A0{
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct wakeup_source *ws =3D
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0container_of(head, s=
truct wakeup_source, rcu);
> >
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0kfree(ws->name);
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0kfree(ws);
> > =A0 =A0 =A0 =A0}
> >
> > Of course, this assumes that it is OK for wakeup_source_unregister(=
)
> > to return before the memory is freed up. =A0This often is OK, but t=
here
> > are some cases where the caller requires that there be no further
> > RCU readers with access to the old data. =A0In these cases, you rea=
lly
> > do need the wait.
>=20
> Thanks very much for that. I'm not sure if it is a reasonable change,
> but it does bug me that we add it to a data structure knowing that we
> will immediately remove it!
>=20
> >From what I can see, making a device wakeup-enabled mostly happens o=
n
> init or in response to a request to the driver (presumably from user
> space). In the latter case I suspect the synchronise_rcu() is fine. I=
n
> the former it feels like we should make up our minds which of the
> three options is required (incapable, capable but not enabled, capabl=
e
> and enabled).
>=20
> I will try a patch first based on splitting the two options (capable
> and enable) and see if that get a NAK.
>=20
> Then I will come back to your solution - it seems fine to me and not =
a
> lot of code. Do we have to worry about someone enabling, disabled,
> enabling and then disabling wakeup quickly? Will this method break in
> that case if the second call to call_rcu() uses the same wc->rcu?

There are a couple of questions here, let me take them one at a time:

1.	If you just disabled, can you immediately re-enable?

	The answer is "yes".  The reason that this works is that you
	allocate a new structure for the re-enabling, and that new
	structure has its own rcu_head field.

2.	If you repeatedly disable and re-enable in a tight loop,
	can this cause problems?

	The answer to this is also "yes" -- you can run the system
	out of memory doing that.  However, there are a number of
	simple ways to avoid this problem:

	a.	Do a synchronize_rcu() on every (say) thousandth
		disable operation.

	b.	As above, but only do the synchronize_rcu() if
		all 1,000 disable operations occurred within
		(say) a second of each other.

	c.	As above, but actually count the number of
		pending call_rcu() callbacks.

	Both (a) and (b) can be carried out on a per-CPU basis if there
	is no convenient locked structure in which to track the state.
	You cannot carry (c) out on a per-CPU basis because RCU callbacks
	can sometimes be invoked on a different CPU from the one that
	call_rcu()ed them.  Rare, but it can happen.

	I would expect that option (a) would work in almost all cases.

If this can be exercised freely from user space, then you probably
really do need #2 above.

						Thanx, Paul

> Regards,
> Simon
> >
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Thanx, Paul
> >
>=20

--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
