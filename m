From: Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH 3/3] serial: 8250: Add a wakeup_capable module param
Date: Wed, 18 Jan 2012 14:51:20 -0800
Message-ID: <CAPnjgZ3Rg80YE6qFNB+VxqX9aPd4oQYsDa2pGAsEsJHiNFYAbw@mail.gmail.com>
References: <1326826563-32215-1-git-send-email-sjg@chromium.org>
	<1326826563-32215-3-git-send-email-sjg@chromium.org>
	<20120117201036.6d99f98f@pyramind.ukuu.org.uk>
	<20120118041720.GA2431@linux.vnet.ibm.com>
	<CAPnjgZ1GJatR15dVsq-+hAWhD7eaLhtN737QvBaor_=0+K+6wA@mail.gmail.com>
	<20120118214215.GH2431@linux.vnet.ibm.com>
	<CAPnjgZ1g0Gf8ZCavAbmxjJXxxk9duf1ybbEUNo9L-DHBxyXx-g@mail.gmail.com>
	<20120118224304.GJ2431@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:44270 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751240Ab2ARWvV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 18 Jan 2012 17:51:21 -0500
Received: by obcva7 with SMTP id va7so7885159obc.19
        for <linux-serial@vger.kernel.org>; Wed, 18 Jan 2012 14:51:21 -0800 (PST)
In-Reply-To: <20120118224304.GJ2431@linux.vnet.ibm.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: paulmck@linux.vnet.ibm.com
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, LKML <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@suse.de>, linux-serial@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>

Hi Paul,

On Wed, Jan 18, 2012 at 2:43 PM, Paul E. McKenney
<paulmck@linux.vnet.ibm.com> wrote:
> On Wed, Jan 18, 2012 at 02:15:59PM -0800, Simon Glass wrote:
>> Hi Paul,
>>
>> On Wed, Jan 18, 2012 at 1:42 PM, Paul E. McKenney
>> <paulmck@linux.vnet.ibm.com> wrote:
>> > On Wed, Jan 18, 2012 at 01:08:13PM -0800, Simon Glass wrote:
>> >> [+cc Rafael J. Wysocki <rjw@sisk.pl> who I think wrote the wakeup=
=2Ec code]
>> >>
>> >> Hi Alan, Paul,
>> >>
>> >> On Tue, Jan 17, 2012 at 8:17 PM, Paul E. McKenney
>> >> <paulmck@linux.vnet.ibm.com> wrote:
>> >> > On Tue, Jan 17, 2012 at 08:10:36PM +0000, Alan Cox wrote:
>> >> >> On Tue, 17 Jan 2012 10:56:03 -0800
>> >> >> Simon Glass <sjg@chromium.org> wrote:
>> >> >>
>> >> >> > Since serial_core now does not make serial ports wake-up cap=
able by
>> >> >> > default, add a parameter to support this feature in the 8250=
 UART.
>> >> >> > This is the only UART where I think this feature is useful.
>> >> >>
>> >> >> NAK
>> >> >>
>> >> >> Things should just work for users. Magic parameters is not an
>> >> >> improvement. If its a performance problem someone needs to fix=
 the rcu
>> >> >> sync overhead or stop using rcu on that path.
>> >>
>> >> OK fair enough, I agree. Every level I move down the source tree
>> >> affects more people though.
>> >>
>> >> >
>> >> > I must say that I lack context here, even after looking at the =
patch,
>> >> > but the synchronize_rcu_expedited() primitives can be used if t=
he latency
>> >> > of synchronize_rcu() is too large.
>> >> >
>> >>
>> >> Let me provide a bit of context. The serial_core code seems to be=
 the
