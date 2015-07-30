From: Taichi Kageyama <t-kageyama@cp.jp.nec.com>
Subject: Re: [RFC PATCH v2 0/3] genirq, serial: 8250: Workaround to avoid
 irq=0 for console
Date: Thu, 30 Jul 2015 01:41:57 +0000
Message-ID: <55B980E6.70800@cp.jp.nec.com>
References: <1438157443-19447-1-git-send-email-t-kageyama@cp.jp.nec.com>
 <alpine.DEB.2.11.1507291230590.3825@nanos>
 <55B8BE39.6080500@hurleysoftware.com>
 <alpine.DEB.2.11.1507291351530.3825@nanos>
 <55B8D26A.7000402@hurleysoftware.com>
 <alpine.DEB.2.11.1507291534350.3825@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.11.1507291534350.3825@nanos>
Content-Language: ja-JP
Content-ID: <152734F95B37CE4F81E96672D5A4F9B1@gisp.nec.co.jp>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>, Peter Hurley <peter@hurleysoftware.com>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "jiang.liu@linux.intel.com" <jiang.liu@linux.intel.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "jslaby@suse.cz" <jslaby@suse.cz>, "prarit@redhat.com" <prarit@redhat.com>, Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>, Peter Zijlstra <peterz@infradead.org>
List-Id: linux-serial@vger.kernel.org

On 2015/07/29 22:35, Thomas Gleixner wrote:
> On Wed, 29 Jul 2015, Peter Hurley wrote:
>> On 07/29/2015 07:53 AM, Thomas Gleixner wrote:
>>> On Wed, 29 Jul 2015, Peter Hurley wrote:
>>>> On 07/29/2015 06:32 AM, Thomas Gleixner wrote:
>>>>> On Wed, 29 Jul 2015, Taichi Kageyama wrote:
>>>>>> - Keep interrupt disabled on the CPU which is used to detect 
>>>>>>   an interrupt during the timeout of autoconfig_irq().
>>>>>>      + Kick printk() on the CPU which detects interrupt 
>>>>>>        from a console serial port.
>>>>>
>>>>> This is wrong to begin with. How is that supposed to work on an UP
>>>>> machine? Not at all.
>>>>>
>>>>> So no, fix the code which has interrupts disabled accross autoprobing
>>>>> and do not try to apply bandaids somewhere else.
>>>>
>>>> Like printk() from some unrelated driver?
>>>
>>> If that's the cause for the wreckage then yes, we need a way to tell
>>> the printk code not to call into the driver until that initialization
>>> step is done. It's that simple.
>>
>> Like this?
> 
> Looks about right.


Thomas,
Thank you for your comments.
The status of interrupt disabled should be short,
but it cannot be controlled from autorpobing side.
That's why I was thinking fixing autoprobing itself was better.

However, I remember Peter also mentioned about your idea first.
OK, I change my mind to fix the real problem simply.
I actually have seen the problem caused only by "printk()" on RHEL.


Peter,
I know your code is sample (console.h is required), 
but it is conflict with [patch v2 1/3].
I think serial8250_console_write should not touch ctrl reg during autoconfig_irq. 
To resolve the real problem, I think keeping only [patch v2 1/3] is best(opt1).
What do you think?

opt1. keep [patch v2 1/3]
    + Don't touch other legacy drivers using autoprobe.
       Each driver can use console_lock to fix this problem if it happens.

opt2. fix probe_irq_on/mask/off for all legacy devices which use them
    + Discard [patch v2 1/3]
    + Fix autoconfig_irq and probe_irq_*
    + Test for all these drivers is required.
      --> Probably, it works but I cannot test them.


Thanks,
Taichi



>  
>> --- >% --
>> Subject: [PATCH] genirq: Disable printk() during irq probe
>>
>> printk() disables interrupts for extended periods of time while
>> outputting to console drivers. This breaks irq probing since the
>> triggered irq may not be serviced (in time) if scheduled on the
>> printk() cpu.
>>
>> Claim the console_lock() which effectively disables console output.
>>
>> Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
>> ---
>>  kernel/irq/autoprobe.c | 9 +++++++++
>>  1 file changed, 9 insertions(+)
>>
>> diff --git a/kernel/irq/autoprobe.c b/kernel/irq/autoprobe.c
>> index 0119b9d..47535d2 100644
>> --- a/kernel/irq/autoprobe.c
>> +++ b/kernel/irq/autoprobe.c
>> @@ -39,6 +39,13 @@ unsigned long probe_irq_on(void)
>>  	 */
>>  	async_synchronize_full();
>>  	mutex_lock(&probing_active);
>> +
>> +	/*
>> +	 * printk() breaks irq probing - disable printk output until probe
>> +	 * completes
>> +	 */
>> +	console_lock();
>> +
>>  	/*
>>  	 * something may have generated an irq long ago and we want to
>>  	 * flush such a longstanding irq before considering it as spurious.
>> @@ -132,6 +139,7 @@ unsigned int probe_irq_mask(unsigned long val)
>>  		}
>>  		raw_spin_unlock_irq(&desc->lock);
>>  	}
>> +	console_unlock();
>>  	mutex_unlock(&probing_active);
>>  
>>  	return mask & val;
>> @@ -174,6 +182,7 @@ int probe_irq_off(unsigned long val)
>>  		}
>>  		raw_spin_unlock_irq(&desc->lock);
>>  	}
>> +	console_unlock();
>>  	mutex_unlock(&probing_active);
>>  
>>  	if (nr_of_irqs > 1)
>> -- 
>> 2.5.0
>>
>>
