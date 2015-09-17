From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH] modify pl011 driver to let it work as wakeup source
Date: Thu, 17 Sep 2015 11:39:14 +0100
Message-ID: <55FA9852.9030704@arm.com>
References: <1442478716-7377-1-git-send-email-zhaoyang.huang@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <1442478716-7377-1-git-send-email-zhaoyang.huang@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
To: Zhaoyang Huang <zhaoyang.huang@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "jslaby@suse.com" <jslaby@suse.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>, "amit.kucheria@linaro.org" <amit.kucheria@linaro.org>, "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>
List-Id: linux-serial@vger.kernel.org



On 17/09/15 09:31, Zhaoyang Huang wrote:
> the commit use the latest dev_pm_set_wake_irq API instead
> of the enable_irq_wake and IRQF_NO_SUSPEND to configure the
> ttyAMA device to work as the wakeup source
>

As I mentioned earlier[1], if this a based on Juno platform, then
it gets NACK. Please add this feature when it's needed on a real
platform on which hardware supports UART/PL011 as a wake source.

Do you have any such platform to test ? On Juno, it can't be used as
wakeup source.

Regards,
Sudeep

[1] https://www.marc.info/?l=linux-pm&m=144239396227080&w=2
