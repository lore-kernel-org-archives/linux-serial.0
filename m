From: David Cohen <david.a.cohen@linux.intel.com>
Subject: Re: [PATCH 2/2] mrst_max3110: fix SPI UART interrupt parameters
Date: Tue, 22 Oct 2013 13:30:40 -0700
Message-ID: <5266E070.2060408@linux.intel.com>
References: <1382470930-13807-1-git-send-email-david.a.cohen@linux.intel.com> <1382470930-13807-2-git-send-email-david.a.cohen@linux.intel.com> <1382471160.205404749@f402.i.mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:25864 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754676Ab3JVU03 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 22 Oct 2013 16:26:29 -0400
In-Reply-To: <1382471160.205404749@f402.i.mail.ru>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alexander Shiyan <shc_work@mail.ru>
Cc: gregkh@linuxfoundation.org, jslaby@suse.cz, ning.li@intel.com, ivan.gorinov@intel.com, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org

On 10/22/2013 12:46 PM, Alexander Shiyan wrote:
>> The change in the max3110 driver makes the IRQ handling threaded, now
>> the handler is called only once per received character. Without that
>> change, we had many (more than 100) interrupts per one received
>> character.
>>
>> Unfortunately, SFI interface does not support IRQ polarity and
>> triggering modes, so we have to keep the hacks as hard-coded device
>> names and IRQ numbers until we switch to ACPI.
>>
>> Edge-triggered IRQ still supported to keep old platforms working.
>> Use platform data to pass the irq mode argument.
>>
>> Signed-off-by: Ivan Gorinov <ivan.gorinov@intel.com>
>> Signed-off-by: Li Ning <ning.li@intel.com>
>> Signed-off-by: David Cohen <david.a.cohen@linux.intel.com>
> ...
>> +++ b/include/linux/serial_max3110.h
>> @@ -0,0 +1,16 @@
>> +#ifndef _LINUX_SERIAL_MAX3110_H
>> +#define _LINUX_SERIAL_MAX3110_H
>> +
>> +/**
>> + * struct plat_max3110 - MAX3110 SPI UART platform data
>> + * @irq_edge_trigger: if IRQ is edge triggered
>> + *
>> + * You should use this structure in your machine description to specify
>> + * how the MAX3110 is connected.
>> + *
>> + */
>> +struct plat_max3110 {
>> +	int irq_edge_triggered;
>> +};
>> +
>> +#endif
>> --
>
> Is just resource->flags for IRQ can be reused for handle such case?

I believe your suggestion makes perfect sense. I'll rework it.

Br, David Cohen
