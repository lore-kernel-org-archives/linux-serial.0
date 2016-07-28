From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [PATCH] 8250: option 'force_polling' for buggy IRQs
Date: Thu, 28 Jul 2016 13:40:29 -0500
Message-ID: <87mvl1hahu.fsf@x220.int.ebiederm.org>
References: <1469468175-15704-1-git-send-email-mstaudt@suse.de>
	<20160725174712.GA5752@kroah.com>
	<b7ed014e-c6be-01ab-d601-08830d72f8cb@suse.de>
	<20160726150856.GA15676@kroah.com>
	<b383129f-b20b-32e3-41d1-e2c4a68665a2@suse.de>
	<20160727130923.4c20524b@lxorguk.ukuu.org.uk>
	<2b140616-c210-e754-a854-cd6a5675277d@suse.de>
	<20160727133348.GB20032@thunk.org>
	<f02610c6-5607-9fdf-23af-5b05d604f473@suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <f02610c6-5607-9fdf-23af-5b05d604f473@suse.de> (Max Staudt's
	message of "Thu, 28 Jul 2016 11:59:20 +0200")
Sender: linux-kernel-owner@vger.kernel.org
To: Max Staudt <mstaudt@suse.de>
Cc: Theodore Ts'o <tytso@mit.edu>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Greg KH <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Max Staudt <mstaudt@suse.de> writes:

> On 07/27/2016 03:33 PM, Theodore Ts'o wrote:
>
>> I wonder if it would just be simpler to make it be a CONFIG option
>> which causes the irq value to zero in arch/x86/include/asm/serial.h?
>
> Alan hit the nail on the head in his reply to your email: I can't set the IRQ in
> the system configuration. The other option is to compile a custom kernel for this
> system, but that's exactly what I'd like to avoid.
>
> My motivation for this patch is to have a boot time option that allows *any*
> kernel to boot on this broken hardware. This allows for console boot on a broken
> machine even when the machine has never been used in serial console mode before,
> and thus the hardware bug has not been discovered before either.

*Scratches my head*

There is already generic handling for this (that triggers polling) in
the irq code if an irq is screaming.  I am assuming the problem is that
your irq never fires?

Serial consoles are already polled for output.  So nothing should
care until userspace starts, and the full serial driver initializes.

Hmm.

The irq code already has handling for some of these situations,
and if that handling is not sufficient I suspect we could pretty
easily extend it for this case.

For irqs that are screaming we disable them and then poll them.
There there are the "irqfixup" and "irqpoll" command line options
that when an irq is received the code tries all of the irq handlers.

So I suspect either "irqfixup" or "irqpoll" would handle this for you.
If not I am certain a small tweak to some of that code would work.

That should be enough to get a system booted for debugging purposes,
which is the point here.  At which point you can dig in figure out what
is wrong and get the problem design fixed.

Eric
