From: Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH 3/3] serial: 8250: Add a wakeup_capable module param
Date: Wed, 18 Jan 2012 13:08:13 -0800
Message-ID: <CAPnjgZ1GJatR15dVsq-+hAWhD7eaLhtN737QvBaor_=0+K+6wA@mail.gmail.com>
References: <1326826563-32215-1-git-send-email-sjg@chromium.org>
	<1326826563-32215-3-git-send-email-sjg@chromium.org>
	<20120117201036.6d99f98f@pyramind.ukuu.org.uk>
	<20120118041720.GA2431@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:52992 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932201Ab2ARVIO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 18 Jan 2012 16:08:14 -0500
Received: by obcva7 with SMTP id va7so7772676obc.19
        for <linux-serial@vger.kernel.org>; Wed, 18 Jan 2012 13:08:13 -0800 (PST)
In-Reply-To: <20120118041720.GA2431@linux.vnet.ibm.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: paulmck@linux.vnet.ibm.com
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, LKML <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@suse.de>, linux-serial@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>

[+cc Rafael J. Wysocki <rjw@sisk.pl> who I think wrote the wakeup.c cod=
e]

Hi Alan, Paul,

On Tue, Jan 17, 2012 at 8:17 PM, Paul E. McKenney
<paulmck@linux.vnet.ibm.com> wrote:
> On Tue, Jan 17, 2012 at 08:10:36PM +0000, Alan Cox wrote:
>> On Tue, 17 Jan 2012 10:56:03 -0800
>> Simon Glass <sjg@chromium.org> wrote:
>>
>> > Since serial_core now does not make serial ports wake-up capable b=
y
>> > default, add a parameter to support this feature in the 8250 UART.
>> > This is the only UART where I think this feature is useful.
>>
>> NAK
>>
>> Things should just work for users. Magic parameters is not an
>> improvement. If its a performance problem someone needs to fix the r=
cu
>> sync overhead or stop using rcu on that path.

OK fair enough, I agree. Every level I move down the source tree
affects more people though.

>
> I must say that I lack context here, even after looking at the patch,
> but the synchronize_rcu_expedited() primitives can be used if the lat=
ency
> of synchronize_rcu() is too large.
>

Let me provide a bit of context. The serial_core code seems to be the
only place in the kernel that does this:

		device_init_wakeup(tty_dev, 1);
		device_set_wakeup_enable(tty_dev, 0);

The first call makes the device wakeup capable and enables wakeup, The
second call disabled wakeup.

The code that removes the wakeup source looks like this:

void wakeup_source_remove(struct wakeup_source *ws)
{
	if (WARN_ON(!ws))
		return;

	spin_lock_irq(&events_lock);
	list_del_rcu(&ws->entry);
	spin_unlock_irq(&events_lock);
	synchronize_rcu();
}

The sync is there because we are about to destroy the actual ws
structure (in wakeup_source_destroy()). I wonder if it should be in
wakeup_source_destroy() but that wouldn't help me anyway.

synchronize_rcu_expedited() is a bit faster but not really fast
enough. Anyway surely people will complain if I put this in the wakeup
code - it will affect all wakeup users. It seems to me that the right
solution is to avoid enabling and then immediately disabling wakeup.

I assume we can't and shouldn't change device_init_wakeup() . We could
add a call like device_init_wakeup_disabled() which makes the device
wakeup capable but does not actually enable it. Does that work?

Regards,
Simon

> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Thanx, Paul
>
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
