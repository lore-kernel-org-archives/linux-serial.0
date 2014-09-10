From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH 13/26] locking: Add non-fatal spin lock assert
Date: Wed, 10 Sep 2014 10:45:33 -0400
Message-ID: <5410640D.8010903@hurleysoftware.com>
References: <1409693975-1028-1-git-send-email-peter@hurleysoftware.com> <1409693975-1028-14-git-send-email-peter@hurleysoftware.com> <20140903092723.GA4783@worktop.ger.corp.intel.com> <5406F964.6060900@hurleysoftware.com> <20140903144029.GA7083@twins.programming.kicks-ass.net> <54072A99.1080306@hurleysoftware.com> <20140903150729.GA7436@twins.programming.kicks-ass.net> <20140904051411.GA27350@gmail.com> <54102FB2.1020808@hurleysoftware.com> <20140910130832.GY4783@worktop.ger.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout32.mail01.mtsvc.net ([216.70.64.70]:50557 "EHLO
	n23.mail01.mtsvc.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751117AbaIJOpq (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 10 Sep 2014 10:45:46 -0400
In-Reply-To: <20140910130832.GY4783@worktop.ger.corp.intel.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>

On 09/10/2014 09:08 AM, Peter Zijlstra wrote:
> On Wed, Sep 10, 2014 at 07:02:10AM -0400, Peter Hurley wrote:
>> On 09/04/2014 01:14 AM, Ingo Molnar wrote:
>>>
>>> * Peter Zijlstra <peterz@infradead.org> wrote:
>>>
>>>> On Wed, Sep 03, 2014 at 10:50:01AM -0400, Peter Hurley wrote:
>>>>> So a lockdep-only assert is unlikely to draw attention to existing bugs,
>>>>> especially in established drivers.
>>>>
>>>> By the same logic lockdep will not find locking errors in established
>>>> drivers.
>>>
>>> Indeed, this patch is ill-advised in several ways:
>>>
>>>   - it extends an API variant that we want to phase
>>>
>>>   - emits a warning even if say lockdep has already emitted a
>>>     warning and locking state is not guaranteed to be consistent. 
>>>
>>>   - makes the kernel more expensive once fully debugged, in that
>>>     non-fatal checks are unconditional.
>>
>> Ok.
>>
>> One thing: I'm not seeing how lockdep_assert_held() switches off once
>> the warning has been emitted? Is the caller expected to construct their
>> own _ONCE tags?
> 
> Indeed, it does not do that. I suppose you can add
> lockdep_assert_held_once() or somesuch if you think the once thing is
> important.

Ok, will do.

On 09/04/2014 01:14 AM, Ingo Molnar wrote:
> Also please submit locking related patches as standalone series 
> to the locking subsystem, not embedded in an unrelated series.

Ok, but how will Greg know when to take the series that depends on
this change, if the locking change is submitted separately?

Regards,
Peter Hurley
