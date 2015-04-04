From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH v3] earlycon: 8250: Fix command line regression
Date: Sat, 04 Apr 2015 13:08:42 -0400
Message-ID: <55201A9A.3080102@hurleysoftware.com>
References: <1428105875-4038-1-git-send-email-peter@hurleysoftware.com> <1428157650-16418-1-git-send-email-peter@hurleysoftware.com> <20150404160931.GC19278@kroah.com> <55200FF2.6070206@hurleysoftware.com> <20150404165217.GA26861@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150404165217.GA26861@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-next@vger.kernel.org, linux-serial@vger.kernel.org, Rob Herring <robh@kernel.org>, Yinghai Lu <yinghai@kernel.org>
List-Id: linux-serial@vger.kernel.org

On 04/04/2015 12:52 PM, Greg Kroah-Hartman wrote:
> On Sat, Apr 04, 2015 at 12:23:14PM -0400, Peter Hurley wrote:
>> On 04/04/2015 12:09 PM, Greg Kroah-Hartman wrote:
>>> On Sat, Apr 04, 2015 at 10:27:30AM -0400, Peter Hurley wrote:
[...]
>>>> +/* FIXME: this is broken on most other 8250 h/w */
>>>
>>> What do you mean by "most other"?  What hardware does this work for?
>>> What is it broken for?  What is someone supposed to think/do with this
>>> comment?
>>
>> It's a direct copy of the existing behavior for 8250 earlycon, which is
>> broken for h/w with non-standard divisor registers. That's basically
>> _every_ new design, because that's what vendors need to extend to support
>> modern bitrates.
>>
>> Affected h/w that I know of includes: 8250_dw, exar xr17v35 cards, omap8250,
>> omap15xx, intel byt, intel mid.
>>
>> But it was already broken for these and so not a regression.
> 
> Sorry, I know the function is a copy, you haven't broken anything that
> wasn't already broken.  I see this comment as a "rant", but we might as
> well turn that "rant" into something descriptive to let other people
> know what is really going on here.

It's not intended as rant. My concern is that it appears as "desirable"
code because it's new, when that's not my intention.

When others go to implement earlycon-to-console handoff, my hope is
that they don't follow this exemplar. Unfortunately, since this is
the only driver that implements earlycon-to-console handoff (right now),
some might just simply copy the behavior here. My intention is to
discourage that.

> Sound reasonable?

Ok. How about "most new"?

Regards,
Peter Hurley