>> >> only place in the kernel that does this:
>> >>
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 device_init_wakeup(tty_dev, 1);
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 device_set_wakeup_enable(tty_dev, 0);
>> >>
>> >> The first call makes the device wakeup capable and enables wakeup=
, The
>> >> second call disabled wakeup.
>> >>
>> >> The code that removes the wakeup source looks like this:
>> >>
>> >> void wakeup_source_remove(struct wakeup_source *ws)
>> >> {
>> >> =A0 =A0 =A0 if (WARN_ON(!ws))
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
>> >>
>> >> =A0 =A0 =A0 spin_lock_irq(&events_lock);
>> >> =A0 =A0 =A0 list_del_rcu(&ws->entry);
>> >> =A0 =A0 =A0 spin_unlock_irq(&events_lock);
>> >> =A0 =A0 =A0 synchronize_rcu();
>> >> }
>> >>
>> >> The sync is there because we are about to destroy the actual ws
>> >> structure (in wakeup_source_destroy()). I wonder if it should be =
in
>> >> wakeup_source_destroy() but that wouldn't help me anyway.
>> >>
>> >> synchronize_rcu_expedited() is a bit faster but not really fast
>> >> enough. Anyway surely people will complain if I put this in the w=
akeup
>> >> code - it will affect all wakeup users. It seems to me that the r=
ight
>> >> solution is to avoid enabling and then immediately disabling wake=
up.
>> >
>> > Hmmm... =A0What hardware are you running this one? =A0Normally,
>> > synchronize_rcu_expedited() will be a couple of orders of magnitud=
e
>> > faster than synchronize_rcu().
>> >
>> >> I assume we can't and shouldn't change device_init_wakeup() . We =
could
>> >> add a call like device_init_wakeup_disabled() which makes the dev=
ice
>> >> wakeup capable but does not actually enable it. Does that work?
>> >
>> > If the only reason for the synchronize_rcu() is to defer the pair =
of
>> > kfree()s in wakeup_source_destroy(), then another possible approac=
h
>> > would be to remove the synchronize_rcu() from wakeup_source_remove=
()
>> > and then use call_rcu() to defer the two kfree()s.
>> >
>> > If this is a reasonable change to make, the approach is as follows=
:
>> >
>> > 1. =A0 =A0 =A0Add a struct rcu_head to wakeup_source, call it "rcu=
".
>> > =A0 =A0 =A0 =A0Or adjust the following to suit your choice of name=
=2E
>> >
>> > 2. =A0 =A0 =A0Replace the pair of kfree()s with:
>> >
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0call_rcu(&ws->rcu, wakeup_source_de=
stroy_rcu);
>> >
>> > 3. =A0 =A0 =A0Create the wakeup_source_destroy_rcu() as follows:
>> >
>> > =A0 =A0 =A0 =A0static void wakeup_source_destroy_rcu(struct rcu_he=
ad *head)
>> > =A0 =A0 =A0 =A0{
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct wakeup_source *ws =3D
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0container_of(head, =
struct wakeup_source, rcu);
>> >
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0kfree(ws->name);
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0kfree(ws);
>> > =A0 =A0 =A0 =A0}
>> >
>> > Of course, this assumes that it is OK for wakeup_source_unregister=
()
>> > to return before the memory is freed up. =A0This often is OK, but =
there
>> > are some cases where the caller requires that there be no further
>> > RCU readers with access to the old data. =A0In these cases, you re=
ally
>> > do need the wait.
>>
>> Thanks very much for that. I'm not sure if it is a reasonable change=
,
>> but it does bug me that we add it to a data structure knowing that w=
e
>> will immediately remove it!
>>
>> >From what I can see, making a device wakeup-enabled mostly happens =
on
>> init or in response to a request to the driver (presumably from user
>> space). In the latter case I suspect the synchronise_rcu() is fine. =
In
>> the former it feels like we should make up our minds which of the
>> three options is required (incapable, capable but not enabled, capab=
le
>> and enabled).
>>
>> I will try a patch first based on splitting the two options (capable
>> and enable) and see if that get a NAK.
>>
>> Then I will come back to your solution - it seems fine to me and not=
 a
>> lot of code. Do we have to worry about someone enabling, disabled,
>> enabling and then disabling wakeup quickly? Will this method break i=
n
>> that case if the second call to call_rcu() uses the same wc->rcu?
>
> There are a couple of questions here, let me take them one at a time:
>
> 1. =A0 =A0 =A0If you just disabled, can you immediately re-enable?
>
> =A0 =A0 =A0 =A0The answer is "yes". =A0The reason that this works is =
that you
> =A0 =A0 =A0 =A0allocate a new structure for the re-enabling, and that=
 new
> =A0 =A0 =A0 =A0structure has its own rcu_head field.
>
> 2. =A0 =A0 =A0If you repeatedly disable and re-enable in a tight loop=
,
> =A0 =A0 =A0 =A0can this cause problems?
>
> =A0 =A0 =A0 =A0The answer to this is also "yes" -- you can run the sy=
stem
> =A0 =A0 =A0 =A0out of memory doing that. =A0However, there are a numb=
er of
> =A0 =A0 =A0 =A0simple ways to avoid this problem:
>
> =A0 =A0 =A0 =A0a. =A0 =A0 =A0Do a synchronize_rcu() on every (say) th=
ousandth
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0disable operation.
>
> =A0 =A0 =A0 =A0b. =A0 =A0 =A0As above, but only do the synchronize_rc=
u() if
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0all 1,000 disable operations occurred =
within
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(say) a second of each other.
>
> =A0 =A0 =A0 =A0c. =A0 =A0 =A0As above, but actually count the number =
of
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pending call_rcu() callbacks.
>
> =A0 =A0 =A0 =A0Both (a) and (b) can be carried out on a per-CPU basis=
 if there
> =A0 =A0 =A0 =A0is no convenient locked structure in which to track th=
e state.
> =A0 =A0 =A0 =A0You cannot carry (c) out on a per-CPU basis because RC=
U callbacks
> =A0 =A0 =A0 =A0can sometimes be invoked on a different CPU from the o=
ne that
> =A0 =A0 =A0 =A0call_rcu()ed them. =A0Rare, but it can happen.
>
> =A0 =A0 =A0 =A0I would expect that option (a) would work in almost al=
l cases.
>
> If this can be exercised freely from user space, then you probably
> really do need #2 above.

OK I see, thank you. It does sound a bit complicated although the
chances of anyone actually doing this are probably remote.

I will send my patch to avoid getting into this situation and see what
you think.

Regards,
Simon
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
