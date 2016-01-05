From: Timur Tabi <timur@codeaurora.org>
Subject: Re: [PATCH v4 3/3] serial: amba-pl011: add ACPI support to AMBA probe
Date: Tue, 5 Jan 2016 10:23:08 -0600
Message-ID: <568BEDEC.5010101@codeaurora.org>
References: <1450880383-29560-1-git-send-email-aleksey.makarov@linaro.org>
 <1450880383-29560-4-git-send-email-aleksey.makarov@linaro.org>
 <CAOZdJXUpjWi7Dy=GFi7_58FqD_UZxxrw_QKJ4sdHLKVOLCyNAA@mail.gmail.com>
 <CAGCh1+ksWFLkE8Y_a5SW98tpgGBWdVH5TYJAoS17EExuPd65oQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <CAGCh1+ksWFLkE8Y_a5SW98tpgGBWdVH5TYJAoS17EExuPd65oQ@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: G Gregory <graeme.gregory@linaro.org>
Cc: Aleksey Makarov <aleksey.makarov@linaro.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Russell King <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andy Shevchenko <andy.shevchenko@gmail.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, lkml <linux-kernel@vger.kernel.org>, Vladimir Zapolskiy <vz@mleia.com>, Shannon Zhao <shannon.zhao@linaro.org>, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

G Gregory wrote:
>> >I'm confused by this patch.  We already have code like this in
>> >tty-next, in the form of sbsa_uart_probe():
>> >
>> >https://kernel.googlesource.com/pub/scm/linux/kernel/git/gregkh/tty/+/tty-next/drivers/tty/serial/amba-pl011.c#2553
>> >
> Because Russell expressed unhappiness at that code existing. So this
> is an alternative method to do same thing with ACPI.

FYI, this patch doesn't apply on tty-next as-is, so it would need to be 
updated anyway.  Then again, considering the latest drama with that 
driver, who knows what it will look like?

> If the "arm,sbsa-uart" id was added to drivers/of/platform.c as an
> AMBA id then the same could be done for DT as well.
>
> Ultimately this patch is optional depending on maintainers opinion!

So with this patch, what is the difference between sbsa_uart_probe and 
pl011_probe?  Shouldn't the patch also remove sbsa_uart_probe?
