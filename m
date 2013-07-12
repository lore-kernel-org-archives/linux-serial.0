From: Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>
Subject: Re: [RFC] PATCH: rfcomm tty refcount fixes
Date: Fri, 12 Jul 2013 11:37:01 -0400
Message-ID: <51E0229D.5060404@hurleysoftware.com>
References: <20130706084343.GA10500@debian.seek.priv> <51E01EB4.3090406@ahsoftware.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <51E01EB4.3090406-SXC+2es9fhnfWeYVQQPykw@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexander Holler <holler-SXC+2es9fhnfWeYVQQPykw@public.gmane.org>
Cc: Gianluca Anzolin <gianluca-DBnCIbp/wUn34ldeiuMUhg@public.gmane.org>, linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

On 07/12/2013 11:20 AM, Alexander Holler wrote:
> Am 06.07.2013 10:43, schrieb Gianluca Anzolin:
>> Hi,
>>
>> I'm getting panics and OOPS with the vanilla kernel 3.10 using rfcomm with a
>> bluetooth module connected to a microcontroller: this occurs when I poweroff
>> the microcontroller without closing first the rfcomm device.
>>
>> Searching the web I found that I'm not alone with this issue:
>>
>> http://marc.info/?l=linux-bluetooth&m=136868678418771&w=2
>>
>> In the thread the issue seems to be a refcounting problem.
>>
>> Indeed looking at the source there are places where dev->port.tty is accessed
>> directly without taking references of the tty_struct.
>>
>> So I inspected every dev->port.tty access and changed the code to use
>> tty_port_tty_get which gets the references properly.
>>
>> In other places I used directly the tty_port_* helpers already in place.
>>
>> I the process I changed also the tty_port_hangup helper because it seems to me
>> that it could leak references in some cases (I sent another email for that).
>>
>> I attach the patch against net/bluetooth/rfcomm/tty.c and
>> drivers/tty/tty_port.c
>>
>> With this patch I cannot reproduce the oopses I was getting before: I was able
>> to trigger the panics very easily and now I cannot trigger them anymore.
>
> The patches with BUG_ON or WARN_ON don't work with 3.10 anymore and do
> make things worse, at least here. They are fine for 3.7-3.9, but not
> with 3.10.

Someone sent me private mail with a crash report which occurs after the
WARN_ON() anyway (which is why I wanted to test the WARN_ON patch :) ).

>> I cannot tell however if the problem is really fixed so I'm here request for
>> comments from people who know this code better than me.
>
> I've just had the chance to test a 3.10(.0) kernel with your two patches
> applied, they doesn't seem to help. The machine I've used to test just
> stood still after the first or second disconnect. Unfortunatley I can't
> provide any debug output, the machine I've just used doesn't have a
> serial and without debugging such stuff is a pain.

Look on the linux-bluetooth list: there is a new (monolithic) patch from the
same author that might be interesting to test. But be warned, it's a big patch
that basically reimplements rfcomm tty as a proper tty port, so there could
be serious bugs there.

I took a quick scan and the basic goal of the patch looks correct but there
could be details missing. Because that patch has extensive changes, it's very
difficult to review.

>> To them I'd like also to have a look at rfcomm_tty_close: in some situations
>> tty_port_put could be called two times: is that right?
>
> That doesn't sound sane.

That's what the old code did; it wasn't sane, it was wrong. Which is why I said
in my initial comments a while back that rfcomm tty didn't refcount correctly.

Besides that, the old code also used a field from the refcounted structure
as an input to obtain a refcount! Crazy.

Regards,
Peter Hurley
