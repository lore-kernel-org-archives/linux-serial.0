From: Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH 3/3] serial: 8250: Add a wakeup_capable module param
Date: Wed, 18 Jan 2012 18:35:56 -0800
Message-ID: <CAPnjgZ1zFHzihG51qHM-dk5Ou5vig0JL62LNFATmDwbQo_r+FQ@mail.gmail.com>
References: <1326826563-32215-1-git-send-email-sjg@chromium.org>
	<CAPnjgZ1g0Gf8ZCavAbmxjJXxxk9duf1ybbEUNo9L-DHBxyXx-g@mail.gmail.com>
	<20120118224304.GJ2431@linux.vnet.ibm.com>
	<201201190102.58788.rjw@sisk.pl>
	<20120119013731.GK2431@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:57607 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753473Ab2ASCf5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 18 Jan 2012 21:35:57 -0500
Received: by obcva7 with SMTP id va7so8076240obc.19
        for <linux-serial@vger.kernel.org>; Wed, 18 Jan 2012 18:35:56 -0800 (PST)
In-Reply-To: <20120119013731.GK2431@linux.vnet.ibm.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: paulmck@linux.vnet.ibm.com
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Alan Cox <alan@lxorguk.ukuu.org.uk>, LKML <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@suse.de>, linux-serial@vger.kernel.org

Hi Paul,

On Wed, Jan 18, 2012 at 5:37 PM, Paul E. McKenney
<paulmck@linux.vnet.ibm.com> wrote:
> On Thu, Jan 19, 2012 at 01:02:58AM +0100, Rafael J. Wysocki wrote:
>> On Wednesday, January 18, 2012, Paul E. McKenney wrote:
>> > On Wed, Jan 18, 2012 at 02:15:59PM -0800, Simon Glass wrote:
>> > > Hi Paul,
>> > >
>> > > On Wed, Jan 18, 2012 at 1:42 PM, Paul E. McKenney
>> > > <paulmck@linux.vnet.ibm.com> wrote:
>> > > > On Wed, Jan 18, 2012 at 01:08:13PM -0800, Simon Glass wrote:
>> > > >> [+cc Rafael J. Wysocki <rjw@sisk.pl> who I think wrote the wa=
keup.c code]
>> > > >>
>> > > >> Hi Alan, Paul,
>> > > >>
>> > > >> On Tue, Jan 17, 2012 at 8:17 PM, Paul E. McKenney
>> > > >> <paulmck@linux.vnet.ibm.com> wrote:
>> > > >> > On Tue, Jan 17, 2012 at 08:10:36PM +0000, Alan Cox wrote:
>> > > >> >> On Tue, 17 Jan 2012 10:56:03 -0800
>> > > >> >> Simon Glass <sjg@chromium.org> wrote:
>> > > >> >>
>> > > >> >> > Since serial_core now does not make serial ports wake-up=
 capable by
>> > > >> >> > default, add a parameter to support this feature in the =
8250 UART.
>> > > >> >> > This is the only UART where I think this feature is usef=
ul.
>> > > >> >>
>> > > >> >> NAK
>> > > >> >>
>> > > >> >> Things should just work for users. Magic parameters is not=
 an
>> > > >> >> improvement. If its a performance problem someone needs to=
 fix the rcu
>> > > >> >> sync overhead or stop using rcu on that path.
>> > > >>
>> > > >> OK fair enough, I agree. Every level I move down the source t=
ree
>> > > >> affects more people though.
>> > > >>
>> > > >> >
>> > > >> > I must say that I lack context here, even after looking at =
the patch,
>> > > >> > but the synchronize_rcu_expedited() primitives can be used =
if the latency
>> > > >> > of synchronize_rcu() is too large.
>> > > >> >
>> > > >>
>> > > >> Let me provide a bit of context. The serial_core code seems t=
o be the
>> > > >> only place in the kernel that does this:
>> > > >>
>> > > >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 device_init_wakeup(tty_dev, 1);
>> > > >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 device_set_wakeup_enable(tty_dev,=
 0);
>> > > >>
>> > > >> The first call makes the device wakeup capable and enables wa=
keup, The
>> > > >> second call disabled wakeup.
>> > > >>
>> > > >> The code that removes the wakeup source looks like this:
>> > > >>
>> > > >> void wakeup_source_remove(struct wakeup_source *ws)
>> > > >> {
>> > > >> =A0 =A0 =A0 if (WARN_ON(!ws))
>> > > >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
>> > > >>
>> > > >> =A0 =A0 =A0 spin_lock_irq(&events_lock);
>> > > >> =A0 =A0 =A0 list_del_rcu(&ws->entry);
>> > > >> =A0 =A0 =A0 spin_unlock_irq(&events_lock);
>> > > >> =A0 =A0 =A0 synchronize_rcu();
>> > > >> }
>> > > >>
>> > > >> The sync is there because we are about to destroy the actual =
ws
>> > > >> structure (in wakeup_source_destroy()). I wonder if it should=
 be in
>> > > >> wakeup_source_destroy() but that wouldn't help me anyway.
>> > > >>
>> > > >> synchronize_rcu_expedited() is a bit faster but not really fa=
st
>> > > >> enough. Anyway surely people will complain if I put this in t=
he wakeup
>> > > >> code - it will affect all wakeup users. It seems to me that t=
he right
>> > > >> solution is to avoid enabling and then immediately disabling =
wakeup.
>> > > >
>> > > > Hmmm... =A0What hardware are you running this one? =A0Normally=
,
>> > > > synchronize_rcu_expedited() will be a couple of orders of magn=
itude
>> > > > faster than synchronize_rcu().
>> > > >
>> > > >> I assume we can't and shouldn't change device_init_wakeup() .=
 We could
