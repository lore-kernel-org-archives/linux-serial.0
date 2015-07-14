From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH 2/2] serial: 8250: Allow to skip autoconfig_irq() for
 a console
Date: Tue, 14 Jul 2015 15:29:23 -0400
Message-ID: <55A56313.4050703@hurleysoftware.com>
References: <55717224.9060104@cp.jp.nec.com> <557173EC.5000307@cp.jp.nec.com> <559D0FCC.5040107@hurleysoftware.com> <559D1D39.9070405@redhat.com> <559D2AE8.8080603@hurleysoftware.com> <559D2CFB.1060507@redhat.com> <559E075F.8040800@cp.jp.nec.com> <55A05F56.90305@hurleysoftware.com> <55A462D1.3080709@cp.jp.nec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <55A462D1.3080709@cp.jp.nec.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Taichi Kageyama <t-kageyama@cp.jp.nec.com>, Prarit Bhargava <prarit@redhat.com>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "jslaby@suse.cz" <jslaby@suse.cz>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
List-Id: linux-serial@vger.kernel.org

Hi Taichi,

On 07/13/2015 09:16 PM, Taichi Kageyama wrote:
> On 2015/07/11 9:12, Peter Hurley wrote:
>> On 07/09/2015 01:32 AM, Taichi Kageyama wrote:
>>> On 2015/07/08 23:00, Prarit Bhargava wrote:
>>>> On 07/08/2015 09:51 AM, Peter Hurley wrote:
>>>>> On 07/08/2015 08:53 AM, Prarit Bhargava wrote:
>>>>>> On 07/08/2015 07:55 AM, Peter Hurley wrote:
>>>>>>> On 06/05/2015 06:03 AM, Taichi Kageyama wrote:
>>>>>>>> This patch provides a new parameter as a workaround of the following
>>>>>>>> problem. It allows us to skip autoconfig_irq() and to use a well-known irq
>>>>>>>> number for a console even if CONFIG_SERIAL_8250_DETECT_IRQ is defined.
>>>>>>>>
>>>>>>>> There're cases where autoconfig_irq() fails during boot.
>>>>>>>> In these cases, the console doesn't work in interrupt mode,
>>>>>>>> the mode cannot be changed anymore, and "input overrun"
>>>>>>>> (which can make operation mistakes) happens easily.
>>>>>>>> This problem happens with high rate every boot once it occurs
>>>>>>>> because the boot sequence is always almost same.
>>>>>>>>
>>>>>>>> autoconfig_irq() assumes that a CPU can handle an interrupt from a serial
>>>>>>>> during the waiting time, but there're some cases where the CPU cannot
>>>>>>>> handle the interrupt for longer than the time. It completely depends on
>>>>>>>> how other functions work on the CPU. Ideally, autoconfig_irq() should be
>>>>>>>> fixed
>>>>>>>
>>>
>>> Thank you for your comments.
>>>
>>>>>>> It completely depends on how long some other driver has interrupts disabled,
>>>
>>> Agree.
>>>
>>>>>>> which is a problem that needs fixed _in that driver_. autoconfig_irq() does not
>>>>>>> need fixing.
>>>
>>> Peter, ideally, you're right.
>>> However, we cannot assume how long other drivers disable interrupts.
>>> That's why I introduced this workaround.
>>> In my opinion, a console is important and always should be available
>>> even if other drivers have a bad behavior.
>>
>> I have no problem with wanting to make the console more robust, but
>> rather with the hacky way this is being done.
> 
> Hi Peter,
> 
> Thank you for your advice.
> If there is other way to fix this problem simply,
> I also think it's better than the dirty hack.

While module parameters seem like "simple" solutions at the time,
they add real maintenance burden, because they establish userspace
requirements that must be preserved forever to avoid breakage.


>> Better solutions:
>> 1. Fix autoprobing to force irq affinity to autoprobing cpu
> 
> I couldn't make sure which CPU handled serial interrupt
> on all platforms before irq# was not known.
> Do you know the way to detect which CPU is used for console serial?


The basic idea would be:
1. disable preemption
2. for each irq descriptor selected for autoprobing, set the irq
   affinity to the current processor.
3. probe the i/o port as is done now
4. stop probing
5. re-enable preemption.

With this solution, your patch 1/2 wouldn't be required either
because the worker thread that disabled interrupts wouldn't be
running on the cpu detecting the triggered irq(s).

I would imagine most or all of this would be done in
probe_irq_on(), possibly refactored to perform the preemption
disable and irq affinity.


> The way is safe for all platforms?

Please understand though, autoprobing is not safe, period.
Even says so in Kconfig.


>> 2. Fix how the 8250 driver behaves with no irq
> 
> The console works with polling-mode if irq==0.
> I think this behavior should not be changed.

So another solution would be to use setserial to set the irq during
boot, right?


>> 3. Fix printk locking to be more granular (this needs doing anyway)
>> 4. Add exclusive port mode for console
> 
> These two are solutions only for the problem which is caused by printk.
> I think my [patch 1/2] is enough to resolve the case at this time.
> 
>> Plus it wouldn't hurt to add some diagnostics to automate discovery
>> of misbehaving drivers that break autoprobing.
> 
> Probably we can add retry code, but it cannot fix this problem completely.
> And the retry can be just waste time for some devices because the driver
> cannot recognize whether interrupt is disabled temporarily or
> interrupt mode is not available as long as using probe_irq_on/off().
> 
> I though other workarounds, but they were also not good idea.
>   + Close all console sessions to kick autoconfig again
>       Console is always opened by getty or other programs after boot.
>       It's hard to close them. I think the driver should be fixed.
>   + Call autoconfig by force even if console is opened.
>       It can be called forcibly if uart_do_autoconfig() is changed,
>       but I think console should not be used by userland during autoconfig
>       although it is always used by printk...

Yeah, none of these workarounds seem appropriate.

Regards,
Peter Hurley
