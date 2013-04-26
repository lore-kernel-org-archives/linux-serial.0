From: Mark Hounschell <markh@compro.net>
Subject: Re: Out of tree GPL serial tty driver help?
Date: Fri, 26 Apr 2013 08:58:09 -0400
Message-ID: <517A79E1.8060504@compro.net>
References: <51781A19.5030707@compro.net> <1366926071.3452.17.camel@thor.lan>
Reply-To: markh@compro.net
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mx2.compro.net ([12.186.155.4]:21832 "EHLO mx2.compro.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752536Ab3DZM6K (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 26 Apr 2013 08:58:10 -0400
In-Reply-To: <1366926071.3452.17.camel@thor.lan>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: linux-serial@vger.kernel.org, Mark Hounschell <dmarkh@cfl.rr.com>

On 04/25/2013 05:41 PM, Peter Hurley wrote:
> On Wed, 2013-04-24 at 13:44 -0400, Mark Hounschell wrote:
>> I've been sort of maintaining a couple of Digi International serial port
>> card (XP and AP) drivers for years now because, well, they just won't do
>> it anymore. In any case, I'm moving from a 3.4.x kernel, that works just
>> fine, to a 3.8.8 kernel, that does not. I have code that does something
>> like this:
>>
>>       tty_set_operations(&SerialDriver, &SerialOps);
>>       tty_register_driver(&SerialDriver);
>>       maxminor = NumBoards * 64;
>>       for (i = 0; i < maxminor; i++)
>>           tty_register_device(&SerialDriver, i, NULL);
>
> You're correct in diagnosing the problem to cdevs == NULL.
> You're missing:
>
> 	maxminor = min(num_boards * 64, 256);
> 	serial_driver = alloc_tty_driver(maxminor);
>
> then,
> 	/* Fill in pertinent tty_driver fields, esp. */
> 	serial_driver->flags = TTY_DRIVER_DYNAMIC_DEV;
>
> 	tty_set_operations(serial_driver, &serial_ops);
> 	tty_register_driver(serial_driver);
> 	for (i = 0; i < maxminor; i++)
> 		tty_register_device(serial_driver, i, NULL);
>
>

Thanks for responding Peter.

Earlier in the code they do this:

static struct tty_driver SerialDriver
and things like
SerialDriver.termios = kmalloc((maxminor - 256) * sizeof(TERMIOS *), 
GFP_KERNEL);

So is the above no longer going to work and I _must_ now use 
alloc_tty_driver? If alloc_tty_driver is now a requirement, how much is 
it going to do for me? There are several things like the termios above 
that are manually allocated. How much if any of this is alloc_tty_driver 
going to do for me?

or might this work

static struct tty_driver SerialDriver
.
.
.
  	serial_driver.flags = TTY_DRIVER_DYNAMIC_DEV;

         SerialDriver.cdevs  = kcalloc(maxminor, 
sizeof(SerialDriver.cdevs), GFP_KERNEL);

  	tty_set_operations(&serial_driver, &serial_ops);
  	tty_register_driver(&serial_driver);
  	for (i = 0; i < maxminor; i++)
  		tty_register_device(&serial_driver, i, NULL);

???

>
> PS - Each board supports 64 individual serial ports??

No, this particular card comes in 4, 8, and 16 port flavors. I never did 
understand why they create so many device entries. I just figured they 
had a reason. For a single card, no matter how many ports, they create 
64 normal serial tty entries (tty_dgdm_G0 - tty_dgdm_G63), 64 serial 
printer entries (lp_dgdm_G0 - lp_dgdm_G63), and then 64 serial modem 
entries (cu_dgdm_G0 - cu_dgdm_G63). Don't know why.


Thanks again
Mark