>> > > >> add a call like device_init_wakeup_disabled() which makes the=
 device
>> > > >> wakeup capable but does not actually enable it. Does that wor=
k?
>> > > >
>> > > > If the only reason for the synchronize_rcu() is to defer the p=
air of
>> > > > kfree()s in wakeup_source_destroy(), then another possible app=
roach
>> > > > would be to remove the synchronize_rcu() from wakeup_source_re=
move()
>> > > > and then use call_rcu() to defer the two kfree()s.
>> > > >
>> > > > If this is a reasonable change to make, the approach is as fol=
lows:
>> > > >
>> > > > 1. =A0 =A0 =A0Add a struct rcu_head to wakeup_source, call it =
"rcu".
>> > > > =A0 =A0 =A0 =A0Or adjust the following to suit your choice of =
name.
>> > > >
>> > > > 2. =A0 =A0 =A0Replace the pair of kfree()s with:
>> > > >
>> > > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0call_rcu(&ws->rcu, wakeup_sourc=
e_destroy_rcu);
>> > > >
>> > > > 3. =A0 =A0 =A0Create the wakeup_source_destroy_rcu() as follow=
s:
>> > > >
>> > > > =A0 =A0 =A0 =A0static void wakeup_source_destroy_rcu(struct rc=
u_head *head)
>> > > > =A0 =A0 =A0 =A0{
>> > > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct wakeup_source *ws =3D
>> > > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0container_of(he=
ad, struct wakeup_source, rcu);
>> > > >
>> > > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0kfree(ws->name);
>> > > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0kfree(ws);
>> > > > =A0 =A0 =A0 =A0}
>> > > >
>> > > > Of course, this assumes that it is OK for wakeup_source_unregi=
ster()
>> > > > to return before the memory is freed up. =A0This often is OK, =
but there
>> > > > are some cases where the caller requires that there be no furt=
her
>> > > > RCU readers with access to the old data. =A0In these cases, yo=
u really
>> > > > do need the wait.
>> > >
>> > > Thanks very much for that. I'm not sure if it is a reasonable ch=
ange,
>> > > but it does bug me that we add it to a data structure knowing th=
at we
>> > > will immediately remove it!
>> > >
>> > > >From what I can see, making a device wakeup-enabled mostly happ=
ens on
>> > > init or in response to a request to the driver (presumably from =
user
>> > > space). In the latter case I suspect the synchronise_rcu() is fi=
ne. In
>> > > the former it feels like we should make up our minds which of th=
e
>> > > three options is required (incapable, capable but not enabled, c=
apable
>> > > and enabled).
>> > >
>> > > I will try a patch first based on splitting the two options (cap=
able
>> > > and enable) and see if that get a NAK.
>> > >
>> > > Then I will come back to your solution - it seems fine to me and=
 not a
>> > > lot of code. Do we have to worry about someone enabling, disable=
d,
>> > > enabling and then disabling wakeup quickly? Will this method bre=
ak in
>> > > that case if the second call to call_rcu() uses the same wc->rcu=
?
>> >
>> > There are a couple of questions here, let me take them one at a ti=
me:
>> >
>> > 1. =A0If you just disabled, can you immediately re-enable?
>> >
>> > =A0 =A0 The answer is "yes". =A0The reason that this works is that=
 you
>> > =A0 =A0 allocate a new structure for the re-enabling, and that new
>> > =A0 =A0 structure has its own rcu_head field.
>> >
>> > 2. =A0If you repeatedly disable and re-enable in a tight loop,
>> > =A0 =A0 can this cause problems?
>> >
>> > =A0 =A0 The answer to this is also "yes" -- you can run the system
>> > =A0 =A0 out of memory doing that. =A0However, there are a number o=
f
>> > =A0 =A0 simple ways to avoid this problem:
>> >
>> > =A0 =A0 a. =A0 =A0 =A0Do a synchronize_rcu() on every (say) thousa=
ndth
>> > =A0 =A0 =A0 =A0 =A0 =A0 disable operation.
>> >
>> > =A0 =A0 b. =A0 =A0 =A0As above, but only do the synchronize_rcu() =
if
>> > =A0 =A0 =A0 =A0 =A0 =A0 all 1,000 disable operations occurred with=
in
>> > =A0 =A0 =A0 =A0 =A0 =A0 (say) a second of each other.
>> >
>> > =A0 =A0 c. =A0 =A0 =A0As above, but actually count the number of
>> > =A0 =A0 =A0 =A0 =A0 =A0 pending call_rcu() callbacks.
>> >
>> > =A0 =A0 Both (a) and (b) can be carried out on a per-CPU basis if =
there
>> > =A0 =A0 is no convenient locked structure in which to track the st=
ate.
>> > =A0 =A0 You cannot carry (c) out on a per-CPU basis because RCU ca=
llbacks
>> > =A0 =A0 can sometimes be invoked on a different CPU from the one t=
hat
>> > =A0 =A0 call_rcu()ed them. =A0Rare, but it can happen.
>> >
>> > =A0 =A0 I would expect that option (a) would work in almost all ca=
ses.
>> >
>> > If this can be exercised freely from user space, then you probably
>> > really do need #2 above.
>>
>> Yes, you can, but then I'd say it's not necessary for user space to
>> be able to carry that out in a tight loop. =A0So, it seems, alternat=
ively,
>> we could make that loop a bit less tight, e.g. by adding an arbitrar=
y
>> sleep to the user space interface for the "disable" case.
>
> Good point, that would work just as well and be simpler.

OK, well I am expecting that this will now be a very small patch to
change just serial_core.

Thanks for your help with this.

Regards,
Simon
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
