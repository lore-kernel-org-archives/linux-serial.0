From: Grant Edwards <grant.b.edwards@gmail.com>
Subject: Re: RFC: out-of-tree tty driver breakage (changing ASYNC_ bits)
Date: Tue, 28 Jun 2016 15:39:30 +0000 (UTC)
Message-ID: <nku5nh$1n3$1@ger.gmane.org>
References: <5692D054.7050203@hurleysoftware.com>
 <20160111044204.GB12741@kroah.com> <n70j5g$sem$1@ger.gmane.org>
 <5693D72D.6050501@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 2016-01-11, Peter Hurley <peter@hurleysoftware.com> wrote:
> On 01/11/2016 07:53 AM, Grant Edwards wrote:
>> On 2016-01-11, Greg KH <gregkh@linuxfoundation.org> wrote:
>>> On Sun, Jan 10, 2016 at 01:42:44PM -0800, Peter Hurley wrote:
>>>
>>>> This will break out-of-tree drivers but I don't really see a
>>>> realistic alternative. Also, I think the new symbol prefix ASY_ isn't
>>>> great and I'd like to get some suggestions.
>>>
>>> Don't worry about breaking out-of-tree drivers, that's fine.
>> 
>> One request from this maintainer of several out-of-tree drivers: if
>> you break something, break it such that it won't compile.  It would be
>> nice to avoid changes that break functionality but still compile
>> without warning.
>
> I was in the process of writing how I can't remove
> ASYNC_INITIALIZED, et.al from the uapi header, when I realized that
> I can just guard them with #ifndef _KERNEL_ which will trigger the
> requisite out-of-tree build break.

One of my drivers checks that state of port.flags & ASYNC_INITIALIZED
in various places (it also checks some other port.flags bits
(_CLOSING, _SPD_xxxx, _LOW_LATENCY).

I've been regulary building against linux-next waiting for the build
to fail when the flag changes got pulled.  It still builds cleanly,
but it looks like the flags canges are indeed in linux-next.

Does that mean that I don't need to change my code to use
tty_port_initialized()?

You know that _KERNEL_ is defined when when compiling kernel-space
code (either in-tree or out-of-tree), right?

I see from comments in tty_flags.h that ASYNC_CLOSING is no longer
used.  But I don't see a replacement in tty.h

-- 
Grant Edwards               grant.b.edwards        Yow! I'm having a
                                  at               tax-deductible experience!
                              gmail.com            I need an energy crunch!!
