From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH 13/26] locking: Add non-fatal spin lock assert
Date: Wed, 10 Sep 2014 07:02:10 -0400
Message-ID: <54102FB2.1020808@hurleysoftware.com>
References: <1409693975-1028-1-git-send-email-peter@hurleysoftware.com> <1409693975-1028-14-git-send-email-peter@hurleysoftware.com> <20140903092723.GA4783@worktop.ger.corp.intel.com> <5406F964.6060900@hurleysoftware.com> <20140903144029.GA7083@twins.programming.kicks-ass.net> <54072A99.1080306@hurleysoftware.com> <20140903150729.GA7436@twins.programming.kicks-ass.net> <20140904051411.GA27350@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout32.mail01.mtsvc.net ([216.70.64.70]:40804 "EHLO
	n23.mail01.mtsvc.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751817AbaIJLCY (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 10 Sep 2014 07:02:24 -0400
In-Reply-To: <20140904051411.GA27350@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>

On 09/04/2014 01:14 AM, Ingo Molnar wrote:
> 
> * Peter Zijlstra <peterz@infradead.org> wrote:
> 
>> On Wed, Sep 03, 2014 at 10:50:01AM -0400, Peter Hurley wrote:
>>> So a lockdep-only assert is unlikely to draw attention to existing bugs,
>>> especially in established drivers.
>>
>> By the same logic lockdep will not find locking errors in established
>> drivers.
> 
> Indeed, this patch is ill-advised in several ways:
> 
>   - it extends an API variant that we want to phase
> 
>   - emits a warning even if say lockdep has already emitted a
>     warning and locking state is not guaranteed to be consistent. 
> 
>   - makes the kernel more expensive once fully debugged, in that
>     non-fatal checks are unconditional.

Ok.

One thing: I'm not seeing how lockdep_assert_held() switches off once
the warning has been emitted? Is the caller expected to construct their
own _ONCE tags?

Regards,
Peter Hurley
