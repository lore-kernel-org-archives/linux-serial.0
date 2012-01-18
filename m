From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH 3/3] serial: 8250: Add a wakeup_capable module param
Date: Wed, 18 Jan 2012 13:42:15 -0800
Message-ID: <20120118214215.GH2431@linux.vnet.ibm.com>
References: <1326826563-32215-1-git-send-email-sjg@chromium.org>
 <1326826563-32215-3-git-send-email-sjg@chromium.org>
 <20120117201036.6d99f98f@pyramind.ukuu.org.uk>
 <20120118041720.GA2431@linux.vnet.ibm.com>
 <CAPnjgZ1GJatR15dVsq-+hAWhD7eaLhtN737QvBaor_=0+K+6wA@mail.gmail.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from e37.co.us.ibm.com ([32.97.110.158]:39868 "EHLO
	e37.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752112Ab2ARVmZ (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 18 Jan 2012 16:42:25 -0500
Received: from /spool/local
	by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-serial@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
	Wed, 18 Jan 2012 14:42:25 -0700
Content-Disposition: inline
In-Reply-To: <CAPnjgZ1GJatR15dVsq-+hAWhD7eaLhtN737QvBaor_=0+K+6wA@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Simon Glass <sjg@chromium.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, LKML <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@suse.de>, linux-serial@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>

On Wed, Jan 18, 2012 at 01:08:13PM -0800, Simon Glass wrote:
> [+cc Rafael J. Wysocki <rjw@sisk.pl> who I think wrote the wakeup.c c=
ode]
>=20
> Hi Alan, Paul,
>=20
> On Tue, Jan 17, 2012 at 8:17 PM, Paul E. McKenney
> <paulmck@linux.vnet.ibm.com> wrote:
> > On Tue, Jan 17, 2012 at 08:10:36PM +0000, Alan Cox wrote:
> >> On Tue, 17 Jan 2012 10:56:03 -0800
> >> Simon Glass <sjg@chromium.org> wrote:
> >>
> >> > Since serial_core now does not make serial ports wake-up capable=
 by
> >> > default, add a parameter to support this feature in the 8250 UAR=
T.
> >> > This is the only UART where I think this feature is useful.
> >>
> >> NAK
> >>
> >> Things should just work for users. Magic parameters is not an
> >> improvement. If its a performance problem someone needs to fix the=
 rcu
> >> sync overhead or stop using rcu on that path.
>=20
> OK fair enough, I agree. Every level I move down the source tree
> affects more people though.
>=20
> >
> > I must say that I lack context here, even after looking at the patc=
h,
> > but the synchronize_rcu_expedited() primitives can be used if the l=
atency
> > of synchronize_rcu() is too large.
> >
>=20
> Let me provide a bit of context. The serial_core code seems to be the
> only place in the kernel that does this:
>=20
> 		device_init_wakeup(tty_dev, 1);
> 		device_set_wakeup_enable(tty_dev, 0);
>=20
> The first call makes the device wakeup capable and enables wakeup, Th=
e
> second call disabled wakeup.
>=20
> The code that removes the wakeup source looks like this:
>=20
> void wakeup_source_remove(struct wakeup_source *ws)
> {
> 	if (WARN_ON(!ws))
> 		return;
>=20
> 	spin_lock_irq(&events_lock);
> 	list_del_rcu(&ws->entry);
> 	spin_unlock_irq(&events_lock);
> 	synchronize_rcu();
> }
>=20
> The sync is there because we are about to destroy the actual ws
> structure (in wakeup_source_destroy()). I wonder if it should be in
> wakeup_source_destroy() but that wouldn't help me anyway.
>=20
> synchronize_rcu_expedited() is a bit faster but not really fast
> enough. Anyway surely people will complain if I put this in the wakeu=
p
> code - it will affect all wakeup users. It seems to me that the right
> solution is to avoid enabling and then immediately disabling wakeup.

Hmmm...  What hardware are you running this one?  Normally,
synchronize_rcu_expedited() will be a couple of orders of magnitude
faster than synchronize_rcu().

> I assume we can't and shouldn't change device_init_wakeup() . We coul=
d
> add a call like device_init_wakeup_disabled() which makes the device
> wakeup capable but does not actually enable it. Does that work?

If the only reason for the synchronize_rcu() is to defer the pair of
kfree()s in wakeup_source_destroy(), then another possible approach
would be to remove the synchronize_rcu() from wakeup_source_remove()
and then use call_rcu() to defer the two kfree()s.

If this is a reasonable change to make, the approach is as follows:

1.	Add a struct rcu_head to wakeup_source, call it "rcu".
	Or adjust the following to suit your choice of name.

2.	Replace the pair of kfree()s with:

		call_rcu(&ws->rcu, wakeup_source_destroy_rcu);

3.	Create the wakeup_source_destroy_rcu() as follows:

	static void wakeup_source_destroy_rcu(struct rcu_head *head)
	{
		struct wakeup_source *ws =3D
			container_of(head, struct wakeup_source, rcu);

		kfree(ws->name);
		kfree(ws);
	}

Of course, this assumes that it is OK for wakeup_source_unregister()
to return before the memory is freed up.  This often is OK, but there
are some cases where the caller requires that there be no further
RCU readers with access to the old data.  In these cases, you really
do need the wait.

							Thanx, Paul

> Regards,
> Simon
>=20
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Thanx, Paul
> >
>=20

--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
