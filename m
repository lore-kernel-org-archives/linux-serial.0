From: Max Staudt <mstaudt@suse.de>
Subject: Re: [PATCH] 8250: option 'force_polling' for buggy IRQs
Date: Fri, 29 Jul 2016 11:58:50 +0200
Message-ID: <8e37ca98-23a5-9eb7-1317-760bbebcd8bb@suse.de>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160729102335.2dbe3cad@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Theodore Ts'o <tytso@mit.edu>, Greg KH <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 07/29/2016 11:23 AM, One Thousand Gnomes wrote:
>> Serial consoles are already polled for output.  So nothing should
>> care until userspace starts, and the full serial driver initializes.
> 
> At which point it hangs

Yep, because the IRQ is never firing. It isn't screaming at all. :)


>> So I suspect either "irqfixup" or "irqpoll" would handle this for you.
>> If not I am certain a small tweak to some of that code would work.
> 
> irqfixup won't usually help but irqpoll with HZ=1000 ought to, although
> it has its own set of problems because not all devices with non shared
> IRQ lines take kindly to irqpoll.

Hmm, the kernel is compiled as tickless. I tried booting with
"irqpoll nohz=off" but that didn't help.


What I could try is to build an option like "irqfire=4,1000" which would
simulate an IRQ on line 4 at 1000 HZ and call the handler every time.
Whether the handling driver likes it is a different question though.

It sounds like "irqpoll" would do something similar, but based on the
kernel's global HZ setting, and calling all handlers unconditionally.
"irqfire" would be more specific.

What do you think?
Would this be useful for other broken systems, too?



Max
