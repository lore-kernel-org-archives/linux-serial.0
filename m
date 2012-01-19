From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH 3/3] serial: 8250: Add a wakeup_capable module param
Date: Thu, 19 Jan 2012 11:13:37 -0800
Message-ID: <20120119191337.GB2373@linux.vnet.ibm.com>
References: <1326826563-32215-1-git-send-email-sjg@chromium.org>
 <CAPnjgZ1g0Gf8ZCavAbmxjJXxxk9duf1ybbEUNo9L-DHBxyXx-g@mail.gmail.com>
 <20120118224304.GJ2431@linux.vnet.ibm.com>
 <201201190102.58788.rjw@sisk.pl>
 <20120119013731.GK2431@linux.vnet.ibm.com>
 <CAPnjgZ1zFHzihG51qHM-dk5Ou5vig0JL62LNFATmDwbQo_r+FQ@mail.gmail.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from e39.co.us.ibm.com ([32.97.110.160]:37358 "EHLO
	e39.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932623Ab2ASTNx (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 19 Jan 2012 14:13:53 -0500
Received: from /spool/local
	by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-serial@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
	Thu, 19 Jan 2012 12:13:52 -0700
Content-Disposition: inline
In-Reply-To: <CAPnjgZ1zFHzihG51qHM-dk5Ou5vig0JL62LNFATmDwbQo_r+FQ@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Simon Glass <sjg@chromium.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Alan Cox <alan@lxorguk.ukuu.org.uk>, LKML <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@suse.de>, linux-serial@vger.kernel.org

On Wed, Jan 18, 2012 at 06:35:56PM -0800, Simon Glass wrote:
> Hi Paul,
>=20
> On Wed, Jan 18, 2012 at 5:37 PM, Paul E. McKenney
> <paulmck@linux.vnet.ibm.com> wrote:
> > On Thu, Jan 19, 2012 at 01:02:58AM +0100, Rafael J. Wysocki wrote:
> >> On Wednesday, January 18, 2012, Paul E. McKenney wrote:
> >> > On Wed, Jan 18, 2012 at 02:15:59PM -0800, Simon Glass wrote:
> >> > > Hi Paul,
> >> > >
> >> > > On Wed, Jan 18, 2012 at 1:42 PM, Paul E. McKenney
> >> > > <paulmck@linux.vnet.ibm.com> wrote:
> >> > > > On Wed, Jan 18, 2012 at 01:08:13PM -0800, Simon Glass wrote:
> >> > > >> [+cc Rafael J. Wysocki <rjw@sisk.pl> who I think wrote the =
wakeup.c code]
> >> > > >>
> >> > > >> Hi Alan, Paul,
> >> > > >>
> >> > > >> On Tue, Jan 17, 2012 at 8:17 PM, Paul E. McKenney
> >> > > >> <paulmck@linux.vnet.ibm.com> wrote:
> >> > > >> > On Tue, Jan 17, 2012 at 08:10:36PM +0000, Alan Cox wrote:
> >> > > >> >> On Tue, 17 Jan 2012 10:56:03 -0800
> >> > > >> >> Simon Glass <sjg@chromium.org> wrote:
> >> > > >> >>
> >> > > >> >> > Since serial_core now does not make serial ports wake-=
up capable by
> >> > > >> >> > default, add a parameter to support this feature in th=
e 8250 UART.
> >> > > >> >> > This is the only UART where I think this feature is us=
eful.
> >> > > >> >>
> >> > > >> >> NAK
> >> > > >> >>
> >> > > >> >> Things should just work for users. Magic parameters is n=
ot an
> >> > > >> >> improvement. If its a performance problem someone needs =
to fix the rcu
> >> > > >> >> sync overhead or stop using rcu on that path.
> >> > > >>
> >> > > >> OK fair enough, I agree. Every level I move down the source=
 tree
> >> > > >> affects more people though.
> >> > > >>
> >> > > >> >
> >> > > >> > I must say that I lack context here, even after looking a=
t the patch,
> >> > > >> > but the synchronize_rcu_expedited() primitives can be use=
d if the latency
> >> > > >> > of synchronize_rcu() is too large.
> >> > > >> >
> >> > > >>
> >> > > >> Let me provide a bit of context. The serial_core code seems=
 to be the
> >> > > >> only place in the kernel that does this:
> >> > > >>
> >> > > >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 device_init_wakeup(tty_dev, 1);
> >> > > >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 device_set_wakeup_enable(tty_de=
v, 0);
> >> > > >>
> >> > > >> The first call makes the device wakeup capable and enables =
wakeup, The
> >> > > >> second call disabled wakeup.
> >> > > >>
> >> > > >> The code that removes the wakeup source looks like this:
> >> > > >>
> >> > > >> void wakeup_source_remove(struct wakeup_source *ws)
> >> > > >> {
> >> > > >> =A0 =A0 =A0 if (WARN_ON(!ws))
> >> > > >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> >> > > >>
> >> > > >> =A0 =A0 =A0 spin_lock_irq(&events_lock);
> >> > > >> =A0 =A0 =A0 list_del_rcu(&ws->entry);
> >> > > >> =A0 =A0 =A0 spin_unlock_irq(&events_lock);
> >> > > >> =A0 =A0 =A0 synchronize_rcu();
> >> > > >> }
> >> > > >>
> >> > > >> The sync is there because we are about to destroy the actua=
l ws
> >> > > >> structure (in wakeup_source_destroy()). I wonder if it shou=
ld be in
> >> > > >> wakeup_source_destroy() but that wouldn't help me anyway.
> >> > > >>
> >> > > >> synchronize_rcu_expedited() is a bit faster but not really =
fast
> >> > > >> enough. Anyway surely people will complain if I put this in=
 the wakeup
> >> > > >> code - it will affect all wakeup users. It seems to me that=
 the right
> >> > > >> solution is to avoid enabling and then immediately disablin=
g wakeup.
> >> > > >
> >> > > > Hmmm... =A0What hardware are you running this one? =A0Normal=
ly,
> >> > > > synchronize_rcu_expedited() will be a couple of orders of ma=
gnitude
> >> > > > faster than synchronize_rcu().
> >> > > >
> >> > > >> I assume we can't and shouldn't change device_init_wakeup()=
 . We could
> >> > > >> add a call like device_init_wakeup_disabled() which makes t=
he device
> >> > > >> wakeup capable but does not actually enable it. Does that w=
ork?
> >> > > >
> >> > > > If the only reason for the synchronize_rcu() is to defer the=
 pair of
> >> > > > kfree()s in wakeup_source_destroy(), then another possible a=
pproach
> >> > > > would be to remove the synchronize_rcu() from wakeup_source_=
remove()
> >> > > > and then use call_rcu() to defer the two kfree()s.
> >> > > >
> >> > > > If this is a reasonable change to make, the approach is as f=
ollows:
> >> > > >
> >> > > > 1. =A0 =A0 =A0Add a struct rcu_head to wakeup_source, call i=
t "rcu".
> >> > > > =A0 =A0 =A0 =A0Or adjust the following to suit your choice o=
f name.
> >> > > >
> >> > > > 2. =A0 =A0 =A0Replace the pair of kfree()s with:
> >> > > >
> >> > > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0call_rcu(&ws->rcu, wakeup_sou=
rce_destroy_rcu);
> >> > > >
> >> > > > 3. =A0 =A0 =A0Create the wakeup_source_destroy_rcu() as foll=
ows:
> >> > > >
> >> > > > =A0 =A0 =A0 =A0static void wakeup_source_destroy_rcu(struct =
rcu_head *head)
> >> > > > =A0 =A0 =A0 =A0{
> >> > > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct wakeup_source *ws =3D
> >> > > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0container_of(=
head, struct wakeup_source, rcu);
> >> > > >
> >> > > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0kfree(ws->name);
> >> > > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0kfree(ws);
> >> > > > =A0 =A0 =A0 =A0}
> >> > > >
> >> > > > Of course, this assumes that it is OK for wakeup_source_unre=
gister()
> >> > > > to return before the memory is freed up. =A0This often is OK=
, but there
> >> > > > are some cases where the caller requires that there be no fu=
rther
> >> > > > RCU readers with access to the old data. =A0In these cases, =
you really
> >> > > > do need the wait.
> >> > >
> >> > > Thanks very much for that. I'm not sure if it is a reasonable =
change,
> >> > > but it does bug me that we add it to a data structure knowing =
that we
> >> > > will immediately remove it!
> >> > >
> >> > > >From what I can see, making a device wakeup-enabled mostly ha=
ppens on
> >> > > init or in response to a request to the driver (presumably fro=
m user
> >> > > space). In the latter case I suspect the synchronise_rcu() is =
fine. In
> >> > > the former it feels like we should make up our minds which of =
the
> >> > > three options is required (incapable, capable but not enabled,=
 capable
> >> > > and enabled).
> >> > >
> >> > > I will try a patch first based on splitting the two options (c=
apable
> >> > > and enable) and see if that get a NAK.
> >> > >
> >> > > Then I will come back to your solution - it seems fine to me a=
nd not a
> >> > > lot of code. Do we have to worry about someone enabling, disab=
led,
> >> > > enabling and then disabling wakeup quickly? Will this method b=
reak in
> >> > > that case if the second call to call_rcu() uses the same wc->r=
cu?
> >> >
> >> > There are a couple of questions here, let me take them one at a =
time:
> >> >
> >> > 1. =A0If you just disabled, can you immediately re-enable?
> >> >
> >> > =A0 =A0 The answer is "yes". =A0The reason that this works is th=
at you
> >> > =A0 =A0 allocate a new structure for the re-enabling, and that n=
ew
> >> > =A0 =A0 structure has its own rcu_head field.
> >> >
> >> > 2. =A0If you repeatedly disable and re-enable in a tight loop,
> >> > =A0 =A0 can this cause problems?
> >> >
> >> > =A0 =A0 The answer to this is also "yes" -- you can run the syst=
em
> >> > =A0 =A0 out of memory doing that. =A0However, there are a number=
 of
> >> > =A0 =A0 simple ways to avoid this problem:
> >> >
> >> > =A0 =A0 a. =A0 =A0 =A0Do a synchronize_rcu() on every (say) thou=
sandth
> >> > =A0 =A0 =A0 =A0 =A0 =A0 disable operation.
> >> >
> >> > =A0 =A0 b. =A0 =A0 =A0As above, but only do the synchronize_rcu(=
) if
> >> > =A0 =A0 =A0 =A0 =A0 =A0 all 1,000 disable operations occurred wi=
thin
> >> > =A0 =A0 =A0 =A0 =A0 =A0 (say) a second of each other.
> >> >
> >> > =A0 =A0 c. =A0 =A0 =A0As above, but actually count the number of
> >> > =A0 =A0 =A0 =A0 =A0 =A0 pending call_rcu() callbacks.
> >> >
> >> > =A0 =A0 Both (a) and (b) can be carried out on a per-CPU basis i=
f there
> >> > =A0 =A0 is no convenient locked structure in which to track the =
state.
> >> > =A0 =A0 You cannot carry (c) out on a per-CPU basis because RCU =
callbacks
> >> > =A0 =A0 can sometimes be invoked on a different CPU from the one=
 that
> >> > =A0 =A0 call_rcu()ed them. =A0Rare, but it can happen.
> >> >
> >> > =A0 =A0 I would expect that option (a) would work in almost all =
cases.
> >> >
> >> > If this can be exercised freely from user space, then you probab=
ly
> >> > really do need #2 above.
> >>
> >> Yes, you can, but then I'd say it's not necessary for user space t=
o
> >> be able to carry that out in a tight loop. =A0So, it seems, altern=
atively,
> >> we could make that loop a bit less tight, e.g. by adding an arbitr=
ary
> >> sleep to the user space interface for the "disable" case.
> >
> > Good point, that would work just as well and be simpler.
>=20
> OK, well I am expecting that this will now be a very small patch to
> change just serial_core.
>=20
> Thanks for your help with this.

Glad to help, and even more glad that Alan and Rafael were able to help=
=2E  ;-)

							Thanx, Paul

--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
