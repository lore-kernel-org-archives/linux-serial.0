From: Max Staudt <mstaudt@suse.de>
Subject: Re: [PATCH] 8250: option 'force_polling' for buggy IRQs
Date: Tue, 26 Jul 2016 18:18:09 +0200
Message-ID: <b383129f-b20b-32e3-41d1-e2c4a68665a2@suse.de>
References: <1469468175-15704-1-git-send-email-mstaudt@suse.de>
 <20160725174712.GA5752@kroah.com>
 <b7ed014e-c6be-01ab-d601-08830d72f8cb@suse.de>
 <20160726150856.GA15676@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160726150856.GA15676@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 07/26/2016 05:08 PM, Greg KH wrote:
> On Tue, Jul 26, 2016 at 01:42:13PM +0200, Max Staudt wrote:
>> On 07/25/2016 07:47 PM, Greg KH wrote:
>>> Ick, don't add new module parameters if at all possible.
>>
>> I agree, I'd rather not add a parameter either, but...
>>
>> - It's a hardware issue
>> - It needs to be handled at boot time
> 
> Why?

Because even an early shell such as rdinit=/bin/bash locks the console up.


>> - It can't be auto-detected (AFAIK)
> 
> Why not?  Can't you have a quirk for this specific, broken, device?

No, I am not aware of a way to detect the bug itself (other than "there are
no interrupts coming in"). It is not a PCI serial port, either.

Also, it's not worth trying to detect the machine as it is a prototype.

It would rather be useful to have a workaround in place, should a future
system (whether prototype or production) have a similar problem. That way
we can get it into some usable state at all, and still use the other,
working features.

I simply thought this patch may be useful for other people as well, that's
why I sent it upstream.


>> The idea is that this parameter allows for a workaround until someone comes
>> up with a workaround or autodetection (if ever). And it can be used to
>> debug future buggy hardware.
> 
> module paramters are horrid, they don't scale (which uart is this for?),
> and no one ever changes them.

This is part of the generic 8250 code, so it should be valid for all 8250ish
UARTs.


>> Curiously, the kernel's printk() is as fast as it should be. It's just
>> userspace that is slow. Any idea why that is the case?
> 
> Ah, then something else might be wrong here, I suggest you track this
> down please.

The difference in speed is something I'd like to look into, but it's not
high on my priority list.

Maybe you have an idea where the speed difference comes from, so I can look
into it?




Max
