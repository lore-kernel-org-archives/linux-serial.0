From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [PATCH] 8250: option 'force_polling' for buggy IRQs
Date: Fri, 29 Jul 2016 12:38:09 -0500
Message-ID: <871t2cgxa6.fsf@x220.int.ebiederm.org>
References: <1469468175-15704-1-git-send-email-mstaudt@suse.de>
	<20160725174712.GA5752@kroah.com>
	<b7ed014e-c6be-01ab-d601-08830d72f8cb@suse.de>
	<20160726150856.GA15676@kroah.com>
	<b383129f-b20b-32e3-41d1-e2c4a68665a2@suse.de>
	<20160727130923.4c20524b@lxorguk.ukuu.org.uk>
	<2b140616-c210-e754-a854-cd6a5675277d@suse.de>
	<20160727133348.GB20032@thunk.org>
	<f02610c6-5607-9fdf-23af-5b05d604f473@suse.de>
	<87mvl1hahu.fsf@x220.int.ebiederm.org>
	<20160729102335.2dbe3cad@lxorguk.ukuu.org.uk>
	<8e37ca98-23a5-9eb7-1317-760bbebcd8bb@suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <8e37ca98-23a5-9eb7-1317-760bbebcd8bb@suse.de> (Max Staudt's
	message of "Fri, 29 Jul 2016 11:58:50 +0200")
Sender: linux-kernel-owner@vger.kernel.org
To: Max Staudt <mstaudt@suse.de>
Cc: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Theodore Ts'o <tytso@mit.edu>, Greg KH <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Max Staudt <mstaudt@suse.de> writes:

> On 07/29/2016 11:23 AM, One Thousand Gnomes wrote:
>>> Serial consoles are already polled for output.  So nothing should
>>> care until userspace starts, and the full serial driver initializes.
>> 
>> At which point it hangs
>
> Yep, because the IRQ is never firing. It isn't screaming at all. :)
>
>
>>> So I suspect either "irqfixup" or "irqpoll" would handle this for you.
>>> If not I am certain a small tweak to some of that code would work.
>> 
>> irqfixup won't usually help but irqpoll with HZ=1000 ought to, although
>> it has its own set of problems because not all devices with non shared
>> IRQ lines take kindly to irqpoll.

It might make sense to filter non-shared edge triggered interrupts out
of irqpoll for that reason.  Anything that supports a level triggered
interrupt should be fine.

> Hmm, the kernel is compiled as tickless. I tried booting with
> "irqpoll nohz=off" but that didn't help.
>
>
> What I could try is to build an option like "irqfire=4,1000" which would
> simulate an IRQ on line 4 at 1000 HZ and call the handler every time.
> Whether the handling driver likes it is a different question though.
>
> It sounds like "irqpoll" would do something similar, but based on the
> kernel's global HZ setting, and calling all handlers unconditionally.
> "irqfire" would be more specific.
>
> What do you think?
> Would this be useful for other broken systems, too?

I think so.   I think I would go simpler and start a simple recurring
timer in the irqpoll case.

All that is really important is that it is generally reliable and it isn't
too hard to make work.  Which makes me worry a little bit about your
irqfire example (aka someone has to figure out which irq is not firing),
which might be hard if you can't log in.

But shrug.  You are writing the patch.  I am just pointing out where we
have similar work arounds already and where another workaround to cover
your case (and to help others) would likely be appreciated in the kernel.

Eric
