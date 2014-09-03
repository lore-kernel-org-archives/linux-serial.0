From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH 13/26] locking: Add non-fatal spin lock assert
Date: Wed, 03 Sep 2014 10:50:01 -0400
Message-ID: <54072A99.1080306@hurleysoftware.com>
References: <1409693975-1028-1-git-send-email-peter@hurleysoftware.com> <1409693975-1028-14-git-send-email-peter@hurleysoftware.com> <20140903092723.GA4783@worktop.ger.corp.intel.com> <5406F964.6060900@hurleysoftware.com> <20140903144029.GA7083@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout32.mail01.mtsvc.net ([216.70.64.70]:40213 "EHLO
	n23.mail01.mtsvc.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932616AbaICOuJ (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 3 Sep 2014 10:50:09 -0400
In-Reply-To: <20140903144029.GA7083@twins.programming.kicks-ass.net>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>

On 09/03/2014 10:40 AM, Peter Zijlstra wrote:
> On Wed, Sep 03, 2014 at 07:20:04AM -0400, Peter Hurley wrote:
>> Hi Peter,
>>
>> On 09/03/2014 05:27 AM, Peter Zijlstra wrote:
>>> On Tue, Sep 02, 2014 at 05:39:22PM -0400, Peter Hurley wrote:
>>>> Provide method for non-essential or non-critical code to warn of
>>>> invariant errors.
>>>>
>>>> CC: Ingo Molnar <mingo@kernel.org>
>>>> CC: Peter Zijlstra <peterz@infradead.org>
>>>> CC: Thomas Gleixner <tglx@linutronix.de>
>>>> Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
>>>> ---
>>>>  include/linux/spinlock.h         | 1 +
>>>>  include/linux/spinlock_api_smp.h | 1 +
>>>>  include/linux/spinlock_api_up.h  | 1 +
>>>>  3 files changed, 3 insertions(+)
>>>>
>>>> diff --git a/include/linux/spinlock.h b/include/linux/spinlock.h
>>>> index 3f2867f..8a9aaf1 100644
>>>> --- a/include/linux/spinlock.h
>>>> +++ b/include/linux/spinlock.h
>>>> @@ -394,6 +394,7 @@ static inline int spin_can_lock(spinlock_t *lock)
>>>>  }
>>>>  
>>>>  #define assert_spin_locked(lock)	assert_raw_spin_locked(&(lock)->rlock)
>>>> +#define warn_not_spin_locked(lock)	warn_not_raw_spin_locked(&(lock)->rlock)
>>>>  
>>>>  /*
>>>>   * Pull the atomic_t declaration:
>>>> diff --git a/include/linux/spinlock_api_smp.h b/include/linux/spinlock_api_smp.h
>>>> index 42dfab8..0ddd499 100644
>>>> --- a/include/linux/spinlock_api_smp.h
>>>> +++ b/include/linux/spinlock_api_smp.h
>>>> @@ -18,6 +18,7 @@
>>>>  int in_lock_functions(unsigned long addr);
>>>>  
>>>>  #define assert_raw_spin_locked(x)	BUG_ON(!raw_spin_is_locked(x))
>>>> +#define warn_not_raw_spin_locked(x)	WARN_ON_ONCE(!raw_spin_is_locked(x))
>>>
>>> No we should remove assert_spin_locked() not add to it. Use
>>> lockdep_assert_held() instead.
>>
>> I probably should have been more descriptive in the changelog: this
>> is not for a test configuration, but rather, an assertion in an
>> exported api.
> 
> So ?

So a lockdep-only assert is unlikely to draw attention to existing bugs,
especially in established drivers.

