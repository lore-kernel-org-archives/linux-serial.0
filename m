From: Dominique Larchey-Wendling <Dominique.Larchey-Wendling@loria.fr>
Subject: Re: New IOCTL for Modem Control Lines monitoring
Date: Tue, 30 Jan 2007 18:19:29 +0100
Message-ID: <45BF7E21.5040400@loria.fr>
References: <45B8E44D.5050005@loria.fr> <20070130023902.GB28035@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailironport.loria.fr ([152.81.144.100]:29342 "EHLO
	mailironport.loria.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965636AbXA3RTe (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 30 Jan 2007 12:19:34 -0500
In-Reply-To: <20070130023902.GB28035@thunk.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Theodore Tso <tytso@mit.edu>
Cc: linux-serial@vger.kernel.org

 > The question is why do you need such functionality?  The only way to
 > implement what you propose would be pass a structure containing the
 > previous counts into your proposed new ioctl(), which won't be well
 > received by the folks who have to maintain 32/64-bit translation
 > tables for ioctl's for use by supporting architectures that have to
 > support 32 and 64 bit ABI's simultaneously.

Well I do not clearly understand the problem you refer to because
it seems to me that the new function uart_wait_new_status would not
need extra structure compared to function uart_get_count (ioctl 
TIOCGICOUNT) for example. As shown in my previous mail, the profile
of the function would be :

static int
uart_wait_new_status(struct uart_state *state, struct 
serial_icounter_struct __user *icnt)

the "icnt" argument serving as an input as well as an output.
The mask could be in icount.reserved[0]

But maybe the folks (32/64 porters and ioctl haters) you refer
to already do not like the existing ioctls and do not want to
add a new one, even if its interface is similar to TIOCGICOUNT.

 > So what are you actually trying to *do*?  Is this just to fix a
 > theoretical shortcoming?  What does your application really need to
 > do, and perhaps there's a another way we can address it with perhaps a
 > cleaner interface.

Well the application I want to improve is a "serial" (userspace) driver
for a Lacrosse Weatherstation WS 8610, communicating only through modem 
control lines. There exists a usable driver but it uses polling and
so grabs all the cpu for its processing.

- Dominique

Theodore Tso wrote:
> On Thu, Jan 25, 2007 at 06:09:33PM +0100, Dominique Larchey-Wendling wrote:
>> Even tough such an event would have a low probability to occur
>> if the 2 ioctl are close enough, it is still possible. This is
>> a race condition (outside the kernel but possibly locking some
>> process).
>>
>> I propose the introduction of a new ioctl to solve this race,
>> implemented through the NEW function uart_wait_new_status associated
>> to a NEW ioctl.
>>
>> The idea is that this new call would detect a change not compared
>> to the status at the beginning of the call but compared to some
>> previously recorded state. This way, the new ioctl would not
>> miss a status change, even if it occurs before the call to the
>> ioctl.
> 
> You're right that this is a technical flaw in TIOCMIWAIT.  When it was
> originally implemented, it was done to retain compatibility with older
> implementations in other OS's.
> 
> The question is why do you need such functionality?  The only way to
> implement what you propose would be pass a structure containing the
> previous counts into your proposed new ioctl(), which won't be well
> received by the folks who have to maintain 32/64-bit translation
> tables for ioctl's for use by supporting architectures that have to
> support 32 and 64 bit ABI's simultaneously.  Because of this issue
> some folks have proposed killing off ioctl's entirely, which is
> probably not the right answer, but the fact remains that adding new
> ioctl's that require passing in pointers to arbitrary data structures
> is definitely not going to be well received.
> 
> So what are you actually trying to *do*?  Is this just to fix a
> theoretical shortcoming?  What does your application really need to
> do, and perhaps there's a another way we can address it with perhaps a
> cleaner interface.
> 
> 					- Ted
> -
> To unsubscribe from this list: send the line "unsubscribe linux-serial" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
