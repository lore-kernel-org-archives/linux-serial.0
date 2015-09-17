From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH] modify pl011 driver to let it work as wakeup source
Date: Thu, 17 Sep 2015 12:29:29 +0100
Message-ID: <55FAA419.4000509@arm.com>
References: <1442478716-7377-1-git-send-email-zhaoyang.huang@linaro.org>
 <55FA9852.9030704@arm.com>
 <CAN2waFt+OsiBP_TJ7cw0RAkaNgT5nWRPppe74mfr6A6oSuXdBA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <CAN2waFt+OsiBP_TJ7cw0RAkaNgT5nWRPppe74mfr6A6oSuXdBA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
To: Zhaoyang Huang <zhaoyang.huang@linaro.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "jslaby@suse.com" <jslaby@suse.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "amit.kucheria@linaro.org" <amit.kucheria@linaro.org>, "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>
List-Id: linux-serial@vger.kernel.org



On 17/09/15 12:01, Zhaoyang Huang wrote:
>
>
> On 17 September 2015 at 18:39, Sudeep Holla <sudeep.holla@arm.com
> <mailto:sudeep.holla@arm.com>> wrote:
>
>
>
>     On 17/09/15 09:31, Zhaoyang Huang wrote:
>
>         the commit use the latest dev_pm_set_wake_irq API instead
>         of the enable_irq_wake and IRQF_NO_SUSPEND to configure the
>         ttyAMA device to work as the wakeup source
>
>
>     As I mentioned earlier[1], if this a based on Juno platform, then
>     it gets NACK. Please add this feature when it's needed on a real
>     platform on which hardware supports UART/PL011 as a wake source.
>
>     Do you have any such platform to test ? On Juno, it can't be used as
>     wakeup source.
>
>     Regards,
>     Sudeep
>
>     [1] https://www.marc.info/?l=linux-pm&m=144239396227080&w=2
>
> Hi Sudeep,
> I think the wakeup source you mean is restricted to the device which can
> wake S2R. However, I think the S2I should be also considered, which need
> not the hardware support for powering the core up, but just need the isr
> to be keep active etc.

Hmm, I disagree as we have single control for wakeup and what if you
have enabled PL011 as wakeup and S2R is entered assuming there's one
active wakeup anyway. IMO w.r.t wakeup source we *must* assume it also
wakes up from S2R state always.

You didn't answer to my earlier query, why didn't you choose other
interrupts like ethernet, gpio or just pick one from the lot of
interrupts on Juno as wakeup from S2I. What was the rationale behind
your choice especially on Juno ? Just because you can send and receive
chars via the tty/console, what if I don't have access to console.
We need much better and hardware supported wakeup source like RTC or GPIO.

Also a SoC can enter deeper idle states in S2I where UART can't wakeup.
How would you know that ? I re-iterate that hardware should have support
to ensure it can wakeup the system.

Regards,
Sudeep
