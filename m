From: Mark Hounschell <markh@compro.net>
Subject: Re: Out of tree GPL serial tty driver help?
Date: Fri, 26 Apr 2013 14:17:38 -0400
Message-ID: <517AC4C2.3010702@compro.net>
References: <51781A19.5030707@compro.net>  <1366926071.3452.17.camel@thor.lan> <517A79E1.8060504@compro.net>  <1366983913.3452.33.camel@thor.lan> <517A8EF1.8040006@compro.net> <1366994272.689.4.camel@thor.lan>
Reply-To: markh@compro.net
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mx2.compro.net ([12.186.155.4]:55200 "EHLO mx2.compro.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756673Ab3DZSRj (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 26 Apr 2013 14:17:39 -0400
In-Reply-To: <1366994272.689.4.camel@thor.lan>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: linux-serial@vger.kernel.org, Mark Hounschell <dmarkh@cfl.rr.com>

On 04/26/2013 12:37 PM, Peter Hurley wrote:
>
> On Fri, 2013-04-26 at 10:28 -0400, Mark Hounschell wrote:
>> On 04/26/2013 09:45 AM, Peter Hurley wrote:
>>> On Fri, 2013-04-26 at 08:58 -0400, Mark Hounschell wrote:
>>>> On 04/25/2013 05:41 PM, Peter Hurley wrote:
>>>>> On Wed, 2013-04-24 at 13:44 -0400, Mark Hounschell wrote:
>>>>>> I've been sort of maintaining a couple of Digi International serial port
>>>>>> card (XP and AP) drivers for years now because, well, they just won't do
>>>>>> it anymore. In any case, I'm moving from a 3.4.x kernel, that works just
>>>>>> fine, to a 3.8.8 kernel, that does not. I have code that does something
>>>>>> like this:
>>>>>>
>>>>>>         tty_set_operations(&SerialDriver, &SerialOps);
>>>>>>         tty_register_driver(&SerialDriver);
>>>>>>         maxminor = NumBoards * 64;
>>>>>>         for (i = 0; i < maxminor; i++)
>>>>>>             tty_register_device(&SerialDriver, i, NULL);
>>>>>
>>>>> You're correct in diagnosing the problem to cdevs == NULL.
>>>>> You're missing:
>>>>>
>>>>> 	maxminor = min(num_boards * 64, 256);
>>>>> 	serial_driver = alloc_tty_driver(maxminor);
>>>>>
>>>>> then,
>>>>> 	/* Fill in pertinent tty_driver fields, esp. */
>>>>> 	serial_driver->flags = TTY_DRIVER_DYNAMIC_DEV;
>>>>>
>>>>> 	tty_set_operations(serial_driver, &serial_ops);
>>>>> 	tty_register_driver(serial_driver);
>>>>> 	for (i = 0; i < maxminor; i++)
>>>>> 		tty_register_device(serial_driver, i, NULL);
>>>>>
>>>>>
>>>>
>>>> Thanks for responding Peter.
>>>>
>>>> Earlier in the code they do this:
>>>>
>>>> static struct tty_driver SerialDriver
>>>> and things like
>>>> SerialDriver.termios = kmalloc((maxminor - 256) * sizeof(TERMIOS *),
>>>                                     ^^^^^^^^^^^^^^
>>>                                   is this a transcription error?
>>
>> Yes, sorry. (MIN(maxminor,256) * sizeof(TERMIOS *)
>
> Ok.
>
>>>
>>>> GFP_KERNEL);
>>>>
>>     >> So is the above no longer going to work and I _must_ now use
>>>> alloc_tty_driver?
>>>
>>> Not required but functionally equivalent. alloc_tty_driver() is actually
>>> a wrapper macro which calls __tty_alloc_driver(). You can verify your
>>> driver behavior against that function, if you want.
>>>
>>>> If alloc_tty_driver is now a requirement, how much is
>>>> it going to do for me? There are several things like the termios above
>>>> that are manually allocated. How much if any of this is alloc_tty_driver
>>>> going to do for me?
>>>
>>> I can't answer this because I don't know what else your open-coded
>>> method is doing.
>>>
>>
>> Looking at __tty_alloc_driver, it looks as though only driver, cdevs and
>> ports are provided.
>>
>>>> or might this work
>>>>
>>>> static struct tty_driver SerialDriver
>>>> .
>>>> .
>>>> .
>>>>     	serial_driver.flags = TTY_DRIVER_DYNAMIC_DEV;
>>>>
>>>>            SerialDriver.cdevs  = kcalloc(maxminor,
>>>> sizeof(SerialDriver.cdevs), GFP_KERNEL);
>>
>> So might something like the above for cdevs and ports get me where I
>> need to be?
>>
>>>>
>>>>     	tty_set_operations(&serial_driver, &serial_ops);
>>>>     	tty_register_driver(&serial_driver);
>>>>     	for (i = 0; i < maxminor; i++)
>>>>     		tty_register_device(&serial_driver, i, NULL);
>>>>
>>>> ???
>>>>
>>>>>
>>>>> PS - Each board supports 64 individual serial ports??
>>>>
>>>> No, this particular card comes in 4, 8, and 16 port flavors. I never did
>>>> understand why they create so many device entries. I just figured they
>>>> had a reason. For a single card, no matter how many ports, they create
>>>> 64 normal serial tty entries (tty_dgdm_G0 - tty_dgdm_G63), 64 serial
>>>> printer entries (lp_dgdm_G0 - lp_dgdm_G63), and then 64 serial modem
>>>> entries (cu_dgdm_G0 - cu_dgdm_G63). Don't know why.
>>>
>>> So where does i/o go for tty_dgdm_G16?
>>>
>>
>> I have no idea. I do know that G0 - G7 are the ones I actually use for
>> ports 0-7 of an 8 port card-0, and
>> G64 - G71 are the ones I use for ports 0-7 of an 8 port card-1. I
>> remember long ago I had some doc explaining this but can't seem to find
>> it now.
>>
>>> Also, what host bus are these cards for?
>>>
>>
>> This particular driver and one other are normal PCI based cards. I also
>> have one other that is PCI-e. This particular one is the only one that
>> creates all these weird device entries. The other 2 are pretty straight
>> forward. One entry per port. I figured I'd tackle this one first.
>
> Ok. Looking at Digi's website, I see they have external port
> concentrators. That would explain the fixed 64-port allocation (although
> that's not really how to do it).
>
> These drivers weren't really current at 3.4 though, either. I'm not sure
> what else you're going to find that doesn't work.
>

No, I have kept them current, or I should say functional, to the best of 
my ability from 2.6 up to and including 3.4.x. What I have here works 
with kernels up to 3.4.x. I have not tried anything between 3.4 and 3.8. 
  As far as building against 3.8, the only issues were the change from 
*termios to termios and the "structn_tty_data" no longer in an include 
file so not easily directly accessible.

> For both PCI and PCI-e, these drivers should _at a minimum_ be pci
> drivers that register the tty driver at module init and register _only_
> the tty devices for that particular PCI device at PCI probe time. Look
> at the end of synclink_gt.c for how this is supposed to look.
>

I'll look at it some more but I have been there.

mark
